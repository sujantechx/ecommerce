import 'package:ecommerce/Auth/signin/login.dart';
import 'package:ecommerce/Utils/app_routs/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const Color primaryGreen = Color(0xFF4CAF50); // Adjust to match your brand color
const Color titleColor = Color(0xFF0A2940); // Dark blue title
const Color descColor = Colors.grey;

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  bool _isLastPage = false;

  List<Map<String, dynamic>> onboardingData = [
    {
      "image": "assets/images/im1.webp",
      "logo": "assets/logo/splass.png",
      "title": "Welcome to Your One-Stop Shop!",
      "description": "Discover thousands of products from your favorite brands. Your next great find is just a tap away."
    },
    {
      "image": "assets/images/im2.webp",
      "logo": "assets/logo/splass.png",
      "title": "Find Exactly What You Need",
      "description": "Use our smart search and intuitive filters to effortlessly browse categories and find the perfect item in seconds."
    },
    {
      "image": "assets/images/im3.webp",
      "logo": "assets/logo/splass.png",
      "title": "Exclusive Deals & Offers",
      "description": "Get access to members-only discounts, daily flash sales, and personalized offers. Save big on every purchase!"
    },
    {
      "image": "assets/images/im4.webp",
      "logo": "assets/logo/splass.png",
      "title": "Fast, Easy & Secure Checkout",
      "description": "Experience a seamless and secure payment process with multiple options. Your order is just a few clicks away."
    },
    {
      "image": "assets/images/im5.jpg",
      "logo": "assets/logo/splass.png",
      "title": "Track Your Order to Your Door",
      "description": "Get real-time updates from our warehouse to your doorstep. Sit back and relax, we'll handle the rest."
    }
  ];
Future<void>_completIntro()async{
  final prefs=await SharedPreferences.getInstance();
  await prefs.setBool('isFirstTime', false);
  Navigator.pushReplacementNamed(context, AppRoutes.auth);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              /// count lentght
              onPageChanged: (index) {
                setState(() {
                  _isLastPage = index == onboardingData.length - 1;
                });
              },

              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 16),
                    // Logo at top
                    Image.asset(
                      data['logo'],
                      height: 130,
                    ),
                    // Illustration
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Image.asset(
                        data['image'],
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Title & Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Text(
                            data['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            data['description'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: descColor,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Dots & Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                      child: Column(
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: onboardingData.length,
                            effect: const WormEffect(
                              dotColor: Colors.grey,
                              activeDotColor: primaryGreen,
                              dotHeight: 10,
                              dotWidth: 10,
                              spacing: 12,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                if (_isLastPage) {
                                  // Navigator.pushReplacementNamed(context, AppRoutes.auth);
                                  _completIntro();
                                } else {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isLastPage ? "Next":  "Get Started",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (!_isLastPage) ...[
                                    const SizedBox(width: 8),
                                    const Icon(Icons.arrow_forward),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Home Screen")),
    );
  }
}

