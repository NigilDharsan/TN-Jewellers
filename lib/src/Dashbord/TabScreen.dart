import 'package:TNJewellers/Utils/core/helper/route_helper.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../OderScreen/MyorderScreen.dart';
import 'CartScreen.dart';
import 'FavoriteScreen.dart';
import 'MenuScreen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  bool isOrderNowSelected = true; // Default: ORDER NOW is selected
  int _selectedPageIndex = 0;
  final List<Widget> _screens = [
    MenuScreen(),
    MyOrderScreen(),
    FavoriteScreen(),
    CartScreen(),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _openAddNewPage() {
    setState(() {
      isOrderNowSelected = true; // Select ORDER NOW
    });
    Get.toNamed(RouteHelper.orderbasicscreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddNewPage,
        backgroundColor: brandPrimaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: brandPrimaryColor,
        unselectedItemColor: Colors.brown,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'MENU',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'MY ORDER',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'FAVORITE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'CART',
          ),
        ],
      ),
    );
  }
}
