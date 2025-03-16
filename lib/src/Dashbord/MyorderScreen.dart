import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int selectedIndex = -1; // Initially, no category is selected

  final List<Map<String, dynamic>> demo = [
    {"name": "Jewelry", "image": "assets/images/jewelly.jpg"},
    {"name": "Necklace", "image": "assets/images/jewelly.jpg"},
    {"name": "Bangles", "image": "assets/images/jewelly.jpg"},
    {"name": "Diamond", "image": "assets/images/jewelly.jpg"},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text('STOCK UP NOW',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Image.asset(
                      Images.logoPng,
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: secondaryColor),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: brandPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      categoryItem("BANGLES"),
                      categoryItem("GOLD"),
                      categoryItem("ON-STOCK"),
                      categoryItem("WEIGHT"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0), // Reduced padding
      child: Container(
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 10),
        // Keeps good spacing inside the container
        decoration: BoxDecoration(
          color: brandGoldColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // Ensures Row doesn't stretch unnecessarily
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(width: 5),
            // Slightly increased space for better readability
            Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
