import 'package:ecommerce/dashbord/provider/provider_nav.dart';
import 'package:ecommerce/ui_screen/catlog.dart';
import 'package:ecommerce/ui_screen/favourite.dart';
import 'package:ecommerce/ui_screen/home.dart';
import 'package:ecommerce/ui_screen/menu_dash.dart';
import 'package:ecommerce/ui_screen/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBord extends StatefulWidget {
  const DashBord({super.key});

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  // int selectedNavIndex=0;
  List<Widget> mNavPages=[
    MenuDash(),
    Favourite(),
    Home(),
    Catlog(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderNav>(
        builder:(_,provider,__){
          return Scaffold(
            body: mNavPages[provider.getCurentPageIndex()],
            bottomNavigationBar: BottomNavigationBar(
                elevation: 11,
                iconSize: 25,
                showSelectedLabels: false,
                currentIndex: provider.getCurentPageIndex(),
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.grey,
                onTap: (index) {
                  // selectedNavIndex=index;
                  setState(() {

                  });
                  provider.updatePageIndex(index: index);
                },

                items: [
                  BottomNavigationBarItem(activeIcon: Icon(Icons.category_outlined),label: "Category",icon: Icon(Icons.category),),
                  BottomNavigationBarItem(activeIcon: Icon(Icons.favorite_border_outlined),label: "Favorite",icon: Icon(Icons.favorite_border),),
                  BottomNavigationBarItem(activeIcon: Icon(Icons.home),label: "Home",icon: Icon(Icons.home_outlined),),
                  BottomNavigationBarItem(activeIcon: Icon(Icons.shopping_cart_rounded),label: "Home",icon: Icon(Icons.shopping_cart),),
                  BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),

                ]

            ),

          );

        }
    );

  }
}
/* BottomNavigationBarItem(icon: Container(
                      width: 50,height: 50,
                      decoration:BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5)) ,
                      child: Icon(Icons.add)),label: "Add"),*/
