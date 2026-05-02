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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                locale: 'pt_BR',
                firstDay: controller.firstDay,
                lastDay: controller.lastDay,
                focusedDay: controller.focusedDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Mês',
                  CalendarFormat.week: 'Semana',
                },
                headerStyle: const HeaderStyle(formatButtonVisible: false),

                selectedDayPredicate: (day) =>
                    isSameDay(day, controller.focusedDay),

                onDaySelected: (dayInicio, dayFim) async {
                  controller.getDayReport(dayInicio);
                },
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Registros do dia selecionado',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              if (controller.agenda.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Nenhum registro salvo para este dia.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: controller.agenda.map((item) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(item, style: const TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}