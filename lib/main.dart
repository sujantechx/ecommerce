import 'package:ecommerce/bloc/cart/cart_bloc.dart';
import 'package:ecommerce/bloc/category/category_bloc.dart';
import 'package:ecommerce/bloc/product/product_bloc.dart';
import 'package:ecommerce/bloc/user/user_bloc.dart';
import 'package:ecommerce/data/remote/helper/api_helper.dart';
import 'package:ecommerce/data/remote/repository/cart_repo.dart';
import 'package:ecommerce/data/remote/repository/category_repository.dart';
import 'package:ecommerce/data/remote/repository/products_repository.dart';
import 'package:ecommerce/data/remote/repository/user_repo.dart';
import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(
    // Use MultiRepositoryProvider to provide dependencies (services, repositories)
    MultiRepositoryProvider(
      providers: [
        // Provide ApiHelper once, so it can be shared.
        RepositoryProvider<ApiHelper>(
          create: (context) => ApiHelper(),
        ),
        // All repositories will now read the single ApiHelper instance.
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(apiHelper: context.read<ApiHelper>()),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(apiHelper: context.read<ApiHelper>()),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepository(apiHelper: context.read<ApiHelper>()),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepository(apiHelper: context.read<ApiHelper>()),
        ),
      ],
      // Use MultiBlocProvider to provide BLoCs that depend on the repositories.
      child: MultiBlocProvider(
        providers: [
          // BLoCs read their respective repositories from the context.
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(userRepository: context.read<UserRepository>()),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(productRepository: context.read<ProductRepository>()),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(cartRepository: context.read<CartRepository>()),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(categoryRepository: context.read<CategoryRepository>()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}