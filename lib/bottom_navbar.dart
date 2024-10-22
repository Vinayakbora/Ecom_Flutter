import 'package:flutter/material.dart';
import 'package:flutter_assngmnt/all_products.dart';
import 'package:flutter_assngmnt/categories_screen.dart';
import 'package:flutter_assngmnt/favourite_screen.dart';
import 'package:flutter_assngmnt/profile_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbar();
}

class _BottomNavbar extends State<BottomNavbarScreen> {
  final List<BottomNavigationBarItem> items = const [
     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
     BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  final List<Widget> screens = [
    const AllProductsScreen(),
    const AllCategoriesScreen(),
    const FavouriteScreen(),
    ProfileScreen()
  ];

  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: bottomNavIndex,
        children: screens,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: bottomNavIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {});
          bottomNavIndex = index;
        },
        ),
    );
  }
}