import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //baca input user
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async { //sahkan login user
    //bukak storage phone
    final prefs = await SharedPreferences.getInstance();
    //amik username yg tersimpan
    String savedName = prefs.getString('name') ?? '';
    //amik password yg tersimpan
    String savedPassword = prefs.getString('password') ?? '';

    //cek username @ pass kosong
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      //papar noti bawah screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all information'),duration: Duration(seconds: 2),),
      );
    } else if (usernameController.text == savedName && //compare user ngan data tersimpan
        passwordController.text == savedPassword) {
      await prefs.setBool('isLoggedIn', true); //simpan status login dlm storage

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful 🎉'),duration: Duration(seconds: 2),),
      );

      // 👉 Navigate ke main.dart (MyHomePage)
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Username or Password'),duration: Duration(seconds: 2),),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    //set style button login
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(220, 50),
      backgroundColor: const Color(0xFFFBC02D),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack( //susun bertindih background ngan login form
        children: [
          // Background lebah
          Positioned.fill( //papar gambar bg penuh screen
            child: Image.asset(
              'images/assets/mobeez_bg.jpg', // letak file lebah MOBEEZ
              fit: BoxFit.cover,
            ),
          ),

          // Overlay form login
          Align(
            alignment: Alignment.bottomCenter, //  duduk bawah sekali
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.transparent, //bg transparent
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // menegak rapat bawah
                children: [
                  const SizedBox(height: 20),

                  TextField(
                    //input username
                    controller: usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black54, //bg hitam transparent
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Color(0xFFFBC02D)),
                      prefixIcon: const Icon(Icons.person, color: Color(0xFFFBC02D)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFFBC02D)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFFBC02D), width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    //input pass
                    controller: passwordController,
                    obscureText: true, //teks jadi bullet (...)
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black54,
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Color(0xFFFBC02D)),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFFFBC02D)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFFBC02D)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFFFBC02D), width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton( //bila klik panggil function login user
                    onPressed: loginUser,
                    style: buttonStyle,
                    child: const Text("Login"),
                  ),

                  const SizedBox(height: 20),

                  Row( //baris link register
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton( //bila klik gi register
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          "Register here",
                          style: TextStyle(color: Color(0xFFFBC02D)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
