import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children: const [
          MenuScreen(),
          MyOrderScreen(),
          FavoriteScreen(),
          CartScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.orange,
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
