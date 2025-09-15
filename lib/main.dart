import 'package:ecommerce/bloc/product/product_bloc.dart';
import 'package:ecommerce/bloc/user/user_bloc.dart';
import 'package:ecommerce/data/remote/helper/api_helper.dart';
import 'package:ecommerce/data/remote/repository/products_repository.dart';
import 'package:ecommerce/data/remote/repository/user_repo.dart';
import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


void main()  {
  runApp(MultiProvider(providers: [
    BlocProvider(create: (context) => UserBloc(
        userRepository: UserRepository(
            apiHelper: ApiHelper())),),
    BlocProvider(create:(context) => ProductBloc(productRepository: ProductRepository(apiHelper: ApiHelper())),)

  ],child:  MyApp(),));

}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'E-commerce',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes:AppRoutes.routes ,
    );
  }
}