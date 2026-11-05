import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_explorer/detailpass.dart';
import 'package:movie_explorer/listpage.dart';
import 'package:movie_explorer/login.dart';
import 'package:movie_explorer/myreview.dart';
import 'package:movie_explorer/profile.dart';
import 'package:movie_explorer/register.dart';
import 'editprofile.dart';
import 'drawer.dart';
import 'search.dart';
import 'bottomnav.dart';

//global variable simpan list movie
List<String> favorites = [];
List<String> watchlist = [];
List<String> watched = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance(); //bukak storage untuk baca tulis data
  bool loggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(loggedIn: loggedIn)); //jalan app ngan status log in
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp({super.key, required this.loggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies Explorer',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF212121),
          centerTitle: true,
        ),
      ),
      initialRoute: loggedIn ? '/' : '/login', //tentukan page pertama
      routes: {
        '/' : (context) => const HomePage(),
        '/listpage' : (context) => const ListPage(),
        '/profile' : (context) => const ProfilePage(),
        '/register' : (context)=> const RegisterPage(),
        '/login' : (context)=> const LoginPage(),
        '/myreview' : (context)=> const MyReviewPage(),
        '/editprofile' : (context)=> const EditProfilePage(),
        '/search' : (context) => const SearchPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

      body:
      Center(
        child : SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Wrap( //susun widget dlm grid
                spacing: 20,
                runSpacing: 20,
                children: [
                  SizedBox( //movie button size
                    width: 160,
                    height: 290,

                    child: ElevatedButton( //button to detail page
                      onPressed: () {
                        Navigator.push( //bukak page baru
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(
                              movieTitle: "love_disappears", //bina route ke detail page hantar movie title
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom( //set style button
                        padding: EdgeInsets.zero, //buang padding default
                        backgroundColor: Color(0xFF303030), // warna petak
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                        ),
                        elevation: 6, //shadow popup
                      ),
                      child: Column(
                        children: [
                          Center (),
                          Image.asset(
                            'images/assets/love_disappears.jpg',
                            width: 160,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\nEven If This Love Disappears From World Tonight',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(movieTitle: "kings_warden"),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, //buang padding default
                        backgroundColor: Color(0xFF303030),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                        ),
                        elevation: 6, //shadow popup
                      ),
                      child: Column(
                        children: [
                          Center (),
                          Image.asset(
                            'images/assets/kings_warden.jpg',
                            width: 160,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "\nThe King's Warden",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "eyes_tell"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/eyes_tell.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nYour Eyes Tell",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),

                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "princess_diaries"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/princess_diaries.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nThe Princess Diaries",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "lalaland"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/lalaland.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nLa La Land",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "exhuma"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/exhuma.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nExhuma",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "mat_kilau"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/mat_kilau.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nMat Kilau",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "showman"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/showman.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nThe Greatest Showman",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "train_busan"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/train_busan.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nTrain To Busan",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "ralph_internet"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/ralph_internet.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nRalph Break The Internet",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "boboiboy_galaxy"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/boboiboy_galaxy.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nBoboiboy : The Movie",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "khabi_khushi"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/khabi_khushi.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nKhabi Khushi Kabhie Gham",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "kuch_kuch"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/kuch_kuch.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nKuch Kuch Hota Hai",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "tangled"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/tangled.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nTangled",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "abigail"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/abigail.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nAbigail",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "last_night"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/last_night.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\n Re/Member:The Last Night",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "man_in_love"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/man_in_love.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nMan In Love",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "re_member"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/re_member.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nRe/Member",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "your_name"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/your_name.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nYour Name",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "howl"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/howl.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nHowl's Moving Castle",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(movieTitle: "spirited_away"),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, //buang padding default
                        backgroundColor: Color(0xFF303030), // warna petak
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                        ),
                        elevation: 6, //shadow popup
                      ),
                      child: Column(
                        children: [
                          Center (),
                          Image.asset(
                            'images/assets/spirited_away.jpg',
                            width: 160,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "\nSpirited Away",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 160,
                    height: 290,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPage(movieTitle: "interstellar"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, //buang padding default
                          backgroundColor: Color(0xFF303030), // warna petak
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8), //bucu petak
                          ),
                          elevation: 6, //shadow popup
                        ),
                        child: Column(
                          children: [
                            Center (),
                            Image.asset(
                              'images/assets/interstellar.jpg',
                              width: 160,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "\nInterstellar",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavPage(),
    );
  }
}
