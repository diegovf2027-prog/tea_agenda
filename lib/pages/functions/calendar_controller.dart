import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  late DateTime firstDay;
  late DateTime lastDay;
  late DateTime focusedDay;

  List<String> agenda = [];
  final Map<DateTime, List<String>> _records = {};

  CalendarFormat calendarFormat = CalendarFormat.month;

  String locale = 'pt_BR';

  @override
  void onInit() {
    firstDay = DateTime.now().add(const Duration(days: -365));
    lastDay = DateTime.now().add(const Duration(days: 365));
    focusedDay = DateTime.now();

    _loadMockRecords();
    getDayReport(focusedDay);

    super.onInit();
  }

  Future<void> getDayReport(DateTime date) async {
    focusedDay = date;
    agenda = _loadDayRecords(date);
    update(['calendario', 'agenda']);
  }

  List<String> _loadDayRecords(DateTime date) {
    final normalized = _normalizeDate(date);
    return _records[normalized] ?? [];
  }

  void addDayRecord(DateTime date, String record) {
    final normalized = _normalizeDate(date);
    final list = _records.putIfAbsent(normalized, () => []);
    list.add(record);

    if (isSameDay(date, focusedDay)) {
      getDayReport(date);
    }
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void _loadMockRecords() {
    final today = _normalizeDate(DateTime.now());
    _records[today] = [
      'Registro exemplo: criança chegou bem disposta',
      'Observação: realizou todas as atividades',
    ];
    _records[_normalizeDate(DateTime.now().subtract(const Duration(days: 1)))] =
        ['Registro de ontem: apresentou dificuldade em concentração'];
    _records[_normalizeDate(DateTime(today.year, 5, 1))] = [
      'Alimentação: ',
      'Atividades: ',
      'Humor: ',
      'Observações: ',
    ];
  }
}