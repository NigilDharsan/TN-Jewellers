import 'package:flutter/material.dart';

import 'CartScreen.dart';
import 'FavoriteScreen.dart';
import 'MenuScreen.dart';
import 'MyorderScreen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    const MenuScreen(),
    const MyOrderScreen(),
    const FavoriteScreen(),
    const CartScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.brown,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            activeIcon: Icon(Icons.menu),
            label: 'MENU',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            activeIcon: Icon(Icons.card_travel),
            label: 'MY ORDER',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'FAVORITE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'CART',
          ),
        ],
      ),
    );
  }
}
