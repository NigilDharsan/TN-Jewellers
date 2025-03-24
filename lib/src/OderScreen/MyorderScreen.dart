import 'package:TNJewellers/src/OderScreen/controller/OrderController.dart';
import 'package:TNJewellers/src/OderScreen/model/OrderListModel.dart';
import 'package:TNJewellers/utils/core/helper/route_helper.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  String selectedValue = "MOST RECENT"; // Initial value

  bool isListView = true;
  final List<String> mydream = [
    "EAR RINGS",
    "GOLD",
    "ON-STOCK",
    "WEIGHT",
    "KARAT"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text("MY ORDERS", style: headerTitle),
          actions: [
            IconButton(
                icon: Icon(Icons.notifications, color: Colors.black),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.person, color: Colors.black),
                onPressed: () {}),
          ],
        ),
        body: GetBuilder<OrderController>(
            initState: (state) =>
                Get.find<OrderController>().getOrderListResponse(),
            builder: (controller) {
              if (controller.isLoading && controller.orderListModel == null) {
                return Center(child: CircularProgressIndicator());
              }
              return _buildBody(controller);
            }));
  }

  Widget _buildBody(OrderController controller) {
    return Column(
      children: [
        // 🔍 Search Bar & Filter Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Image.asset(Images.search),
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: brandGreyColor),
                    filled: true,
                    fillColor: brandGoldLightColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.brown[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.filter_list, color: Colors.white),
              ),
            ],
          ),
        ),

        // 🔹 Category Horizontal List
        Container(
          height: 28,
          child: ListView.builder(
            itemCount: mydream.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => categoryItem(mydream[index]),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 30,
                color: brandGoldLightColor,
                child: Transform.scale(
                  scale: 0.8,
                  child: DropdownButton<String>(
                    value: selectedValue,
                    items: ["MOST RECENT", "OLDEST FIRST"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    underline: SizedBox(),
                    // Removes default underline
                    icon: Icon(Icons.arrow_drop_down),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(isListView ? Icons.list : Icons.grid_view, size: 28),
                onPressed: () {
                  setState(() {
                    isListView =
                        !isListView; // ✅ Toggle between ListView and GridView
                  });
                },
              ),
            ],
          ),
        ),

        Expanded(
            child: isListView
                ? ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: controller.orderListModel?.data?.length,
                    itemBuilder: (context, index) => buildProductCard(
                        controller.orderListModel!.data![index], controller),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.95,
                    ),
                    itemCount: controller.orderListModel?.data?.length,
                    itemBuilder: (context, index) => buildProductGrid(
                        controller.orderListModel!.data![index], controller),
                  )),
      ],
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
            Text(title,
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

// Grid View Item
  Widget buildProductGrid(OrderListData product, OrderController controller) {
    return InkWell(
      onTap: () {
        controller.selectedProductID = product.pkId.toString();
        Get.toNamed(RouteHelper.orderdetailscreen);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Icon(Icons.bookmark_border, color: Colors.blue, size: 20),
            ),
            SizedBox(height: 10),
            Text(
              product.productName ?? "Product Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(product.customerDueDate ?? "", textAlign: TextAlign.center),
            Text(product.status ?? "", textAlign: TextAlign.center),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCard(OrderListData product, OrderController controller) {
    return InkWell(
      onTap: () {
        controller.selectedProductID = product.pkId.toString();
        Get.toNamed(RouteHelper.orderdetailscreen);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.notifications, color: brandPrimaryColor, size: 24),
                Expanded(
                  child: Text(
                    product.productName ?? "Product Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: brandPrimaryColor),
                  ),
                ),
                Icon(Icons.arrow_circle_right_outlined,
                    color: brandPrimaryColor),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Customer Name", style: order_normal),
                    Text(product.customerNickName ?? "N/A", style: order_bold),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Weight", style: order_normal),
                    Text(product.weight ?? "N/A", style: order_bold),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery Date", style: order_normal),
                    Text(product.customerDueDate ?? "No Due Date",
                        style: order_bold),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Other Status", style: order_normal),
                    Text(product.status ?? "Status", style: order_bold),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
