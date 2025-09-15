import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../model/products_model.dart';

// Create simple classes to hold data model
class Category {
  final String name;
  final String icon;
  const Category({required this.name, required this.icon});
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

class Offer {
  final String imageUrl;
  const Offer({required this.imageUrl});
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductsEvent(catId: null));
  }

  //  Data using the models
  final List<Offer> _offers = const [
    Offer(imageUrl:
    "https://static.vecteezy.com/system/resources/previews/008/601/839/non_2x/online-shopping-background-design-free-vector.jpg"
    ),
    Offer(imageUrl:
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBcBC225zFGTXbsgZ_x8I0iy-4jjw0jC9q2g&s"
    ),

  ];

  final List<Category> _categories = const [
    Category(name: "Shoes", icon: "👟"),
    Category(name: "Beauty", icon: "💄"),
    Category(name: "Women's Fashion", icon: "👗"),
    Category(name: "Jewelry", icon: "💍"),
    Category(name: "Men's Fashion", icon: "👕"),
  ];

  // Using a List instead of final to allow `isFavorite` to be changed
  final List<Product> _products = [
    Product(name: "Wireless Headphones", price: 120.00, imageUrl: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80"),
    Product(name: "Woman Sweater", price: 70.00, imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaUW_iC9HrJ1wzvx4kgNYlewfmafMAiyZuKWUajIGDYpWxYgAcAhbVn9FqJwBjrV9-bmo&usqp=CAU"),
    Product(name: "Smart Watch", price: 55.00, imageUrl: "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500&q=80"),
    Product(name: "Sneakers", price: 90.00, imageUrl: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.square_grid_2x2)),
        title: const Text("E-Commerce"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Each part of the UI is now a separate
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildOfferCarousel(),
            const SizedBox(height: 24),
            _buildCategoryList(),
            const SizedBox(height: 24),
            _buildSectionHeader("Special For You", "See all"),
            const SizedBox(height: 12),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  /// Builds the search bar widget.
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search...",
        prefixIcon: const Icon(CupertinoIcons.search),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// Builds the horizontally scrolling offer banner
  Widget _buildOfferCarousel() {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _offers.length,
            itemBuilder: (context, index) {
              final offer = _offers[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  offer.imageUrl,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),

          /*Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _offers.length,
              effect: WormEffect(
                dotColor: Colors.grey.shade400,
                activeDotColor: Colors.white,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 10,
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  /// Builds the horizontally scrolling category list.
  Widget _buildCategoryList() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.orange.shade100,
                  child: Text(category.icon, style: const TextStyle(fontSize: 24)),
                ),
                const SizedBox(height: 6),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds a reusable section header with a title and an action text.
  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(actionText, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }

  /// Builds the grid of product cards.
  Widget _buildProductGrid() {
    return BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {

          if(state is ProductLoadingState){
            return const Center(child: CircularProgressIndicator());
          }

          if(state is ProductFailureState){
            return Center(child: Text(state.errorMsg));
          }

          if(state is ProductLoadedState){
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.mProducts.length,
              itemBuilder: (context, index) {
                final product = state.mProducts[index];
                return InkWell(
                    onTap: () {
                      //Navigator.pushNamed(context, AppRoutes.productDetails);
                    },
                    child: _buildProductCard(product)); // Use a helper for the card UI
              },
            );
          }


          return Container();
        }
    );
  }

  /// Builds a single product card.
  Widget _buildProductCard(ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    product.image ?? "",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name ?? "No Name",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "\$${product.price}",
                  style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          // The favorite button is now interactive.
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  /*setState(() {
                    product.isFavorite = !product.isFavorite;
                  });*/
                },
                icon: Icon(CupertinoIcons.heart,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}