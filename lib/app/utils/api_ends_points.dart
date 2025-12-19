class ApiEndpoints {
  static const String baseUrl = "http://staging.bookmytestcenter.com/api/api/v1";

  // Existing endpoints
  static const String register = "$baseUrl/store-exam-center";
  static const String login = "$baseUrl/login";
  static const String logout = "$baseUrl/logout";
  static const String sendOtp = "$baseUrl/send-otp";
  static const String resendOtp = "$baseUrl/resend-otp";
  static const String verifyOtp = "$baseUrl/verify-otp";
  static const String checkPhone = "$baseUrl/check-phone-exists";
  static const String mPinGenerate = "$baseUrl/store-mpin";
  static const String deleteAccount = "$baseUrl/delete-account";

  static const String centerType = "$baseUrl/get-center-type";
  static const String countryList = "$baseUrl/get-country-list";
  static const String stateList = "$baseUrl/get-state-list";
  static const String cityList = "$baseUrl/get-city-list";

  // New calendar endpoint
  static const String calendar = "$baseUrl/my-calendar";

  static const String projectDetail = "$baseUrl/project-detail";
  static const String updateBookingStatus = "$baseUrl/update-booking-status";
  static const String rejectBookingStatus = "$baseUrl/reject-booking-status";

  static const String settings = "$baseUrl/settings";
  static const String updateSettings = "$baseUrl/update-settings";
}
