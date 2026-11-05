import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String? imagePath;

  Widget buildDateField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        readOnly: true, // user tak boleh type manual
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFFBC02D)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFBC02D)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFBC02D), width: 2),
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          }
        },
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? "";
      bioController.text = prefs.getString('bio') ?? "";
      emailController.text = prefs.getString('email') ?? "";
      dobController.text = prefs.getString('dob') ?? "";
      imagePath = prefs.getString('profileImage');
    });
  }

  Future<void> pickImage(ImageSource source) async {
      // Kalau source camera, minta permission dulu
      if (source == ImageSource.camera) {
        var status = await Permission.camera.request();
        if (!status.isGranted) {
          // User tolak permission → jangan buka camera
          return;
        }
      }
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source); // bukak gallery
    if (image != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImage', image.path);
      setState(() {
        imagePath = image.path;
      });
    }
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('bio', bioController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('dob', dobController.text);
    Navigator.pop(context); // balik ke ProfilePage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MOBEEZ',
          textAlign: TextAlign.center,
          style: GoogleFonts.fasterOne(
            fontSize: 50,
            color: const Color(0xFFFBC02D),
          ),
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              "Edit Profile",
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFBC02D),
              ),
            ),

            SizedBox(height: 20),
            // Profile Picture
            GestureDetector(
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo),
                        title: const Text("Pick from Gallery"),
                        onTap: () {
                          Navigator.pop(context);
                          pickImage(ImageSource.gallery);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text("Take a Photo"),
                        onTap: () {
                          Navigator.pop(context);
                          pickImage(ImageSource.camera);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.yellow.shade700,
                backgroundImage: (imagePath?.isNotEmpty ?? false)
                    ? FileImage(File(imagePath!))
                    : null,
                child: (imagePath?.isEmpty ?? true)
                    ? const Icon(Icons.person_add_alt_1_rounded, size: 50, color: Colors.black)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Editable fields
            buildTextField("Username", nameController),
            buildTextField("Bio", bioController),
            buildTextField("Gmail", emailController),
            buildDateField("Birthdate", dobController),


            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBC02D),
                foregroundColor: Colors.black,
              ),
              onPressed: saveProfile,
              icon: const Icon(Icons.save),
              label: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFFBC02D)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFBC02D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFBC02D), width: 2),
          ),
        ),
      ),
    );
  }
}
