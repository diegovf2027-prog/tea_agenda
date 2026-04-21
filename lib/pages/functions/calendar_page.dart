import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tea_agenda/pages/functions/calendar_controller.dart';

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildCalendar());
  }

  Widget _buildCalendar() {
    return GetBuilder<CalendarController>(
      id: 'calendario',
      builder: (controller) {
        return TableCalendar(
          firstDay: controller.firstDay,
          lastDay: controller.lastDay,
          focusedDay: controller.focusedDay,

          selectedDayPredicate: (day) => isSameDay(day, controller.focusedDay),

          onDaySelected: (dayInicio, dayFim) async {
            controller.getDayReport(dayInicio);
          },
        );
      },
    );
  }
}
