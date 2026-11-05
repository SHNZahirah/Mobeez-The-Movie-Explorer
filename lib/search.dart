import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detailpass.dart';
import 'drawer.dart';
import 'bottomnav.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //baca input user
  final TextEditingController searchController = TextEditingController();

  // Senarai movie ikut id pendek (sama macam HomePage)
  List<Map<String, dynamic>> allMovies = [
    {
      "title": "love_disappears",
      "year": 2022,
      "rate": 7.4,
      "poster": "images/assets/love_disappears.jpg",
      "synopsis": "Even If This Love Disappears From World Tonight"
    },
    {
      "title": "lalaland",
      "year": 2016,
      "rate": 8.0,
      "poster": "images/assets/lalaland.jpg",
      "synopsis": "La La Land"
    },
    {
      "title": "train_busan",
      "year": 2016,
      "rate": 7.6,
      "poster": "images/assets/train_busan.jpg",
      "synopsis": "Train To Busan"
    },
    {
      "title": "spirited_away",
      "year": 2001,
      "rate": 8.6,
      "poster": "images/assets/spirited_away.jpg",
      "synopsis": "Spirited Away"
    },
    {
      "title": "abigail",
      "year": 2024,
      "rate": 6.5,
      "poster": "images/assets/abigail.jpg",
      "synopsis": "Abigail"
    },
    {
      "title": "boboiboy_galaxy",
      "year": 2016,
      "rate": 6.8,
      "poster": "images/assets/boboiboy_galaxy.jpg",
      "synopsis": "Boboiboy: The Movie"
    },
    {
      "title": "exhuma",
      "year": 2024,
      "rate": 6.9,
      "poster": "images/assets/exhuma.jpg",
      "synopsis": "Exhuma"
    },
    {
      "title": "eyes_tell",
      "year": 2020,
      "rate": 7.4,
      "poster": "images/assets/eyes_tell.jpg",
      "synopsis": "Your Eyes Tell"
    },
    {
      "title": "howl",
      "year": 2004,
      "rate": 8.2,
      "poster": "images/assets/howl.jpg",
      "synopsis": "Howl's Moving Castle"
    },
    {
      "title": "interstellar",
      "year": 2014,
      "rate": 8.7,
      "poster": "images/assets/interstellar.jpg",
      "synopsis": "Interstellar"
    },
    {
      "title": "khabi_khushi",
      "year": 2001,
      "rate": 7.5,
      "poster": "images/assets/khabi_khushi.jpg",
      "synopsis": "Khabi Khushi Kabhie Gham"
    },
    {
      "title": "kings_warden",
      "year": 2026,
      "rate": 7.0,
      "poster": "images/assets/kings_warden.jpg",
      "synopsis": "The King's Warden"
    },
    {
      "title": "kuch_kuch",
      "year": 1998,
      "rate": 7.5,
      "poster": "images/assets/kuch_kuch.jpg",
      "synopsis": "Kuch Kuch Hota Hai"
    },
    {
      "title": "last_night",
      "year": 2025,
      "rate": 7.1,
      "poster": "images/assets/last_night.jpg",
      "synopsis": "Re/Member : The Last Night"
    },
    {
      "title": "man_in_love",
      "year": 2021,
      "rate": 8.4,
      "poster": "images/assets/man_in_love.jpg",
      "synopsis": "Man In Love"
    },
    {
      "title": "mat_kilau",
      "year": 2022,
      "rate": 5.5,
      "poster": "images/assets/mat_kilau.jpg",
      "synopsis": "Mat Kilau"
    },
    {
      "title": "princess_diaries",
      "year": 2001,
      "rate": 6.4,
      "poster": "images/assets/princess_diaries.jpg",
      "synopsis": "The Princess Diaries"
    },
    {
      "title": "ralph_internet",
      "year": 2018,
      "rate": 7.0,
      "poster": "images/assets/ralph_internet.jpg",
      "synopsis": "Ralph Breaks The Internet"
    },
    {
      "title": "re_member",
      "year": 2022,
      "rate": 7.4,
      "poster": "images/assets/re_member.jpg",
      "synopsis": "Re/Member"
    },
    {
      "title": "showman",
      "year": 2017,
      "rate": 7.5,
      "poster": "images/assets/showman.jpg",
      "synopsis": "The Greatest Showman"
    },
    {
      "title": "tangled",
      "year": 2010,
      "rate": 7.7,
      "poster": "images/assets/tangled.jpg",
      "synopsis": "Tangled"
    },
    {
      "title": "your_name",
      "year": 2016,
      "rate": 8.4,
      "poster": "images/assets/your_name.jpg",
      "synopsis": "Your Name"
    },
  ];

  //simpan hasil carian movie filtered
  List<Map<String, dynamic>> searchResults = [];

  // Function untuk filter movie ikut keyword
  void _searchMovie(String query) {
    List<Map<String, dynamic>> results = []; //list kosong simpan hasil carian
    for (var movie in allMovies) { //loop setiap movie dlm list
      if (movie["title"].toLowerCase().contains(query.toLowerCase()) ||
          movie["synopsis"].toLowerCase().contains(query.toLowerCase())) {
        results.add(movie); //tambah movie kalau result match
      }
    }
    setState(() { //update ui ngan hasil carian
      searchResults = results;
    });
  }

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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar kuning
            TextField(
              //sambung ke controller untuk baca input
              controller: searchController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFFBC02D),
                hintText: "Type movie name...",
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _searchMovie, //panggil function setiap kali user type
            ),
            const SizedBox(height: 20),

            // Results
            Expanded( //list boleh scroll maik ruang available
              child: ListView.builder(
                itemCount: searchResults.length, //bil item dlm list
                itemBuilder: (context, index) { //bina each item dlm list
                  final movie = searchResults[index]; //amik movie pakai index

                  return Card( //card setiap result
                    color: const Color(0xFF2C2C2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile( // item dlm list gambar ngan text
                      leading: ClipRRect( //gambar bucu bulat
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          movie["poster"],
                          width: 50,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(movie["synopsis"],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: Row(
                        children: [
                          Text("Year: ${movie["year"]}   ",
                              style: const TextStyle(color: Colors.white70)),
                          const Icon(Icons.star,
                              color: Color(0xFFFBC02D), size: 20),
                          Text(" ${movie["rate"]}",
                              style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                      onTap: () {
                        Navigator.push( //bila click gi detail page
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              movieTitle: movie["title"], // id pendek
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
      bottomNavigationBar: const BottomNavPage(),
    );
  }
}
