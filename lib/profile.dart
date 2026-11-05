import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'dart:io';
import 'myreview.dart';
import 'bottomnav.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //simpan info user
  String username = "";
  String email = "";
  String bio = "";
  String dob = "";
  String? imagePath;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() { //updte ngan data baru
      username = prefs.getString('name') ?? "";
      email = prefs.getString('email') ?? "";
      bio = prefs.getString('bio') ?? "";
      dob = prefs.getString('dob') ?? "";
      imagePath = prefs.getString('profileImage'); //boleh null kalau x de
    });
  }

  Future<void> logoutUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); //padam status login dari storage

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out successfully")),
    );

    //  Navigate ke login page, clear semua stack
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    super.initState();
    loadUserData(); //panggil untuk amik data
  }

  // Kotak info static
  Widget buildInfoBox(String label, String value, IconData icon) {
    return SizedBox(
      height: 60, // fixed height
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.yellow.shade700,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 10),
            Text("$label: $value",
                style: const TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  // Kotak My Reviews (ElevatedButton dengan tanda >)
  Widget buildMyReviewsBox(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow.shade700,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyReviewPage()),
          );
        },
        child: Row( //kotak my review ngan icon >
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                Text(
                    "My Reviews",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
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

      backgroundColor: Colors.black87,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "My Profile",
                style: GoogleFonts.nunito(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFBC02D),
                ),
              ),

              SizedBox(height: 20),

              CircleAvatar( //bulatan gambar profile
                radius: 60, //size bulatan
                backgroundColor: Colors.yellow.shade700,
                backgroundImage: (imagePath?.isNotEmpty ?? false)
                    ? FileImage(File(imagePath!))
                    : null, //kalau ad gambar papar dari file kalau x de null
                child: (imagePath?.isEmpty ?? true)
                    ? const Icon(Icons.person, size: 50, color: Colors.black)
                    : null,
              ),


              const SizedBox(height: 20),

              // papar Info boxes
              buildInfoBox("Username", username, Icons.person),
              buildInfoBox("Bio", bio, Icons.info),
              buildInfoBox("Gmail", email, Icons.email),
              buildInfoBox("Birthdate", dob, Icons.cake),

              const SizedBox(height: 9),

              // My Reviews box (button)
              buildMyReviewsBox(context),

              const SizedBox(height: 20),

              //edit button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade700,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                  ),
                 minimumSize: const Size(200, 50), // 👉 sama width & height
              ),
                onPressed: () {
                  Navigator.pushNamed(context, '/editprofile')
                      .then((_) => loadUserData()); //lepas balik dari edit refresh data
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profile"),
              ),

              const SizedBox(height: 10),

              //button logout
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(200, 50), // 👉 sama width & height
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('isLoggedIn'); //padam stats login
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(Icons.logout),
                label: const Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavPage(),
    );
  }
}
