import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/ui_screen/products_by_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category/category_bloc.dart';
import '../bloc/category/category_event.dart';
import '../bloc/category/category_state.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../domain/constants/app_routes.dart';
import '../model/category_model.dart';
import '../model/products_model.dart';
import '../widgets/app_color_list.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductsEvent(catId: null));
    // Trigger the fetch event when the screen is first loaded
    context.read<CategoryBloc>().add(FetchCategoriesEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(CupertinoIcons.square_grid_2x2)),
        title: const Text("See All"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }
    /// Builds the grid of product cards.
  Widget _buildProductGrid() {
    return BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {

          if(state is ProductLoadingState){
            return const Center(child: CircularProgressIndicator());
          }

          if(state is ProductErrorState){
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
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.productDetails, arguments: product);
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
    return LayoutBuilder(
        builder: (context, constraints) {
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                          ),
                          AppColorList(mColors: [
                            Colors.black,
                            Colors.blue,
                            Colors.orange,
                            Colors.red,
                            Colors.green,
                            Colors.purple,
                            Colors.yellow,
                          ], selectedColorIndex: 0, size: constraints.maxWidth*0.12, fullWidth: false)
                        ],
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
                    width: 40,
                    height: 40,
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}