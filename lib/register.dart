import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'dart:io';
import 'login.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  DateTime? selectedDate; //simpan tarikh
  String? imagePath; //simpan path gambar

  Future<void> selectDate() async { // bukak calendar
    DateTime? pickedDate = await showDatePicker( //papar dialog calendar
      context: context,
      initialDate: DateTime(2000), //tarikh awal
      firstDate: DateTime(1950), // tarikh min
      lastDate: DateTime.now(), //tarikh hari ni
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate; //simpan tarikh pilihan
        dobController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker(); // bina objek image picker
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //bukak gallery biar user pilih gambar

    if (image != null) { //kalau ada simpan & update ui
      setState(() {
        imagePath = image.path;
      });
    }
  }

  Future<void> registerUser() async {
    final String username = usernameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String dob = dobController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty || dob.isEmpty) { //cek field kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all information'),duration: Duration(seconds: 2),),
      );
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', username);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setString('dob', dob);
      await prefs.setBool('isLoggedIn', true); // terus login lepas register
      if (imagePath?.isNotEmpty ?? false) {
        await prefs.setString('profileImage', imagePath!);
      } else {
        await prefs.setString('profileImage', '');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have been registered 🎉'),duration: Duration(seconds: 2),),
      );

      //  Navigate ke LoginPage lepas register
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    //style button register
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(220, 50),
      backgroundColor: Colors.yellow.shade700,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: Color(0xFFFBC02D), size: 40),
          onPressed: () {
            Navigator.pop(context);
          },
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 20),

            // Title atas avatar
            Text(
              "Register Information",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFBC02D), // kuning bee
              ),
            ),

            const SizedBox(height: 20),

            // avatar bulat ikut theme
            Align(
              alignment: Alignment.center,
              child: GestureDetector( //bulatan gambar. panggil pickimage
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.yellow.shade700,
                  backgroundImage: (imagePath?.isNotEmpty ?? false)
                      ? FileImage(File(imagePath!))
                      : null,
                  child: (imagePath?.isEmpty ?? true)
                      ? const Icon(Icons.person_add_alt_1_rounded,
                      size: 50, color: Colors.black)
                      : null,
                ),
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: const TextStyle(color: Color(0xFFFBC02D)),
                prefixIcon: const Icon(Icons.person, color: Color(0xFFFBC02D)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFFBC02D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFFBC02D), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Color(0xFFFBC02D)),
                prefixIcon: const Icon(Icons.email, color: Color(0xFFFBC02D)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFFBC02D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFFBC02D), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: dobController,
              readOnly: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Date Of Birth',
                labelStyle: const TextStyle(color: Color(0xFFFBC02D)),
                prefixIcon: const Icon(Icons.cake, color: Color(0xFFFBC02D)),
                suffixIcon: IconButton(
                  onPressed: selectDate,
                  icon: const Icon(Icons.calendar_month, color: Color(0xFFFBC02D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFFBC02D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFFBC02D), width: 2),
                ),
              ),
              onTap: selectDate,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Color(0xFFFBC02D)),
                prefixIcon: const Icon(Icons.lock, color: Color(0xFFFBC02D)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFFBC02D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xFFFBC02D), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: registerUser,
                style: buttonStyle,
                child: const Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
