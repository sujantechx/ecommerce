import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



// --- 1. Data Model and Enum ---
// An enum makes it safer to handle different order statuses.
enum OrderStatus { completed, pending, cancelled }

// A simple model class to represent a single order item.
class OrderModel {
  final String productName;
  final double price;
  final int quantity;
  final String imageUrl;
  final OrderStatus status;

  OrderModel({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.status,
  });
}

// --- 2. The Order History Page Widget ---
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  // --- 3. Dummy Data ---
  // A hardcoded list of orders to build the UI.
  final List<OrderModel> _allOrders = [
    OrderModel(productName: 'iPhone 14 Pro Max', price: 504.80, quantity: 1, imageUrl: 'https://www.aptronixindia.com/media/catalog/product/cache/31f0162e65c6816d8517bb801c5f32a3/i/p/iphone_14_pro_deep_purple_pdp_image_position-1a_avail__en-in-removebg-preview.png', status: OrderStatus.pending),
    OrderModel(productName: 'Samsung Galaxy S23', price: 799.99, quantity: 1, imageUrl: 'https://images.samsung.com/is/image/samsung/p6pim/in/2302/gallery/in-galaxy-s23-s911-446733-sm-s911bzkbins-534857478?650_519_PNG', status: OrderStatus.completed),
    OrderModel(productName: 'iPhone 14 Pro Max', price: 504.80, quantity: 2, imageUrl: 'https://www.aptronixindia.com/media/catalog/product/cache/31f0162e65c6816d8517bb801c5f32a3/i/p/iphone_14_pro_deep_purple_pdp_image_position-1a_avail__en-in-removebg-preview.png', status: OrderStatus.completed),
    OrderModel(productName: 'Google Pixel 7', price: 599.00, quantity: 1, imageUrl: 'https://storage.googleapis.com/gweb-uniblog-publish-prod/original_images/Pixel_7_Pro_-_Hazel_1.jpg', status: OrderStatus.cancelled),
    OrderModel(productName: 'iPhone 14 Pro Max', price: 504.80, quantity: 1, imageUrl: 'https://www.aptronixindia.com/media/catalog/product/cache/31f0162e65c6816d8517bb801c5f32a3/i/p/iphone_14_pro_deep_purple_pdp_image_position-1a_avail__en-in-removebg-preview.png', status: OrderStatus.pending),
    OrderModel(productName: 'OnePlus 11', price: 699.00, quantity: 1, imageUrl: 'https://oasis.op-mobile.opera.com/op/pano_20230207_164801_0_000_3338_1920_e2e423.png', status: OrderStatus.completed),
    OrderModel(productName: 'iPhone 14 Pro Max', price: 504.80, quantity: 3, imageUrl: 'https://www.aptronixindia.com/media/catalog/product/cache/31f0162e65c6816d8517bb801c5f32a3/i/p/iphone_14_pro_deep_purple_pdp_image_position-1a_avail__en-in-removebg-preview.png', status: OrderStatus.cancelled),
  ];

  // State variable to keep track of the selected filter.
  OrderStatus _selectedStatus = OrderStatus.pending;

  @override
  Widget build(BuildContext context) {
    // Filter the list of orders based on the selected status.
    final filteredOrders = _allOrders.where((order) => order.status == _selectedStatus).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Order History",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // The filter bar for "Completed", "Pending", "Cancel"
          _buildFilterChips(),
          const SizedBox(height: 16),
          // The list of order items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return _buildOrderItemCard(filteredOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the filter chip bar.
  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterChip("Completed", OrderStatus.completed),
          _buildFilterChip("Pending", OrderStatus.pending),
          _buildFilterChip("Cancel", OrderStatus.cancelled),
        ],
      ),
    );
  }

  /// Builds a single, styled filter chip.
  Widget _buildFilterChip(String label, OrderStatus status) {
    bool isSelected = _selectedStatus == status;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedStatus = status;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? _getColorForStatus(status) : Colors.white,
            foregroundColor: isSelected ? Colors.white : Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: isSelected ? 2 : 0,
          ),
          child: Text(label),
        ),
      ),
    );
  }

  /// Builds a card for a single order item.
  Widget _buildOrderItemCard(OrderModel order) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                order.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 70),
              ),
            ),
            const SizedBox(width: 16),
            // Product Name and Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.productName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${order.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            // Quantity and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Quantity: ${order.quantity}",
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                _getStatusChip(order.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns a styled chip for the order status.
  Widget _getStatusChip(OrderStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getColorForStatus(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.name[0].toUpperCase() + status.name.substring(1), // Capitalizes the enum name
        style: TextStyle(
          color: _getColorForStatus(status),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  /// Helper function to get a color based on the order status.
  Color _getColorForStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}