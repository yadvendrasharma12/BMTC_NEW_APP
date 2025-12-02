
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../models/city_modal.dart';
import '../../models/country_modal.dart';
import '../../models/state_modal.dart';
import '../../utils/api_ends_points.dart';


class LocationService {

  static Future<List<CountryModel>> getCountries() async {
    final url = Uri.parse(ApiEndpoints.countryList);


    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (kDebugMode) {
          print(response.body);
        }

        if (body['success'] == 1) {
          final List data = body['state_detail'] ?? [];
          return data
              .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }


  static Future<List<StateModel>> getStates(String countryId) async {
    final url = Uri.parse(
        "${ApiEndpoints.stateList}?country_id=$countryId");


    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (kDebugMode) {
          print(response.body);
        }

        if (body['success'] == 1) {
          final List data = body['state_detail'] ?? [];
          return data
              .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// GET City List by State ID
  static Future<List<CityModel>> getCities(String stateId) async {
    final url =
    Uri.parse("${ApiEndpoints.cityList}?state_id=$stateId");
    // "get-city-list?state_id=23"

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (kDebugMode) {
          print(response.body);
        }

        if (body['success'] == 1) {
          final List data = body['city_detail'] ?? [];
          return data
              .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
