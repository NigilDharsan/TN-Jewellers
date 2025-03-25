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
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _openAddNewPage() {
    Get.toNamed(RouteHelper.orderbasicscreen);
  }

  /// **Method to Get Current Screen**
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return MenuScreen();
      case 1:
        return MyOrderScreen();
      case 2:
        return FavoriteScreen();
      case 3:
        return CartScreen();
      default:
        return MenuScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: GlobalKey<NavigatorState>(),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => _getScreen(_selectedPageIndex),
          );
        },
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
