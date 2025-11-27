import 'package:bmtc_app/app/core/app_colors.dart';
import 'package:bmtc_app/app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/add_booking_dailog.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  String getFormattedDate(DateTime date) {
    final day = date.day;
    final suffix = (day >= 11 && day <= 13)
        ? 'th'
        : {1: 'st', 2: 'nd', 3: 'rd'}[day % 10] ?? 'th';
    final month = [
      '',
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
      'December',
    ][date.month];
    return "$month $day$suffix, ${date.year}";
  }

  String getWeekdayName(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[date.weekday - 1];
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Date box with border + bg
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: AppColors.grey73
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: _selectedDay!,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          ).then((pickedDate) {
                            if (pickedDate != null) {
                              setState(() {
                                _selectedDay = pickedDate;
                                _focusedDay = pickedDate;
                              });
                            }
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${getWeekdayName(_selectedDay!)} • ${getFormattedDate(_selectedDay!)}",
                              style: AppTextStyles.linkText,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.blackColor,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // 🔹 "Today, Monday • November 27th, 2025" line
                    Text(
                      "${isToday(_selectedDay!) ? "Today, " : ""}"
                          "${getWeekdayName(_selectedDay!)} • ${getFormattedDate(_selectedDay!)}",
                      style: AppTextStyles.bodyStepText,
                    ),

                    const SizedBox(height: 16),

                    // 🔹 CALENDAR CARD
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10,
                        ),
                        child: TableCalendar(
                          firstDay: DateTime(2020, 1, 1),
                          lastDay: DateTime(2030, 12, 31),
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });

                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    width: 380,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Events",
                                                style:
                                                AppTextStyles.topHeading1,
                                              ),
                                              IconButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 22,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Events for ${getFormattedDate(_selectedDay!)}",
                                            style: AppTextStyles.topHeading3,
                                          ),
                                          const SizedBox(height: 16),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              border: Border.all(
                                                color:
                                                const Color(0xffE3E3E3),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                _DetailRow(
                                                  label: "Date",
                                                  value: getFormattedDate(
                                                      _selectedDay!),
                                                ),
                                                const _DetailRow(
                                                  label: "Client",
                                                  value: "Testpan India",
                                                ),
                                                const _DetailRow(
                                                  label: "Duration",
                                                  value: "1 day",
                                                ),
                                                const _DetailRow(
                                                  label: "Timings",
                                                  value:
                                                  "9:00 AM - 1:00 PM",
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Status",
                                                      style:
                                                      AppTextStyles
                                                          .bodyStepText,
                                                    ),
                                                    const SizedBox(width: 30),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4,
                                                      ),
                                                      decoration:
                                                      BoxDecoration(
                                                        color: const Color(
                                                            0xffFFF7C2),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10),
                                                      ),
                                                      child: Text(
                                                        "Exam pending",
                                                        style: AppTextStyles
                                                            .bodyStepText,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 36,
                                                  child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      side: const BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                    child: Text(
                                                      "View booking details",
                                                      style: AppTextStyles
                                                          .tableText,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          availableGestures: AvailableGestures.none,
                          calendarStyle: CalendarStyle(
                            todayDecoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronVisible: false,
                            rightChevronVisible: false,
                            titleTextFormatter: (date, locale) => '',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: AppTextStyles.bodyStepText,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.linkText,
            ),
          ),
        ],
      ),
    );
  }
}
