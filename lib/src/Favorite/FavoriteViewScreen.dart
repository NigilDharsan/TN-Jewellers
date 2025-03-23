import 'package:TNJewellers/Utils/core/helper/route_helper.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteViewScreen extends StatefulWidget {
  const FavoriteViewScreen({super.key});

  @override
  State<FavoriteViewScreen> createState() => _FavoriteViewScreenState();
}

class _FavoriteViewScreenState extends State<FavoriteViewScreen> {
  bool isGridView = false; // Toggle between ListView & GridView
  bool isOrderNowSelected = true; // Default: ORDER NOW is selected
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: brandGreyColor),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          "SOUTH INDIAN BANGLE",
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.share, color: Colors.black),
              onPressed: () {
                Get.back();
              }),
          IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.black),
              onPressed: () {
                Get.back();
              }),
          IconButton(
              icon: Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 200, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Stocks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        Stocks[index]["image"]!,
                        width: 250,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Description',
                          style: textSemiBold,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'A handcrafted 22K gold temple bangle with intricate carvings inspired by traditional South Indian temple motifs. Perfect for festive and bridal wear.',
                          style: smallSemiBold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Purity',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '24 K',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Material',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'GOLD',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weight',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '24 GRAMS',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dimensions (mm)',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '15 W X 12 H',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stone',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'DIAMOND',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stone Weight',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '2 GRAMS',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stone quality code',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'GRADE O2',
                        style: textSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customization',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'SIZE/WEIGHTS',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Time',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '7-10 DAYS',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Price and Alteration Toggle
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantity',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '1 PAIR',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price/Piece',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '\$5000',
                        style: smallSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alteration Required',
                        style: textSemiBold,
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isOn = !isOn; // Toggle state
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              isOn
                                  ? Icons.toggle_on
                                  : Icons.toggle_off_outlined, // Change icon
                              size: 40,
                              color: isOn
                                  ? brandPrimaryColor
                                  : Colors.grey, // Change icon color
                            ),
                            SizedBox(width: 10),
                            Text(
                              isOn ? 'Yes' : 'No', // Change text dynamically
                              style: textSemiBold.copyWith(
                                color: isOn
                                    ? brandPrimaryColor
                                    : Colors.grey, // Change text color
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.orderbasicscreen);
                    setState(() {
                      isOrderNowSelected = true; // Select ORDER NOW
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: isOrderNowSelected
                          ? brandPrimaryColor
                          : Colors.transparent, // Fill color if selected
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: brandGreyColor, // Border color when not selected
                        width: isOrderNowSelected
                            ? 0
                            : 2, // Hide border when selected
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'ORDER NOW',
                        style: JosefinSansSemiBold.copyWith(
                          color: isOrderNowSelected
                              ? Colors.white
                              : brandPrimaryColor, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOrderNowSelected = false; // Select ADD TO CART
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: isOrderNowSelected
                          ? Colors.transparent
                          : brandPrimaryColor, // Fill color if selected
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: brandGreyColor, // Border color when not selected
                        width: isOrderNowSelected
                            ? 2
                            : 0, // Hide border when selected
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'ADD TO CART',
                        style: JosefinSansSemiBold.copyWith(
                          color: isOrderNowSelected
                              ? brandPrimaryColor
                              : Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> Stocks = [
  {"image": "assets/images/jewelly.jpg"},
  {"image": "assets/images/jewelly.jpg"},
  {"image": "assets/images/jewelly.jpg"},
  {"image": "assets/images/jewelly.jpg"},
  {"image": "assets/images/jewelly.jpg"},
  {"image": "assets/images/jewelly.jpg"},
  {"image": "assets/images/jewelly.jpg"},
];
