import 'dart:convert';
import 'package:bmtc_app/app/utils/api_ends_points.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/center_type_modal.dart';

class CenterService {
  static Future<List<CenterTypeModel>> getCenterTypes() async {
    final url = Uri.parse(ApiEndpoints.centerType);

    try {
      final response = await http.get(url);


      if (kDebugMode) {
        print("🔹 GET: $url");
        print("🔹 Status Code: ${response.statusCode}");
        print("🔹 Body: ${response.body}");
      }

      if (response.statusCode == 200) {

        late final dynamic body;
        try {
          body = jsonDecode(response.body);
        } catch (e) {
          if (kDebugMode) {
            print("❌ JSON decode error (Center Types): $e");
          }
          return [];
        }


        final success = body['success'];
        if (success == 1 || success == "1") {
          final List<dynamic> data = body['data'] ?? [];

          return data
              .map((e) => CenterTypeModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          if (kDebugMode) {
            print("⚠️ API success != 1 : $success");
            print("⚠️ Message: ${body['message']}");
          }
          return [];
        }
      } else {
        if (kDebugMode) {
          print(
              "⚠️ getCenterTypes failed. Status: ${response.statusCode}, Body: ${response.body}");
        }
        return [];
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print("🔥 Exception in getCenterTypes: $e");
        print(stack);
      }
      return [];
    }
  }
}
