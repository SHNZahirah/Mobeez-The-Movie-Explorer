import 'package:flutter/material.dart';
import 'listdrawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detailpass.dart';
import 'bottomnav.dart';

class FolderPage extends StatefulWidget {
  final String title;
  final List<String> movies; // guna String

  const FolderPage({super.key, required this.title, required this.movies});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  // Poster path ikut movie yg user pilih
  String getPoster(String movie) {
    if (movie == "love_disappears") {
      return "images/assets/love_disappears.jpg";
    }
    else if (movie == "kings_warden") {
      return "images/assets/kings_warden.jpg";
    }
    else if (movie == "eyes_tell") {
      return "images/assets/eyes_tell.jpg";
    }
    else if (movie == "princess_diaries") {
      return "images/assets/princess_diaries.jpg";
    }
    else if (movie == "lalaland") {
      return "images/assets/lalaland.jpg";
    }
    else if (movie == "exhuma") {
      return "images/assets/exhuma.jpg";
    }
    else if (movie == "mat_kilau") {
      return "images/assets/mat_kilau.jpg";
    }
    else if (movie == "showman") {
      return "images/assets/showman.jpg";
    }
    else if (movie == "train_busan") {
      return "images/assets/train_busan.jpg";
    }
    else if (movie == "ralph_internet") {
      return "images/assets/ralph_internet.jpg";
    }
    else if (movie == "bobiboy_galaxy") {
      return "images/assets/bobiboy_galaxy.jpg";
    }
    else if (movie == "khabi_khushi") {
      return "images/assets/khabi_khushi.jpg";
    }
    else if (movie == "kuch_kuch") {
      return "images/assets/kuch_kuch.jpg";
    }
    else if (movie == "tangled") {
      return "images/assets/tangled.jpg";
    }
    else if (movie == "abigail") {
      return "images/assets/abigail.jpg";
    }
    else if (movie == "last_night") {
      return "images/assets/last_night.jpg";
    }
    else if (movie == "man_in_love") {
      return "images/assets/man_in_love.jpg";
    }
    else if (movie == "re_member") {
      return "images/assets/re_member.jpg";
    }
    else if (movie == "your_name") {
      return "images/assets/your_name.jpg";
    }
    else if (movie == "howl") {
      return "images/assets/howl.jpg";
    }
    else if (movie == "spirited_away") {
      return "images/assets/spirited_away.jpg";
    }
    else {
      return "assets/images/default.jpg";
    }
  }

  //title path ikut movie yg user pilih
  String getTitle(String movie) {
    if (movie == "love_disappears") {
      return "\nEven If This Love Disappears From World Tonight";
    }
    else if (movie == "kings_warden") {
      return "\nThe King's Warden";
    }
    else if (movie == "eyes_tell") {
      return "\nYour Eyes Tell";
    }
    else if (movie == "lalaland") {
      return "\nLa La Land";
    }
    else if (movie == "exhuma") {
      return "\nExhuma";
    }
    else if (movie == "mat_kilau") {
      return "\nMat Kilau";
    }
    else if (movie == "showman") {
      return "\nThe Greatest Showman";
    }
    else if (movie == "train_busan") {
      return "\nTrain To Busan";
    }
    else if (movie == "ralph_internet") {
      return "\nRalph Break The Internet";
    }
    else if (movie == "boboiboy_galaxy") {
      return "\nBoboiboy : The Movie";
    }
    else if (movie == "khabi_khushi") {
      return "\nKhabi Khushi Kabhie Gham";
    }
    else if (movie == "kuch_kuch") {
      return "\nKuch Kuch Hota Hai";
    }
    else if (movie == "tangled") {
      return "\nTangled";
    }
    else if (movie == "abigail") {
      return "\nAbigail";
    }
    else if (movie == "last_night") {
      return "\nRe/Member : The Last Night";
    }
    else if (movie == "man_in_love") {
      return "\nMan In Love";
    }
    else if (movie == "re_member") {
      return "\nRe/Member";
    }
    else if (movie == "your_name") {
      return "\nYour Name";
    }
    else if (movie == "howl") {
      return "\nHowl's Moving Castle";
    }
    else if (movie == "spirited_away") {
      return "\nSpirited Away";
    }
    else if (movie == "princess_diaries") {
      return "\nThe Princess Diaries";
    }
    else {
      return movie;
    }
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

      drawer: const ListDrawer(),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(width: 10),

                Text(
                  widget.title, //page title (fav, watchlist, watched)
                  style: GoogleFonts.nunito(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFBC02D),
                  ),
                ),
              ],
            ),

            Text("-Long press to remove movie-",
            style: GoogleFonts.nunito(
                color: Color(0xFFFBC02D),
                fontSize: 16
            ),
                ),

            const SizedBox(height: 20),

            widget.movies.isEmpty //if no movie added
                ? const Center(
              child: Text(
                "No movies were added",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
            )

                : Wrap(
              spacing: 20,
              runSpacing: 20,
              children:
              widget.movies.map((movie) { //layout elevated button for display movie
                return SizedBox(
                  width: 160,
                  height: 290,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: const Color(0xFF303030),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 6,
                    ),
                    onPressed: () {
                      Navigator.push( //if user tekan saved movie dia akan bawa ke detail page
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(movieTitle: movie),
                        ),
                      );
                    },
                    onLongPress: () {
                      setState(() {
                        widget.movies.remove(movie); // untuk remove movie bila long press
                      });
                    },

                    child: Column(
                      children: [
                        Image.asset( //display movie poster
                          getPoster(movie),
                          width: 160,
                          height: 220,
                          fit: BoxFit.cover,
                        ),

                        const SizedBox(height: 5),

                        Text(
                          getTitle(movie), //display movie title
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavPage(),
    );
  }
}
