import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/review_service.dart';
import 'bottomnav.dart';

class AddReviewPage extends StatefulWidget {
  final String movieTitle; // auto dapat dari DetailPage

  const AddReviewPage({super.key, required this.movieTitle});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final TextEditingController reviewController = TextEditingController();
  String userName = "Anonymous"; //sipan nama user default
  int selectedRating = 5;
  List<dynamic> reviews = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadReviews();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'Anonymous'; // amik name dari storage, kalau x de amik anonymous
    });
  }

  Future<void> loadReviews() async {
    final allReviews = await ReviewService.getReviews();
    final movieReviews = allReviews.where(
          (rev) => rev['movieTitle'] == widget.movieTitle, //filter review match movie title
    ).toList();
    setState(() {
      reviews = movieReviews.reversed.toList();
    });
  }

  Future<void> submitReview() async {
    print("Submit pressed"); // debug
    if (reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a review'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    bool success = await ReviewService.addReview(
      movieTitle: widget.movieTitle,
      username: userName,
      rating: selectedRating.toString(),
      review: reviewController.text,
    );

    print("Response success: $success"); // debug

    if (success) {
      reviewController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Review submitted successfully 🎉'),
        duration: Duration(seconds: 2),
        ),
      );
      loadReviews();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Review submitted successfully 🎉'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget buildStarButton(int star) { //rating
    return IconButton(
      icon: Icon(
        Icons.star,
        color: selectedRating >= star ? Color(0xFFFBC02D) : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          selectedRating = star;
        });
      },
    );
  }

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
  Widget build(BuildContext context) {
    String displayTitle = movieTitles[widget.movieTitle] ?? widget.movieTitle; //tukar short ke full title

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


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Review Form
            Card(
              color: Colors.grey[850],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Your Review",
                      style: const TextStyle(
                        color: Color(0xFFFBC02D), // kuning bee
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ⭐ Star rating row
                    Row(
                      children: [
                        buildStarButton(1),
                        buildStarButton(2),
                        buildStarButton(3),
                        buildStarButton(4),
                        buildStarButton(5),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // 📝 TextField ikut theme
                    TextField(
                      controller: reviewController,
                      maxLines : 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Write your review...',
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color(0xFFFBC02D)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color(0xFFFBC02D), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 🚀 Submit button ikut theme
                    SizedBox(
                      width: 160, // full width
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFBC02D), // kuning bee
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: submitReview,
                        icon: const Icon(Icons.send, color: Colors.black),
                        label: const Text(
                          'Submit Review',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 20),
            Text("Reviews for $displayTitle :",
                style: const TextStyle(color: Color(0xFFFBC02D), fontSize: 18)),

            reviews.isEmpty
                ? const Text("No reviews yet",
                style: TextStyle(color: Colors.white))
                : ListView.builder(//papar all review
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final rev = reviews[index];
                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rev['username'],
                          style: const TextStyle(
                            color: Color(0xFFFBC02D),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "⭐ Rating: ${rev['rating']}",
                          style: const TextStyle(color: Color(0xFFFBC02D)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          rev['review'] ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),

                        // hanya user sendiri boleh edit/delete
                        if (rev['username'] == userName)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFBC02D),
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size(100, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  final newText = await showDialog<String>(
                                    context: context,
                                    builder: (context) {
                                      final editController =
                                      TextEditingController(text: rev['review']);
                                      return AlertDialog(
                                        backgroundColor: const Color(0xFFFBC02D),
                                        title: const Text("Edit Review"),
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
                                            onPressed: () =>
                                                Navigator.pop(context, editController.text),
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
                                    loadReviews();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Your review is edited successfully ✅'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
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
                                  minimumSize: const Size(100, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: const Color(0xFFFBC02D),
                                      title: const Text("Delete Review?"),
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
                                    await ReviewService.deleteReview(rev['id'].toString());
                                    loadReviews();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Your review is deleted successfully 🗑️'),
                                          duration: Duration(seconds: 2),
                                        ),
                                    );
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
            )

          ],
        ),
      ),
      bottomNavigationBar: const BottomNavPage(),
    );
  }
}
