import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'folderpage.dart';
import 'drawer.dart';
import 'bottomnav.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        leading: const DrawerButton(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(Color(0xFFFBC02D)),
            iconSize: WidgetStatePropertyAll(40),
          ),
        ),
        title: Text(
          'MOBEEZ',
          textAlign: TextAlign.center,
          style: GoogleFonts.fasterOne(
            fontSize: 50,
            color: const Color(0xFFFBC02D),
          ),
        ),
      ),

      drawer: const AppDrawer(),

      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        children: [
          // Title "Your List" duduk tengah
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min, // supaya row ikut content
              children: [
                const Icon(
                  Icons.folder_special_rounded,
                  color: Color(0xFFFBC02D),
                  size: 40,
                ),
                const SizedBox(width: 20),
                Text(
                  "My List",
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFBC02D),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Favorites
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: const Icon(Icons.favorite, color: Color(0xFFEF5350)),
            title: const Text(
              "Favorites",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FolderPage(
                    title: "Favorites",
                    movies: favorites,
                  ),
                ),
              );
            },
          ),

          // Watchlist
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: const Icon(Icons.watch_later_rounded, color: Color(0xFFFBC02D)),
            title: const Text(
              "Watchlist",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FolderPage(
                    title: "Watchlist",
                    movies: watchlist,
                  ),
                ),
              );
            },
          ),

          // Watched
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: const Icon(Icons.remove_red_eye, color: Colors.green),
            title: const Text(
              "Watched",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FolderPage(
                    title: "Watched",
                    movies: watched,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: const BottomNavPage(),
    );
  }
}
