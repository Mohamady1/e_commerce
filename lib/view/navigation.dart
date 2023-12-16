import 'package:e_commerce/view/screens/cart.dart';
import 'package:e_commerce/view/screens/home.dart';
import 'package:e_commerce/view/screens/profile.dart';
import 'package:e_commerce/view/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;

class NavigationPage extends StatefulWidget {
  NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<Widget> _tabs = [Home(), Wishlist(), Cart(), Profile()];

  int _currentIndex = 0;

  void _onTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        selectedItemColor: color.Colors.redColor,
        elevation: 0,
        backgroundColor: color.Colors.bg,
        currentIndex: _currentIndex,
        onTap: _onTab,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
