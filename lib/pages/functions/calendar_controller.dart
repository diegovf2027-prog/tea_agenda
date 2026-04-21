import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  late DateTime firstDay;
  late DateTime lastDay;
  late DateTime focusedDay;

  List<String> agenda = [];

  CalendarFormat calendarFormat = CalendarFormat.month;

  String locale = 'pt_BR';

  @override
  void onInit() {
    firstDay = DateTime.now().add(const Duration(days: -365));
    lastDay = DateTime.now().add(const Duration(days: 365));
    focusedDay = DateTime.now();

    getDayReport(focusedDay);

    super.onInit();
  }

  Future getDayReport(data) async {
    focusedDay = data;

    getAgenda(data);

    update(['calendario', 'agenda']);
  }

  void getAgenda(data) {
    // Simulação de obtenção de dados para o dia selecionado
    agenda = [
      'Reunião com equipe às 10:00',
      'Almoço com cliente às 12:30',
      'Entrega de relatório às 15:00',
    ];
  }
}
