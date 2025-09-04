import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class Catlog extends StatefulWidget {
  const Catlog({super.key});

  @override
  State<Catlog> createState() => _Catlog();
}

class _Catlog extends State<Catlog> {
  final List<CartItem> _cartItems = [
    CartItem(name: "Woman Sweater", category: "Woman Fashion", price: 70.00, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaUW_iC9HrJ1wzvx4kgNYlewfmafMAiyZuKWUajIGDYpWxYgAcAhbVn9FqJwBjrV9-bmo&usqp=CAU"),
    CartItem(name: "Smart Watch", category: "Electronics", price: 55.00, imageUrl: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80"),
    CartItem(name: "Wireless Headphone", category: "Electronics", price: 120.00, imageUrl: "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500&q=80"),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate totals every time the UI rebuilds.
    double subtotal = _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          //  List of Cart Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItemCard(_cartItems[index]);
              },
            ),
          ),
          //  Checkout Section
          _buildCheckoutSection(subtotal, currencyFormat),
        ],
      ),
    );
  }


  /// Builds a single card for a cart item.
  Widget _buildCartItemCard(CartItem item) {
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
              child: Image.network(item.imageUrl, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(item.category, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Text(
                  NumberFormat.currency(locale: 'en_US', symbol: '\$').format(item.price),
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
              IconButton(
                icon: Icon(CupertinoIcons.delete, color: Colors.red[400], size: 20),
                onPressed: () {
                  setState(() {
                    _cartItems.remove(item);
                  });
                },
              ),
              const SizedBox(height: 8),
              _buildQuantitySelector(item),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the quantity selector for an item.
  Widget _buildQuantitySelector(CartItem item) {
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
              if (item.quantity > 1) {
                setState(() {
                  item.quantity--;
                });
              }
            },
          ),
          Text(item.quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            iconSize: 16,
            splashRadius: 16,
            icon: const Icon(CupertinoIcons.add),
            onPressed: () {
              setState(() {
                item.quantity++;
              });
            },
          ),
        ],
      ),
    );
  }

  /// Builds the bottom section with totals and the checkout button.
  Widget _buildCheckoutSection(double subtotal, NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.all(24.0),
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
            decoration: InputDecoration(
              hintText: 'Enter Discount Code',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              suffixIcon: TextButton(
                onPressed: () {},
                child: const Text('Apply', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Totals
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(currencyFormat.format(subtotal), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(currencyFormat.format(subtotal), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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