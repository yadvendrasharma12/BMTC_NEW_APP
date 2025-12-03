import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/examCenter_Model.dart';

class ExamCenterService {
  static Future<Map<String, dynamic>?> storeExamCenter(ExamCenter center) async {
    const String url =
        "http://staging.bookmytestcenter.com/api/api/v1/store-exam-center";

    try {
      final body = jsonEncode(center.toJson());

      print("✅ API URL: $url");
      print("✅ REQUEST BODY: $body");

      final response = await http
          .post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
        },
        body: body,
      )
          .timeout(const Duration(seconds: 30));

      print("✅ STATUS CODE: ${response.statusCode}");
      print("✅ RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print("❌ API ERROR: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ API EXCEPTION: $e");
      return null;
    }
  }
}
