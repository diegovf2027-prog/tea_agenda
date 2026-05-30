import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class CalendarController extends GetxController {
  final supabase = Supabase.instance.client;
  final int alunoId;

  CalendarController({required this.alunoId});
  
  late DateTime firstDay;
  late DateTime lastDay;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  final Map<DateTime, Map<String, dynamic>> _recordsByDate = {};

  Map<String, dynamic>? selectedRecord;
  bool carregando = true;

  @override
  void onInit() {
    firstDay = DateTime.now().subtract(const Duration(days: 365));
    lastDay = DateTime.now().add(const Duration(days: 365));
    fetchRecords();
    super.onInit();
  }

  Future<void> fetchRecords() async {
    try {
      carregando = true;
      update(['calendario', 'agenda']);
      final data = await supabase.from('registros').select('''
        *,
        alimentacao:reg_alimentacao(ali_status),
        comportamento:reg_comportamento(com_status),
        atividades:reg_atividade(ati_status)
      ''').eq('reg_aluno', alunoId);

      _recordsByDate.clear();
      selectedRecord = null;

      for (var reg in data) {
        final date = DateTime.parse(reg['reg_created_at']);
        _recordsByDate[DateTime(date.year, date.month, date.day)] = reg;
      }

      onDaySelected(selectedDay, focusedDay);
    } catch (e) {
      print("Erro ao carregar calendário: $e");
    } finally {
      carregando = false;
      update(['calendario', 'agenda']);
    }
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    selectedRecord = _recordsByDate[DateTime(selected.year, selected.month, selected.day)];
    update(['calendario', 'agenda']);
  }

  Color getHumorColor(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final reg = _recordsByDate[day];
    if (reg == null) return Colors.transparent;

    switch (reg['reg_humor']) {
      case 1: return const Color(0xFFD40000); // Muito Ruim
      case 2: return const Color(0xFFD87A00); // Ruim
      case 3: return const Color(0xFFFFD900); // Neutro
      case 4: return const Color(0xFF32AF00); // Bom
      case 5: return const Color(0xFF7B02DF); // Muito Bom
      default: return Colors.transparent;
    }
  }
}