


import 'package:ecommerce/model/user_model.dart';
import 'package:ecommerce/ui_screen/favourite.dart';
import 'package:ecommerce/ui_screen/home.dart';
import 'package:ecommerce/ui_screen/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui_screen/catlog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

// Helper to get token from SharedPreferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  int selectedNavIndex=0;
  List<Widget> mNavPages=[
    Home() ,
    Favourite(),
    Home(),
    CartPage(),
    FutureBuilder<String?>(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return ProfileScreen(token: snapshot.data!);
        }
        return Center(child: CircularProgressIndicator());
      },
    ),  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: mNavPages[selectedNavIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: (){
          selectedNavIndex=2;
          setState(() {

          });
        }, child: Icon(Icons.home, color: Colors.white),),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        elevation: 16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){
              selectedNavIndex=0;
              setState(() {

              });
            }, icon: Icon(selectedNavIndex==0 ? Icons.category : Icons.category_outlined, color: selectedNavIndex==0 ? Colors.orange : Colors.grey,)),
            IconButton(onPressed: (){
              selectedNavIndex=1;
              setState(() {

              });
            }, icon: Icon(selectedNavIndex==1 ? Icons.favorite : Icons.favorite_border, color: selectedNavIndex==1 ? Colors.orange : Colors.grey,)),
            SizedBox(width: 50,),
            IconButton(onPressed: (){
              selectedNavIndex=3;
              setState(() {

              });
            }, icon: Icon(Icons.shopping_cart_outlined, color: selectedNavIndex==3 ? Colors.orange : Colors.grey,)),
            IconButton(onPressed: (){
              selectedNavIndex=4;
              setState(() {

              });
            }, icon: Icon(Icons.person_outline, color: selectedNavIndex==4 ? Colors.orange : Colors.grey,)),
          ],
        ),
        /* iconSize: 25,
          showSelectedLabels: false,
          currentIndex: selectedNavIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            selectedNavIndex=index;
            setState(() {

            });
            //provider.updatePageIndex(index: index);
          },


          items: [
            BottomNavigationBarItem(activeIcon: Icon(Icons.category_outlined),label: "Category",icon: Icon(Icons.category),),
            BottomNavigationBarItem(activeIcon: Icon(Icons.favorite_border_outlined),label: "Favorite",icon: Icon(Icons.favorite_border),),
            BottomNavigationBarItem(activeIcon: Icon(Icons.shopping_cart_rounded),label: "Home",icon: Icon(Icons.shopping_cart),),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),

          ]*/

      ),

    );

  }
}
/* BottomNavigationBarItem(icon: Container(
                      width: 50,height: 50,
                      decoration:BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5)) ,
                      child: Icon(Icons.add)),label: "Add"),*/