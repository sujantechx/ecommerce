import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/oder/order_bloc.dart';
import '../bloc/oder/order_event.dart';
import '../bloc/oder/order_state.dart';
import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_state.dart';
import '../domain/Utils/coupon_service.dart';
import '../model/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // State variables for coupon management
  final _couponService = CouponService();
  final _couponController = TextEditingController();
  Coupon? _appliedCoupon;
  String? _couponError;
  bool _isApplyingCoupon = false;

  @override
  void initState() {
    super.initState();
    // Fetch cart items when the screen is first loaded
    context.read<CartBloc>().add(FetchCartEvent());
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  /// Handles the logic for validating and applying a coupon code.
  void _applyCoupon() async {
    if (_isApplyingCoupon) return;
    setState(() {
      _isApplyingCoupon = true;
      _couponError = null;
    });

    final code = _couponController.text;
    final coupon = await _couponService.validateCoupon(code);

    setState(() {
      if (coupon != null) {
        _appliedCoupon = coupon;
      } else {
        _appliedCoupon = null;
        _couponError = "Invalid coupon code";
      }
      _isApplyingCoupon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          // Handle Loading and Error states for the cart
          if (cartState is CartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (cartState is CartFailureState) {
            return Center(child: Text(cartState.errorMsg));
          }
          // Handle Success state, including an empty cart
          if (cartState is CartSuccessState) {
            if (cartState.cartList == null || cartState.cartList!.isEmpty) {
              return const Center(child: Text("Your cart is empty"));
            }
            // If cart has items, build the main content
            return _buildCartContent(cartState.cartList!);
          }
          // Fallback for the initial state
          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// Builds the main UI when the cart is loaded with items.
  Widget _buildCartContent(List<CartModel> cartList) {
    // 1. Extract the list of product IDs from the cart items
    final productIds = cartList.map((item) => item.productId as int).toList();
    String userId = '';
    final userState = context.read<UserBloc>().state;
    if (userState is UserProfileLoadedState && userState.user.id != null && userState.user.id.isNotEmpty) {
      userId = userState.user.id;
    }
    print('User ID: $userId'); // Print userId to console for debugging

    return Column(
      children: [
        // List of cart items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: cartList.length,
            itemBuilder: (context, index) {
              return _buildCartItemCard(cartList[index]);
            },
          ),
        ),
        // Only build if we successfully got a userId
        if (userId.isNotEmpty) ...[
          // Text('User ID: $userId', style: const TextStyle(color: Colors.blue)),
          _buildCheckoutSection(cartList, productIds.cast<int>(), userId),
        ]
      ],
    );
  }

  /// Builds the UI for a single item in the cart list.
  Widget _buildCartItemCard(CartModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(item.image!, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  NumberFormat.currency(locale: 'en_US', symbol: '\₹').format(double.parse(item.price!)),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildQuantitySelector(item),
        ],
      ),
    );
  }

  /// Builds the interactive +/- quantity selector.
  Widget _buildQuantitySelector(CartModel item) {
    return Container(
      height: 35,
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 16,
            splashRadius: 16,
            icon: const Icon(CupertinoIcons.minus),
            onPressed: () {
              if (item.quantity! > 1) {
                context.read<CartBloc>().add(UpdateCartQuantityEvent(item: item, action: "decrement"));
              } else {
                context.read<CartBloc>().add(RemoveFromCartEvent(cartItemId: item.id.toString()));
              }
            },
          ),
          Text(item.quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          IconButton(
            iconSize: 16,
            splashRadius: 16,
            icon: const Icon(CupertinoIcons.add),
            onPressed: () {
              context.read<CartBloc>().add(UpdateCartQuantityEvent(item: item, action: "increment"));
            },
          ),
        ],
      ),
    );
  }

  /// Builds the entire bottom section with coupon, totals, and the checkout button.
  Widget _buildCheckoutSection(List<CartModel> cartList, List<int> productIds, String userId) {
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\₹');
    final subtotal = cartList.fold(0.0, (sum, item) => sum + (double.parse(item.price!) * item.quantity!));
    double discount = 0;
    if (_appliedCoupon != null) {
      discount = _appliedCoupon!.type == DiscountType.percentage
          ? subtotal * (_appliedCoupon!.value / 100)
          : _appliedCoupon!.value;
    }
    final total = (subtotal - discount).clamp(0, double.infinity);
    //  The UI is wrapped in a BlocListener to handle order results
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderPlacedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order placed successfully!'), backgroundColor: Colors.green),
          );
          // Navigate to the home page after a successful order
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
        else if (state is OrderPlacedFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}'), backgroundColor: Colors.red),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 15),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  UI for Coupon and Totals (from your first code snippet)
            TextField(
              controller: _couponController,
              decoration: InputDecoration(
                hintText: 'Enter Discount Code',
                errorText: _couponError,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                suffixIcon: TextButton(
                  onPressed: _applyCoupon,
                  child: _isApplyingCoupon
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Apply', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal', style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text(currencyFormat.format(subtotal), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            if (_appliedCoupon != null) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount (${_appliedCoupon!.code})', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  Text('-${currencyFormat.format(discount)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ],
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(currencyFormat.format(total), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),

            //  Checkout Button with BLoC Logic (from your second code snippet)
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderPlacing) {
                    return ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.withOpacity(0.7),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: const CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<OrderBloc>().add(PlaceOrderEvent(userId: userId, productIds: productIds));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      elevation: 0,
                    ),
                    child: const Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  );
                },
              ),
            ),
            SizedBox(height: 115,)
          ],
        ),
      ),
    );
  }

}

