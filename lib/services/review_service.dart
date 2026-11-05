import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewService {
  static const String url = //google app script
      'https://script.google.com/macros/s/AKfycbyP6fFHoY0douYKSn0DkpmOgUsvfuYLPZBy3E1mAvJK3B6B8hNNYf4QgPw_Xit7aaey2g/exec';

  // CREATE
  static Future<bool> addReview({ //hantar review baru ke server
    required String movieTitle,
    required String username,
    required String rating,
    required String review,
  }) async {
    final response = await http.post( //hantar POST req ke server ngan data review
      Uri.parse(url),
      body: {
        'action': 'add',
        'movieTitle': movieTitle,
        'username': username,
        'rating': rating,
        'review': review,
      },
    );

    final body = response.body.trim();
    print("AddReview raw response: '$body'");

    // lebih fleksibel: detect "success" walaupun ada newline/huruf besar
    return response.statusCode == 200 &&
        body.toLowerCase().contains("success");
  }

  // READ
  static Future<List<dynamic>> getReviews() async {
    final response = await http.get(Uri.parse(url)); //hantar GET ke server
    print("GetReviews raw response: '${response.body}'");
    return jsonDecode(response.body);
  }

  // UPDATE
  static Future<bool> updateReview({
    required String id,
    required String newReview,
    required String newRating,
  }) async {
    final response = await http.post( //hantar POST ngan data baru
      Uri.parse(url),
      body: {
        'action': 'update',
        'id': id,
        'review': newReview,
        'rating': newRating,
      },
    );

    final body = response.body.trim();
    print("UpdateReview raw response: '$body'");

    return response.statusCode == 200 &&
        body.toLowerCase().contains("updated");
  }

  // DELETE
  static Future<bool> deleteReview(String id) async {
    final response = await http.post( //hantar post untuk delete
      Uri.parse(url),
      body: {
        'action': 'delete',
        'id': id,
      },
    );

    final body = response.body.trim();
    print("DeleteReview raw response: '$body'");

    return response.statusCode == 200 &&
        body.toLowerCase().contains("deleted");
  }
}
