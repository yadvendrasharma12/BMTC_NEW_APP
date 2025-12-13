class BookingData {
  String? id;
  String? clientName;
  String? clientEmail;
  String? clientPhone;
  String? examName;
  String? examType;
  String? examDate;
  String? examLocation;
  String? seatsBooked;

  BookingData({
    this.id,
    this.clientName,
    this.clientEmail,
    this.clientPhone,
    this.examName,
    this.examType,
    this.examDate,
    this.examLocation,
    this.seatsBooked,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      id: json['id'],
      clientName: json['client_name'],
      clientEmail: json['client_email'],
      clientPhone: json['client_phone'],
      examName: json['exam_name'],
      examType: json['exam_type'],
      examDate: json['start_date'],   // better → exam_date "0000-00-00" hai
      examLocation: json['exam_location'],
      seatsBooked: json['seats_booked'],
    );
  }
}
