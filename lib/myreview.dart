import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/review_service.dart';
import 'bottomnav.dart';

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({super.key});

  @override
  State<MyReviewPage> createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {
  List<dynamic> myReviews = [];
  String username = "";

  final Map<String, String> movieTitles = {
    "love_disappears": "Even If This Love Disappears From World Tonight",
    "kings_warden": "The King's Warden",
    "abigail" : "Abigail",
    "boboiboy_galaxy" : "Boboiboy Galaxy",
    "exhuma" : "Exhuma",
    "eyes_tell" : "Your Eyes Tell",
    "howl" : "Howl's Moving Castle",
    "khabi_khushi" : "Khabi Khushi Kabhie Gham",
    "kuch_kuch" : "Kuch Kuch Hota Hai",
    "lalaland" : "Lalaland",
    "last_night" : "Re/Member: The Last Night",
    "man_in_love" : "Man in Love",
    "mat_kilau" : "Mat Kilau",
    "princess_diaries" : "The Princess Diaries",
    "ralph_internet" : "Ralph Breaks The Internet",
    "re_member" : "Re/Member",
    "showman" : "The Greatest Showman",
    "spirited_away" : "The Spirited Away",
    "tangled" : "Tangled",
    "train_busan" : "Train To Busan",
    "your_name" : "Your Name",
  };

  @override
  void initState() {
    super.initState();
    loadUserData().then((_) => loadMyReviews());
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('name') ?? ""; // pastikan konsisten
    });
  }

  Future<void> loadMyReviews() async { //amik semua review milik user tu
    final allReviews = await ReviewService.getReviews();

    // 👉 Tambah debug print
    print("All reviews: $allReviews");
    print("Current username: $username");

    final userReviews = // filter username match ngan current user
    allReviews.where((rev) => rev['username'] == username).toList();

    print("Filtered reviews: $userReviews");

    setState(() { //update ui
      myReviews = userReviews;
    });
  }



  @override
  Widget build(BuildContext context) {

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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          
          Text(
            "My Reviews",
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFBC02D),
            ),
          ),

          const SizedBox(height: 20),

          Expanded (
            child: myReviews.isEmpty
                ? const Center(
              child: Text("You haven't written any reviews yet.",
                style: TextStyle(color: Colors.white),
              ),
            )
                : ListView.builder(
              itemCount: myReviews.length,
              itemBuilder: (context, index) {
                final rev = myReviews[index];
                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("🎬 ${movieTitles[rev['movieTitle']] ?? rev['movieTitle']}",
                            style: const TextStyle(
                                color: Color(0xFFFBC02D),
                                fontWeight: FontWeight.bold)),
                        Text("⭐ Rating: ${rev['rating']}",
                            style: const TextStyle(color: Colors.white)),
                        Text(rev['review'] ?? '',
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFBC02D),
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () async {
                                final newText = await showDialog<String>(
                                  context: context,
                                  builder: (context) {
                                    final editController = TextEditingController(text: rev['review']);
                                    return AlertDialog(
                                      backgroundColor: const Color(0xFFFBC02D), // kuning bee
                                      title: const Text("Edit Review",
                                          style: TextStyle(color: Colors.black)), // tulisan hitam
                                      content: TextField(
                                        controller: editController,
                                        style: const TextStyle(color: Colors.black),
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black54),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black54, width: 2),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(foregroundColor: Colors.black),
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(foregroundColor: Colors.black),
                                          onPressed: () => Navigator.pop(context, editController.text),
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (newText != null && newText.isNotEmpty) {
                                  await ReviewService.updateReview(
                                    id: rev['id'].toString(),
                                    newReview: newText,
                                    newRating: rev['rating'].toString(),
                                  );
                                  loadMyReviews();
                                }
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text("Edit"),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFBC02D),
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: const Color(0xFFFBC02D), // kuning bee
                                    title: const Text("Delete Review?",
                                        style: TextStyle(color: Colors.black)),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(foregroundColor: Colors.black),
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(foregroundColor: Colors.black),
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await ReviewService.deleteReview(
                                      rev['id'].toString());
                                  loadMyReviews();
                                }
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text("Delete"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavPage(),
    );
  }
}
