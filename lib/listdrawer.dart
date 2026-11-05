import 'package:flutter/material.dart';
import 'main.dart';
import 'folderpage.dart';

class ListDrawer extends StatelessWidget {
  const ListDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFFBC02D)),
            child: Text("My Lists",
                style: TextStyle(color: Colors.black87, fontSize: 24)),
          ),

          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text("Favorites"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FolderPage(title: "Favorites", movies: favorites),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.watch_later_rounded, color: Colors.orange),
            title: const Text("Watchlist"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FolderPage(title: "Watchlist", movies: watchlist),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.remove_red_eye_rounded, color: Colors.green),
            title: const Text("Watched"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FolderPage(title: "Watched", movies: watched),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
