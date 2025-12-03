
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static const String _keyCenterId = 'center_id';


  static Future<void> saveCenterId(int centerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCenterId, centerId);
  }

  static Future<int?> getCenterId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyCenterId);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

