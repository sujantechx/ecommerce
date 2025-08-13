import 'package:ecommerce/Utils/ui_helper/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Dummy category data
  final List<Map<String, String>> categories = [
    {"name": "Shoes", "icon": "👟"},
    {"name": "Beauty", "icon": "💄"},
    {"name": "Women's Fashion", "icon": "👗"},
    {"name": "Jewelry", "icon": "💍"},
    {"name": "Men's Fashion", "icon": "👕"},
  ];

  // Dummy product data
  final List<Map<String, dynamic>> products = [
    {
      "name": "Wireless Headphones",
      "price": 120.00,
      "image":
      "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSmSKPs0qy5lrDwccWHM_4GF7BHQYeZtWfurBUic_AkkL8TY3WeNAGxQQ5N_LvXoItkF-tR_Iepsg3ZM62LWxZkPjHnVoTkctVZIGMolehkN8klTpFzb2vi"
    },
    {
      "name": "Woman Sweater",
      "price": 70.00,
      "image":
      "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRHGlhWeFHkX5kxBJfOxVkLMnI4rB2Zu5zAGlKwq2N3kdtTHbxuUjI_Db6Ht3-1WB0zRe_ZJdp-Ytx128mysTq5mFoDDzqkEbD5a8KQP90"
    },
    {
      "name": "Smart Watch",
      "price": 55.00,
      "image":
      "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQPErNUPqTOzNZMNP97DMEHM8VU3sAqyME3cTEh82JOZoK5CZGM0igotRQw8hL7FcxURLBBLLstQTksx69WQ-InsdH0zkFF2uaZQoo2er_-NGRMBAka5YKJax424j4X3ux99UvAVX02fw&usqp=CAc"
    },
    {
      "name": "Sneakers",
      "price": 90.00,
      "image":
      "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQfm_WoUvZcBjCy29nhw6JRuErl6goRmVgnDMUQzd6ykiWieeSoB782bPg__-4QFawnmcxG8ucCYk8lClinHpX2YrlZ5Rol7MkHgjH_F0a69YijnOqaO2G1FYc"
    },
  ];
/// dummy offer banner
  final PageController _pageController=PageController();
 final  List<Map<String,dynamic>>offer=[
   {
     "img":
"https://img.pikbest.com/templates/20240817/sale-offer-post-design-template-creative-product-instagram_10734409.jpg!bw700"   }, {
     "img":
     "https://static.vecteezy.com/system/resources/thumbnails/001/381/216/small_2x/special-offer-sale-banner-with-megaphone-free-vector.jpg"
   }, {
     "img":
         "https://c8.alamy.com/comp/2BWGH1Y/hot-sale-special-offer-banner-2BWGH1Y.jpg"
   }, {
     "img":
         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdAZNKzi21Wrn4xTYP5HueGoaz0ctH9mGysA&s"
   }, {
     "img":
         "https://img.freepik.com/premium-vector/product-sale-promotion-print-flyer-poster-template-design_612040-1824.jpg"
   },
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Banner
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(22),
             
            ),child: PageView.builder(
            controller: _pageController,
            itemCount: offer.length,
            itemBuilder: (BuildContext context, int index) { 
              final offImg=offer[index];
              return Stack(
                children: [
                  Positioned(
                    left: 0,right: 0,top: 0,bottom: 0,child:
                  Image.network(
                    offImg['img'],
                    fit: BoxFit.fill,
                  ),
                  ),

                  Positioned(
                    bottom: 10,left: 150,right: 150,
                    child: SmoothPageIndicator(
                      count: offer.length,
                      effect: const WormEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.green,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 12,
                      ), controller:_pageController,
                    ),
                  ),
                ],
              );
            },
            
          ),
          ),
          const SizedBox(height: 16),

          // Categories List
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.orange.shade100,
                        child: Text(
                          categories[index]['icon']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        categories[index]['name']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Special For You Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "Special For You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               Text(
                "See all",
                style: mTextStyle12(textColor:Colors.black54 ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items in a row
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Positioned(
                      // right: 10,top: 5,
                      child:                   Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              ClipRRect(
              borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
              ),
              child: Image.network(
              products[index]['image'],
              height: 160,
              width: double.infinity,
              fit: BoxFit.fill,
              ),
              ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
              products[index]['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
              "\$${products[index]['price']}",
              style: const TextStyle(color: Colors.orange),
              ),
              ),
              ],
              ),
              ),
              ),
                  Positioned(
                      right: 0,top: 0,child: Container(height: 40,width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomLeft: Radius.circular(8)),
                        color: Colors.orange
                    ),child: Icon(Icons.favorite_border,size: 40,color: Colors.white,),
                  )),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
