class BookingCreationResponse {
  final String status;
  final String message;
  final int bookingId;

  BookingCreationResponse({
    required this.status,
    required this.message,
    required this.bookingId,
  });

  factory BookingCreationResponse.fromJson(Map<String, dynamic> json) {
    return BookingCreationResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      bookingId: json['booking_id'] ?? 0,
    );
  }
}
