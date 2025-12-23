import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/profile_data_model.dart';
import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';

class ProfileDataController extends GetxController {
  var isLoading = false.obs;
  var profileDataModel = Rxn<CenterResponse>();

  @override
  void onInit() {
    super.onInit();
    fetchCenterDetails();
  }

  Future<void> fetchCenterDetails() async {
    try {
      isLoading.value = true;


      String? centerId = await MySharedPrefs.get();
      if (centerId == null || centerId.isEmpty) {
        print("❌ Center ID not found in SharedPreferences");
        return;
      }

      final url = Uri.parse("${ApiEndpoints.baseUrl}/my-center?center_id=$centerId");
      final response = await http.get(url);

      print("✅ API RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == true && jsonData['data'] != null) {
          profileDataModel.value = CenterResponse.fromJson(jsonData);
          print("✅ Total Labs: ${profileDataModel.value?.data.labs.length ?? 0}");
        } else {
          print("❌ API returned false status or empty data");
        }
      } else {
        print("❌ Failed to fetch center details: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("❌ ERROR: $e");
      print(stackTrace);
    } finally {
      isLoading.value = false;
    }
  }
}
