import 'package:flutter/material.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,

      backgroundColor: Color(0xFFFBC02D), // warna nav bar
      selectedItemColor: Colors.black, // icon & tulisan selected
      unselectedItemColor: Colors.black, // icon & tulisan unselected

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_rounded),
          label: "My List",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],

      onTap: (index) {
        setState(() {
          currentIndex = index;
        });

        if (index == 0) {
          Navigator.pushNamed(context, '/'); // main.dart
        } else if (index == 1) {
          Navigator.pushNamed(context, '/search'); // search.dart
        } else if (index == 2) {
          Navigator.pushNamed(context, '/listpage'); // list.dart
        } else if (index == 3) {
          Navigator.pushNamed(context, '/profile'); // profile.dart
        }
      },
    );
  }
}
