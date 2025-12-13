

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/center_response_model.dart';
import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  var centerResponse = Rxn<CenterResponseModel>();

  @override
  void onInit() {
    super.onInit();
    fetchCenterDetails();
  }

  Future<void> fetchCenterDetails() async {
    try {
      isLoading(true);

      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) {
        print("❌ Center ID not found in SharedPreferences");
        isLoading.value = false;
        return;
      }

      final url = Uri.parse(
          "${ApiEndpoints.baseUrl}/my-center?center_id=$centerId");

      final response = await http.get(url);

      print("✅ API RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        centerResponse.value = CenterResponseModel.fromJson(jsonData);

        print("✅ CENTER NAME: ${centerResponse.value!.data.center.centerName}");
        print("✅ TOTAL LABS: ${centerResponse.value!.data.labs.length}");

        print(response.body);
        print(response.statusCode);
      }
    } catch (e) {
      print("❌ ERROR: $e");
    } finally {
      isLoading(false);
    }
  }
}
