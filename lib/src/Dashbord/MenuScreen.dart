import 'package:TNJewellers/src/Dashbord/DrawerPage.dart';
import 'package:TNJewellers/src/Product/ProductScreen.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final PageController _pageController = PageController();
  int _currentPage = -1;

  final List<String> Stocks = [
    "EAR RINGS",
    "GOLD",
    "ON-STOCK",
    "WEIGHT",
    "KARAT"
  ];
  final List<Map<String, dynamic>> demo = [
    {"name": "Jewellery", "image": "assets/images/jewelly.jpg"},
    {"name": "Necklace", "image": "assets/images/jewelly.jpg"},
    {"name": "Bangles", "image": "assets/images/jewelly.jpg"},
    {"name": "Diamond", "image": "assets/images/jewelly.jpg"},
    {"name": "Diamond", "image": "assets/images/jewelly.jpg"},
    {"name": "Diamond", "image": "assets/images/jewelly.jpg"},
    {"name": "Diamond", "image": "assets/images/jewelly.jpg"},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Set background color
        elevation: 0,
        // Remove shadow
        iconTheme: IconThemeData(color: Colors.black),
        // Drawer icon color
        toolbarHeight: 100,
        // Set AppBar height
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome',
                    style: JosefinSansRegular, textScaleFactor: 0.8),
                SizedBox(height: 3), // Reduce spacing for small height
                Text('ARTISA JEWELLERS',
                    style: JosefinSansBold, textScaleFactor: 0.8),
              ],
            ),
            Image.asset(
              Images.logoPng,
              width: 60, // Reduce image width for smaller AppBar
              height: 60,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
      drawer: DrawerPage(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
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
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                Container(
                  height: 25,
                  child: ListView.builder(
                    itemCount: Stocks.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (itemBuilder, Index) {
                      return categoryItem(Stocks[Index]);
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      Image.asset(Images.banner,
                          width: double.infinity, fit: BoxFit.cover),
                      Image.asset(Images.banner,
                          width: double.infinity, fit: BoxFit.cover),
                      Image.asset(Images.banner,
                          width: double.infinity, fit: BoxFit.cover),
                      Image.asset(Images.banner,
                          width: double.infinity, fit: BoxFit.cover),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? brandGreyColor
                            : brandGreySoftColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
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
                      childAspectRatio:
                          4 / 3.2, // 2 for portrait, 3 for landscape
                      crossAxisSpacing: 5, // Space between columns
                      mainAxisSpacing: 5, // Space between rows
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return index == 0
                          ? Container(
                              margin: EdgeInsets.all(1),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: brandPrimaryColor,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // Prevents extra space issues
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.import_contacts_sharp,
                                          color: Colors.white, size: 30),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'RESTOCK YOUR\nBESTSELLERS!',
                                          style: JosefinSansSemiBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Your customers love these!',
                                    style: JosefinSansLight,
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Reorder your top-selling jewellery and keep inventory fresh',
                                          style: spanList,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(7),
                                          child: Text(
                                            'SPECIAL DEALS ON\nREGULAR STOCK\nITEMS!',
                                            style: splTextTitle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : index == 1
                              ? GridViewCartDesign(
                                  brandGoldDarkColor,
                                  'YOUR FAVORITE COLLECTIONS,',
                                  Icons.shopping_cart,
                                  'Browse Now',
                                  'Stay in Trend',
                                  'Stock the Best!')
                              : index == 2
                                  ? GridViewCartDesign(
                                      brandPrimaryColor,
                                      'NEW ARRIVALS.\nTRENDING.\nEXCLUSIVE.',
                                      Icons.shopping_cart,
                                      'Browse Now',
                                      'Stay in Trend',
                                      'Stock the Best!',
                                    )
                                  : GridViewCartDesign(
                                      brandGreyColor,
                                      'SHOWCASE.\nSELL MORE.\nRISK-FREE',
                                      Icons.calendar_today_rounded,
                                      'Request a Showcase',
                                      'Elevate Collection',
                                      'Sell without Limits');
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text('BROWSER BY JEWEL TYPE',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                SizedBox(
                  height:
                      screenHeight * 0.2, // Adjusted height for better spacing
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: demo.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(5),
                            child: ClipOval(
                              child: Image.asset(
                                demo[index]["image"],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            demo[index]["name"],
                            style: categoryTitle,
                          ),
                        ],
                      );
                    },
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
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: brandGoldColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

Widget GridViewCartDesign(Color backgroundColor, String title,
    IconData titleIcon, String subTitle, String subTitle1, String subTitle2) {
  return Container(
    margin: EdgeInsets.all(0),
    width: 200,
    padding: EdgeInsets.all(1),
    decoration: BoxDecoration(
      color: backgroundColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(titleIcon, color: Colors.white, size: 30),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: JosefinSansSemiBold,
                  ),
                  title == "YOUR FAVORITE COLLECTIONS,"
                      ? Text(
                          "All IN ONE PLACE!",
                          style: JosefinSansSemiBold1,
                        )
                      : SizedBox.shrink(),
                ],
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
                  Row(
                    children: [
                      Icon(Icons.diamond, color: Colors.white, size: 20),
                      SizedBox(width: 1),
                      Text(subTitle, style: JosefinSansLight),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.diamond, color: Colors.blue, size: 20),
                      SizedBox(width: 1),
                      Text(
                        subTitle1,
                        style: JosefinSansLight,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.diamond, color: Colors.red, size: 20),
                      SizedBox(width: 1),
                      Text(
                        subTitle2,
                        style: JosefinSansLight,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: InkWell(
                onTap: () {
                  Get.to(ProductScreen());
                },
                child: Image.asset(Images.rightArrow),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
