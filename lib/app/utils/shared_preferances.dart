import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefs {

  static const String _mobileKey = 'mobile_phone';
  static const String _mpinKey = 'mpin';
  static const String _otpKey = 'otp';



  static Future<void> saveLoginData({
    required String mobilePhone,
    required String mpin,
    String? otp,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_mobileKey, mobilePhone);
    await prefs.setString(_mpinKey, mpin);
    if (otp != null) {
      await prefs.setString(_otpKey, otp);
    }
  }

  static Future<Map<String, String?>> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'mobile_phone': prefs.getString(_mobileKey),
      'mpin': prefs.getString(_mpinKey),
      'otp': prefs.getString(_otpKey),
    };
  }

  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_mobileKey);
    await prefs.remove(_mpinKey);
    await prefs.remove(_otpKey);
  }


  static Future<void> save(String centerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("center_id", centerId);
  }


  static Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("center_id");
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("center_id");
  }

  static Future<void> saveBookingId(String bookingId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('latest_booking_id', bookingId);
  }
  static Future<int?> getBookingId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('latest_booking_id');
  }

}
