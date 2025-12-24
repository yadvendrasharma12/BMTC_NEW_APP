import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../controllers/celendar_controller.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController controller = Get.find();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  final List<int> _years = List.generate(8, (index) => 2025 + index);
  final List<int> _months = List.generate(12, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchCalendar();
  }

  void _fetchCalendar() {
    controller.fetchCalendar(month: _selectedMonth, year: _selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const SizedBox(height: 16),

            /// MONTH & YEAR DROPDOWN

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: _monthDropdown()),
                  const SizedBox(width: 16),
                  Expanded(child: _yearDropdown()),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  formatFullDate(_selectedDay ?? _focusedDay),
                  style: AppTextStyles.dashBordButton3,
                ),
              ),
            ),
            const SizedBox(height: 5),
            /// CALENDAR WIDGET
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(() {
                return TableCalendar(
                  key: ValueKey(controller.bookedDates.length), // 🔥 MOST IMPORTANT

                  firstDay: DateTime(2020),
                  lastDay: DateTime(2035),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),

                  onDaySelected: (selectedDay, focusedDay) async {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });

                    await controller.fetchBookingDetails(selectedDay);
                    _showEventsDialog(selectedDay);
                  },

                  headerVisible: false,
                  availableGestures: AvailableGestures.none,

                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      bool isBooked = controller.bookedDates.any((d) =>
                      d.year == day.year &&
                          d.month == day.month &&
                          d.day == day.day);

                      if (isBooked) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${day.day}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return null;
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "${day.day}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                );
              }),

              // child: TableCalendar(
              //   firstDay: DateTime(2020),
              //   lastDay: DateTime(2035),
              //   focusedDay: _focusedDay,
              //   selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              //
              //   /// ON DAY SELECTED → CALL API
              //   onDaySelected: (selectedDay, focusedDay) async {
              //     setState(() {
              //       _selectedDay = selectedDay;
              //       _focusedDay = focusedDay;
              //     });
              //
              //     /// CALL LIVE API
              //     await controller.fetchBookingDetails(selectedDay);
              //
              //     /// SHOW POPUP
              //     _showEventsDialog(selectedDay);
              //   },
              //
              //   headerVisible: false,
              //   availableGestures: AvailableGestures.none,
              //
              //   /// ---------------- Highlight Booked Dates ----------------
              //   calendarBuilders: CalendarBuilders(
              //     defaultBuilder: (context, day, focusedDay) {
              //       bool isBooked = controller.bookedDates.any((d) =>
              //       d.year == day.year &&
              //           d.month == day.month &&
              //           d.day == day.day);
              //
              //       if (isBooked) {
              //         return Container(
              //           margin: const EdgeInsets.all(4),
              //           decoration: BoxDecoration(
              //             color: Colors.green.shade400,
              //             shape: BoxShape.circle,
              //           ),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "${day.day}",
              //             style: const TextStyle(color: Colors.white),
              //           ),
              //         );
              //       }
              //
              //       return null; // fallback to default
              //     },
              //     selectedBuilder: (context, day, focusedDay) {
              //       return Container(
              //         margin: const EdgeInsets.all(4),
              //         decoration: BoxDecoration(
              //           color: Colors.blue,
              //           shape: BoxShape.circle,
              //         ),
              //         alignment: Alignment.center,
              //         child: Text(
              //           "${day.day}",
              //           style: const TextStyle(color: Colors.white),
              //         ),
              //       );
              //     },
              //     todayBuilder: (context, day, focusedDay) {
              //       return Container(
              //         margin: const EdgeInsets.all(4),
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.blue, width: 2),
              //           shape: BoxShape.circle,
              //         ),
              //         alignment: Alignment.center,
              //         child: Text(
              //           "${day.day}",
              //           style: const TextStyle(color: Colors.black),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ),

            const SizedBox(height: 8),
          ],
        );
      }),
    );
  }
  String formatFullDate(DateTime date) {
    String dayName = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ][date.weekday % 7];

    String monthName = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][date.month - 1];

    String daySuffix(int day) {
      if (day >= 11 && day <= 13) return 'th';
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    return "$dayName, $monthName ${date.day}${daySuffix(date.day)}, ${date.year}";
  }

  // =================== Month Dropdown ===================
  Widget _monthDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<int>(
        isExpanded: true,
        value: _selectedMonth,
        underline: const SizedBox(),
        items: _months
            .map((month) => DropdownMenuItem(
          value: month,
          child: Text(
            [
              'January',
              'February',
              'March',
              'April',
              'May',
              'June',
              'July',
              'August',
              'September',
              'October',
              'November',
              'December'
            ][month - 1],
          ),
        ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedMonth = value;
              _focusedDay = DateTime(_selectedYear, _selectedMonth, 1);
              _selectedDay = _focusedDay;
              _fetchCalendar();
            });
          }
        },
      ),
    );
  }

  // =================== Year Dropdown ===================
  Widget _yearDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<int>(
        isExpanded: true,
        value: _selectedYear,
        underline: const SizedBox(),
        items: _years
            .map((year) => DropdownMenuItem(value: year, child: Text("$year")))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedYear = value;
              _focusedDay = DateTime(_selectedYear, _selectedMonth, 1);
              _selectedDay = _focusedDay;
              _fetchCalendar();
            });
          }
        },
      ),
    );
  }

  // =================== Popup ===================
  void _showEventsDialog(DateTime selectedDay) {
    final exams = controller.selectedDateExams;
    final message = controller.dateMessage.value;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// HEADER TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Events", style: AppTextStyles.topHeading1),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 22),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                "Events for ${selectedDay.toLocal().toString().split(' ')[0]}",
                style: AppTextStyles.topHeading3,
              ),

              const SizedBox(height: 16),

              /// IF NO DATA
              if (exams.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    message,
                    style: AppTextStyles.tableText,
                  ),
                ),

              /// IF EXAMS AVAILABLE
              if (exams.isNotEmpty)
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      final exam = exams[index];
                      return Card(
                        color: Colors.grey.shade100,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _row("Exam Name", exam["exam_name"]),
                              _row("Client", exam["client_name"]),
                              _row("Seats Booked", exam["seats_booked"]),
                              _row("Start Date", exam["start_date"]),
                              _row("End Date", exam["end_date"]),
                              _row("Type", exam["type"]),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // =================== Key-Value Row ===================
  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.centerText),
          Text(value, style: AppTextStyles.tableText),
        ],
      ),
    );
  }
}

