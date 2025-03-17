import 'package:TNJewellers/src/Dashbord/Favorite/FavoriteViewScreen.dart';
import 'package:TNJewellers/src/Product/ProductScreen.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/images.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isGridView = false; // Toggle between ListView & GridView

  List<Map<String, String>> products = List.generate(
    8,
    (index) => {
      "name": "PRODUCT NAME",
      "code": "JWLNCK7052",
      "price": "1,25000",
      "image": "assets/sample.jpg", // Replace with actual image path
      "type": index.isEven ? "GOLD" : "SILVER",
    },
  );

  Widget buildProductCard(Map<String, String> product) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(Images.product_ear_ring,
                width: 80, height: 80, fit: BoxFit.cover),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product["name"]!, style: productName),
                SizedBox(height: 5),
                Text(product["code"]!,
                    style: TextStyle(color: brandGreyColor, fontSize: 9)),
                SizedBox(height: 5),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(product["price"]!,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10)),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: product["type"] == "GOLD"
                          ? brandGoldColor
                          : brandGreySoftColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(product["type"]!,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            color: Colors.white)),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: brandGreyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("18K",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            color: Colors.white)),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: brandGreyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("22K",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            color: Colors.white)),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: brandGreyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("24K",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget buildProductGrid(Map<String, String> product) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(Images.product_ear_ring,
                width: double.infinity, height: 120, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product["name"]!, style: productName),
                        Text(product["code"]!,
                            style: TextStyle(color: Colors.grey, fontSize: 9)),
                      ],
                    ),
                    Spacer(),
                    Text(product["price"]!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: product["type"] == "GOLD"
                            ? brandGoldColor
                            : brandGreySoftColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(product["type"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          )),
                    ),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: brandGreyColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text("18K",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.white)),
                    ),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: brandGreyColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text("22K",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.white)),
                    ),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: brandGreyColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text("24K",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
          "MY FAVORITE",
          style: headerTitle,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                Get.back();
              }),
          IconButton(
              icon: Icon(Icons.person, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Search Bar & Filters
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Image.asset(Images.search),
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: brandGreyColor),
                          // Set the hint text color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                color: Colors
                                    .transparent), // Makes the border invisible
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: brandGoldLightColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.brown[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.filter_list, color: Colors.white),
                ),
              ],
            ),
          ),

          // Sorting & View Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.add_box_outlined),
              Row(
                children: [
                  Container(
                    height: 30,
                    color: brandGoldLightColor,
                    child: Transform.scale(
                      scale: 0.8,
                      child: DropdownButton<String>(
                        value: "LOW TO HIGH",
                        items:
                            ["LOW TO HIGH", "HIGH TO LOW"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.w400),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Space between dropdown and button
                  IconButton(
                    icon: Icon(isGridView ? Icons.list : Icons.add_card_rounded,
                        color: Colors.brown),
                    onPressed: () {
                      setState(() {
                        isGridView = !isGridView;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              // Adjusts height to 40% of screen height
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? 2
                      : 3,
                  childAspectRatio: 4 / 3.2, // Adjust ratio for layout
                  crossAxisSpacing: 5, // Space between columns
                  mainAxisSpacing: 5, // Space between rows
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return GridViewCartDesign(
                      brandGoldDarkColor,
                      'MY BANGLES COLLECTIONS,',
                      Icons.shopping_cart,
                      'Offers',
                      '% ITEMS',
                      'Quik Moving',
                      '10 ITEMS',
                    );
                  } else if (index == 1) {
                    return GridViewCartDesign(
                      brandGoldDarkColor,
                      'MY DIWALI \nSTOCK PLAN,',
                      Icons.shopping_cart,
                      'Offers',
                      '% ITEMS',
                      'Quik Moving',
                      '10 ITEMS',
                    );
                  } else if (index == 2) {
                    return GridViewCartDesign(
                      brandGoldDarkColor,
                      'EXHIBITION/\nMELA ITEMS.',
                      Icons.shopping_cart,
                      'Offers',
                      '% ITEMS',
                      'Quik Moving',
                      '10 ITEMS',
                    );
                  } else {
                    return GridViewCartDesign(
                      brandGoldDarkColor,
                      'VALENTINE\nSPECIAL',
                      Icons.calendar_today_rounded,
                      'Offers',
                      '% ITEMS',
                      'Quik Moving',
                      '10 ITEMS',
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget GridViewCartDesign(
  Color backgroundColor,
  String title,
  IconData titleIcon,
  String subTitle,
  String subTitle1,
  String subTitle2,
  String subTitle3, // Added parameter for consistency
) {
  return Container(
    margin: EdgeInsets.all(0),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(0), // Adds smooth edges
    ),
    child: Column(// Pushes text to the bottom
      children: [
        Align(
          alignment: Alignment.topRight,
          child:  Container(
            padding: EdgeInsets.all(1),
            child: InkWell(
              onTap: () {
                Get.to(FavoriteViewScreen());
              },
              child: Image.asset(
                Images.rightArrow,
                width: 24, // Adjust size
                height: 24,
              ),
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: JosefinSansSemiBold,
                  ),
                  if (title == "YOUR FAVORITE COLLECTIONS,")
                    Text(
                      "",),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subTitle,
                  style: JosefinSansSemiBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                // Space between text and value
                Text(
                  subTitle1,
                  style: JosefinSansSemiBold,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subTitle2,
                  style: JosefinSansSemiBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  subTitle3,
                  style: JosefinSansSemiBold,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
