import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
          // Wrap with scrollable widget
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
                        Text('Welcome',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300)),
                        SizedBox(height: 5),
                        Text('ARTISA JEWELLERS',
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
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.black),
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: secondaryColor),
                              ),
                              filled: true,
                              fillColor: white5,
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
                      categoryItem("Necklace"),
                      categoryItem("Earrings"),
                      categoryItem("Bangles"),
                      categoryItem("Bracelets"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      Image.asset('assets/images/jewelly.jpg',
                          fit: BoxFit.cover),
                      Image.asset('assets/images/jewelly.jpg',
                          fit: BoxFit.cover),
                      Image.asset('assets/images/jewelly.jpg',
                          fit: BoxFit.cover),
                      Image.asset('assets/images/jewelly.jpg',
                          fit: BoxFit.cover),
                      Image.asset('assets/images/jewelly.jpg',
                          fit: BoxFit.cover),
                      Image.asset('assets/images/jewelly.jpg',
                          fit: BoxFit.cover),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.orange : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 180,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: brandPrimaryColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Prevents extra space issues
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.import_contacts_sharp, color: Colors.white, size: 30),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'RESTOCK YOUR\nBESTSELLERS!',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Your customers love these!',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Reorder your top-selling jewellery and keep inventory fresh',
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 10),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'SPECIAL DEALS ON\nREGULAR STOCK\nITEMS!',
                                      style: TextStyle(fontSize: 8, color: Colors.pink),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5), // Spacing between boxes
                      Container(
                        width: 180,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: brandGoldDarkColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Prevents overflow issues
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.shopping_cart, color: Colors.white, size: 30),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'YOUR FAVORITE COLLECTIONS,\nALL IN ONE PLACE!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(Icons.diamond,
                                              color: Colors.white, size: 20),
                                          SizedBox(width: 5),
                                          // Space between icon and text
                                          Text(
                                            'Browse Now',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.diamond,
                                              color: Colors.blue, size: 20),
                                          SizedBox(width: 5),
                                          Text(
                                            'Stay in Trend',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.diamond,
                                              color: Colors.red, size: 20),
                                          SizedBox(width: 5),
                                          Text(
                                            'Stock the Best!',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.black, size: 20),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                Row(
                  children: [
                    Container(
                      width: 180,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: brandPrimaryColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.shopping_cart,
                                  color: Colors.white, size: 30),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'NEW ARRIVALS TRENDING.\nEXCLUSIVE!',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // Aligns text properly
                                  children: [
                                    SizedBox(height: 5),
                                    // Add vertical spacing before Row
                                    Row(
                                      children: [
                                        Icon(Icons.diamond,
                                            color: Colors.white, size: 20),
                                        SizedBox(width: 5),
                                        // Space between icon and text
                                        Text(
                                          'Browse Now',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.diamond,
                                            color: Colors.blue, size: 20),
                                        SizedBox(width: 5),
                                        Text(
                                          'Stay in Trend',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.diamond,
                                            color: Colors.red, size: 20),
                                        SizedBox(width: 5),
                                        Text(
                                          'Stock the Best!',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 180,
                      height: 145,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: brandGreyColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today_rounded,
                                  color: Colors.white, size: 30),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'SHOWCASE SELL MORE.\nRISK-FREE',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.diamond,
                                            color: Colors.white54, size: 20),
                                        SizedBox(width: 5),
                                        // Space between icon and text
                                        Text(
                                          'Request a Showcase',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.diamond,
                                            color: Colors.blue, size: 20),
                                        SizedBox(width: 5),
                                        Text(
                                          'Elevate Collection',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.diamond,
                                            color: Colors.pink, size: 20),
                                        SizedBox(width: 5),
                                        Text(
                                          'Sell without Limits',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),),
                SizedBox(height: 20),
                Text('BROWSER BY JEWEL TYPE',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 120, // Increased height slightly for better layout
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(demo.length, (index) {
                        bool isSelected =
                            selectedIndex == index; // Check if selected
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index; // Update selected index
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(5),
                                // Slightly reduced padding
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.orange
                                        : Colors.grey, // Border color changes
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    demo[index]["image"], // Image from assets
                                    width: 60, // Circle size
                                    height: 60, // Circle size
                                    fit: BoxFit
                                        .cover, // Ensures image fits inside the circle
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              // Space between image and text
                              Text(
                                demo[index]["name"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.orange : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
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
                  fontSize: 16,
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
