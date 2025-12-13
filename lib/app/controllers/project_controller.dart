import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/project_model.dart';
import '../utils/api_ends_points.dart';
import '../utils/shared_preferances.dart';

class ProjectController extends GetxController {
  var isLoading = true.obs;
  var isSubmitting = false.obs;

  String projectId = "";
  var projectData = Rxn<ProjectData>();

  void setProjectId(String id) {
    projectId = id;
  }

  // ------------------ FETCH PROJECT DETAIL ------------------
  Future<void> fetchProjectDetail() async {
    print("🔹 Starting fetchProjectDetail...");
    print("🔹 projectId received: $projectId");

    if (projectId.isEmpty) {
      print("❌ ERROR: projectId is EMPTY!");
      return;
    }

    try {
      String? centerId = await MySharedPrefs.get();
      print("🔹 centerId from SharedPrefs: $centerId");

      var uri = Uri.parse(ApiEndpoints.projectDetail);
      var request = http.MultipartRequest('POST', uri);

      request.fields['center_id'] = centerId ?? '';
      request.fields['project_id'] = projectId;

      print("🔹 Sending request:");
      print("   center_id: ${request.fields['center_id']}");
      print("   project_id: ${request.fields['project_id']}");

      var response = await http.Response.fromStream(await request.send());

      print("🔹 Status Code: ${response.statusCode}");
      print("🔹 Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        ProjectModel project = ProjectModel.fromJson(jsonData);

        if (project.status == true && project.data != null) {
          projectData.value = project.data;
          print("✅ Project data loaded");
        } else {
          print("❌ API returned error");
        }
      }
    } catch (e) {
      print("❌ Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------ ACCEPT BOOKING ------------------
  Future<Map<String, dynamic>> acceptBooking() async {
    isSubmitting.value = true;

    try {
      String? centerId = await MySharedPrefs.get();

      print("📨 Sending Accept Booking Request...");
      print("➡ center_id: $centerId");
      print("➡ project_id: $projectId");

      var uri = Uri.parse(ApiEndpoints.updateBookingStatus);
      var request = http.MultipartRequest('POST', uri);

      request.fields['center_id'] = centerId ?? '';
      request.fields['project_id'] = projectId;

      var response = await http.Response.fromStream(await request.send());

      print("📥 Accept Response: ${response.body}");

      return jsonDecode(response.body);
    } catch (e) {
      print("❌ Accept API Error: $e");
      return {"status": false, "message": "Something went wrong"};
    } finally {
      isSubmitting.value = false;
    }
  }

  // ------------------ REJECT BOOKING ------------------
  Future<Map<String, dynamic>> rejectBooking() async {
    isSubmitting.value = true;

    try {
      String? centerId = await MySharedPrefs.get();

      print("📨 Sending Reject Booking Request...");
      print("➡ center_id: $centerId");
      print("➡ project_id: $projectId");

      var uri = Uri.parse(ApiEndpoints.rejectBookingStatus);
      var request = http.MultipartRequest('POST', uri);

      request.fields['center_id'] = centerId ?? '';
      request.fields['project_id'] = projectId;

      var response = await http.Response.fromStream(await request.send());

      print("📥 Reject Response: ${response.body}");

      return jsonDecode(response.body);
    } catch (e) {
      print("❌ Reject API Error: $e");
      return {"status": false, "message": "Something went wrong"};
    } finally {
      isSubmitting.value = false;
    }
  }
}
