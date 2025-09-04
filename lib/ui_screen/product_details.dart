import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetails();
}

class _ProductDetails extends State<ProductDetails> {
  final _pageController = PageController();
  int _quantity = 1;
  int _selectedColorIndex = 1;
  int _selectedTabIndex = 0;

  final List<Color> _colors = [
    const Color(0xFFB73B4A),
    Colors.black,
    const Color(0xFF2B5A9D),
    const Color(0xFF976332),
    const Color(0xFFE3E3E3),
  ];

  final List<String> _productImages = [
    "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80"
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageCarousel(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductDetails(),
                    const SizedBox(height: 20),
                    _buildColorSelector(),
                    const SizedBox(height: 20),
                    _buildInfoTabs(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  /// Builds the top section with the image carousel and action buttons.
  Widget _buildImageCarousel() {
    return Stack(
      children: [
        // Image PageView
        Container(
          height: 350,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _productImages.length,
            itemBuilder: (context, index) {
              return Image.network(
                _productImages[index],
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        // Top action buttons (Back, Share, Favorite)
        Positioned(
          top: 15,
          left: 15,
          right: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIconButton(CupertinoIcons.back, () => Navigator.pop(context)),
              Row(
                children: [
                  _buildIconButton(CupertinoIcons.share, () {}),
                  const SizedBox(width: 10),
                  _buildIconButton(CupertinoIcons.heart, () {}),
                ],
              ),
            ],
          ),
        ),
        // Page indicator dots
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _productImages.length,
              effect: const WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.black87,
                dotColor: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the product title, price, seller, and rating section.
  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wireless Headphone',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '\$520.00',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Seller: Tariqul isalm',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 5),
            const Text(
              '4.8',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(width: 5),
            const Text(
              '(320 Review)',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the color selection swatches.
  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(_colors.length, (index) {
            bool isSelected = _selectedColorIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedColorIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: _colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.orange : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: _colors[index].withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                  ]
                      : [],
                ),
                child: Container(
                  width: 35,
                  height: 35,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _colors[index],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// Builds the Description, Specifications, and Reviews tabs and content.
  Widget _buildInfoTabs() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabItem(0, "Description"),
            _buildTabItem(1, "Specifications"),
            _buildTabItem(2, "Reviews"),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'Lorem ipsum dolor sit amet consectetur. Placerat in semper vitae a. Blandit amet purus eget sed vitae morbi tellus. Integer ornare. Purus risus urna sed fermentum. Neque dolor tempus egestas nunc volutpat ullamcorper aliquam velit.',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Builds an individual tab item.
  Widget _buildTabItem(int index, String title) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Builds the floating bottom bar with quantity selector and Add to Cart button.
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          // Quantity Selector
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(CupertinoIcons.minus),
                  onPressed: () {
                    if (_quantity > 1) setState(() => _quantity--);
                  },
                ),
                Text(
                  _quantity.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.add),
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          // Add to Cart Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to build circular icon buttons for the top bar.
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }
}