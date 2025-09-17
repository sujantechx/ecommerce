
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../domain/Utils/coupon_service.dart';
import '../model/cart_model.dart';
// Data Model
class CartItem {
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
// --- ADD THESE NEW STATE VARIABLES ---
  final _couponService = CouponService();
  final _couponController = TextEditingController();
  Coupon? _appliedCoupon;
  String? _couponError;
  bool _isApplyingCoupon = false;

  // --- ADD THIS NEW METHOD TO HANDLE THE LOGIC ---
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
        _appliedCoupon = null; // Clear any previously applied coupon
        _couponError = "Invalid coupon code";
      }
      _isApplyingCoupon = false;
    });
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Calculate totals every time the UI rebuilds.
    /* double subtotal = _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');*/

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        //leading: const BackButton(color: Colors.black),
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          //  List of Cart Items
          Expanded(
            child:BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        // --- DEFINE ALL FINANCIAL VARIABLES HERE ---
        double subtotal = 0;
        double discount = 0;
        double total = 0;
        final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

        if (state is CartSuccessState && state.cartList != null && state.cartList!.isNotEmpty) {
          // 1. Calculate Subtotal
          subtotal = state.cartList!.fold(0.0, (sum, item) => sum + (double.parse(item.price!) * item.quantity!));

          // 2. Calculate Discount based on the applied coupon
          if (_appliedCoupon != null) {
            if (_appliedCoupon!.type == DiscountType.percentage) {
              discount = subtotal * (_appliedCoupon!.value / 100);
            } else {
              discount = _appliedCoupon!.value;
            }
          }

          // 3. Calculate Final Total (ensure it doesn't go below zero)
          total = (subtotal - discount).clamp(0, double.infinity);
        }

        // --- BUILD THE UI ---
        return Column(
          children: [
            Expanded(
              child: () {
                if (state is CartLoadingState) return const Center(child: CircularProgressIndicator());
                if (state is CartFailureState) return Center(child: Text(state.errorMsg));
                if (state is CartSuccessState) {
                  return state.cartList != null && state.cartList!.isNotEmpty
                      ?                           ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: state.cartList!.length,
                    itemBuilder: (context, index) {
                      return _buildCartItemCard(state.cartList![index]);
                    },
                  )
                  // Your existing ListView
                      : const Center(child: Text("No items in cart"));
                }
                return const SizedBox.shrink();
              }(),
            ),
            // Pass all calculated values to the checkout section
            _buildCheckoutSection(subtotal, discount as double, total, currencyFormat),
          ],
        );
      },
      ),),
        ],
      ),
    );
  }


  /// Builds a single card for a cart item.
  Widget _buildCartItemCard(CartModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(item.image!, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                /* const SizedBox(height: 4),
                Text(item., style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                */const SizedBox(height: 8),
                Text(
                  NumberFormat.currency(locale: 'en_US', symbol: '\$').format(double.parse(item.price!)),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             /* IconButton(
                icon: Icon(CupertinoIcons.delete, color: Colors.orange, size: 20),
                onPressed: () {
                  setState(() {
                    _cartItems.remove(item);
                  });
                },
              ),*/
              const SizedBox(height: 8),
              _buildQuantitySelector(item),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the quantity selector for an item.
  Widget _buildQuantitySelector(CartModel item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 16,
            splashRadius: 16,
            icon: const Icon(CupertinoIcons.minus),
            onPressed: () {
              // Dispatch the decrement event
              context.read<CartBloc>().add(UpdateCartQuantityEvent(item: item, action: "decrement"));

            },
          ),
          // Show a small loader while re-fetching
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadingState) {
                // Check if the loading state was triggered by this specific item's update
                // This is an advanced check; for now, a general indicator is fine.
                return const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }
              return Text(item.quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold));
            },
          ),
          IconButton(
            iconSize: 16,
            splashRadius: 16,
            icon: const Icon(CupertinoIcons.add),
            onPressed: () {
              // Dispatch the increment event
              context.read<CartBloc>().add(UpdateCartQuantityEvent(item: item, action: "increment"));
            },

          ),
        ],
      ),
    );
  }

  /// Builds the bottom section with totals and the checkout button.
  Widget _buildCheckoutSection(double subtotal, double discount, double total, NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0, bottom: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Discount Code
          TextField(
            controller: _couponController,
            decoration: InputDecoration(
              hintText: 'Enter Discount Code',
              errorText: _couponError, // Display error message here
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
              suffixIcon: TextButton(
                onPressed: _applyCoupon, // Call our new method
                child: _isApplyingCoupon
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Apply', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Totals
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(currencyFormat.format(subtotal), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 5),
          // Conditionally show the Discount row
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
          // Final Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(currencyFormat.format(total), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                elevation: 0,
              ),
              child: const Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}