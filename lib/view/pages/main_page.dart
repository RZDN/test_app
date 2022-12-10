import 'package:flutter/material.dart';
import 'package:test_app/view/pages/account_page.dart';
import 'package:test_app/view/pages/favorites_page.dart';
import 'package:test_app/view/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  final pages = [
    const HomePage(),
    const FavoritesPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}
