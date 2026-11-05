import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFBC02D),
              ),
              child: Text(
                  "MOBEEZ Menu",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
              ),
              ),
          ),

          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Home'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),

          ListTile(
            leading: const Icon(Icons.search_rounded),
            title: const Text('Search'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/search');
            },
          ),

          ListTile(
            leading: const Icon(Icons.list_rounded),
            title: const Text('My List'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/listpage');
            },
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),

        ],
      ),
    );
  }
}
