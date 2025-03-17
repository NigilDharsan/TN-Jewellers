import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/core/helper/route_helper.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: brandGreyColor, // Set background color to grey
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align right side
                children: [
                  Icon(Icons.menu, color: buttonTextColor),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to right
                    children: [
                      Text('Welcome', style: DrawerJosefinSansRegular),
                      SizedBox(height: 5),
                      Text('ARTISA JEWELLERS', style: jewellery),
                    ],
                  ),
                ],
              ),
            ),

            // Drawer Items
            Expanded(
              child: ListView(
                children: [
                  _drawerItem(
                    icon: Icons.dashboard,
                    text: 'DASHBOARD',
                    onTap: () {
                      Get.toNamed(RouteHelper.getProfileRoute());
                    },
                  ),
                  _drawerItem(icon: Icons.card_travel, text: 'MY ORDER', onTap: () {}),
                  _drawerItem(icon: Icons.favorite_border, text: 'FAVOURITE', onTap: () {}),
                  _drawerItem(icon: Icons.shopping_cart, text: 'CART', onTap: () {}),
                  _drawerItem(icon: Icons.person, text: 'PROFILE', onTap: () {}),
                  _drawerItem(icon: Icons.settings, text: 'SETTINGS', onTap: () {}),
                  _drawerItem(icon: Icons.manage_accounts, text: 'ACCOUNTS', onTap: () {}),
                  _drawerItem(icon: Icons.logout, text: 'LOGOUT', onTap: () {}),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white, // White background at bottom
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.messenger_outline, color: Colors.yellow[800]),
                  SizedBox(width: 8),
                  Text(
                    'CONTACT US',
                    style: jewellery,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _drawerItem({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: white3),
    title: Text(text, style: DrawerJosefinSansRegular),
    onTap: onTap,
  );
}
