import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tea_agenda/data/repositories/usuarios_repository.dart';

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
      final data = await supabase
          .from('registros')
          .select('''
        *,
        alimentacao:reg_alimentacao(ali_status),
        atividades:reg_atividade(ati_status)
      ''')
          .eq('reg_aluno', alunoId);

      final nomesAssinantes = await UsuariosRepository().obterNomesPorIds(
        data.map((registro) => registro['reg_usuario']),
      );

      final tabelas = [
        'registro_comportamento',
        'reg_comportamento',
        'registros_comportamentos',
        'registro_comportamentos',
      ];

      Map<int, List<String>> comportamentosPorRegistro = {};
      for (final tabela in tabelas) {
        try {
          final associados = await supabase
              .from(tabela)
              .select('reg_id, com_id, comportamento:com_id(com_status)');

          for (final item in associados) {
            final regId = item['reg_id'] as int;
            final nome = item['comportamento']?['com_status'];
            if (nome != null) {
              comportamentosPorRegistro.putIfAbsent(regId, () => []);
              comportamentosPorRegistro[regId]!.add(nome.toString());
            }
          }
          break;
        } catch (_) {}
      }

      _recordsByDate.clear();
      selectedRecord = null;

      for (var reg in data) {
        final usuarioId = reg['reg_usuario']?.toString();
        reg['assinante_nome'] = usuarioId == null
            ? null
            : nomesAssinantes[usuarioId];
        final date = DateTime.parse(reg['reg_created_at']);
        final regId = reg['reg_id'] as int;
        final listaComportamentos = comportamentosPorRegistro[regId] ?? [];
        reg['comportamentos'] = listaComportamentos;
        reg['comportamento'] = listaComportamentos.isNotEmpty
            ? {'com_status': listaComportamentos.join(', ')}
            : null;
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
    selectedRecord =
        _recordsByDate[DateTime(selected.year, selected.month, selected.day)];
    update(['calendario', 'agenda']);
  }

  Color getHumorColor(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final reg = _recordsByDate[day];
    if (reg == null) return Colors.transparent;

    if (reg['reg_falta'] == true) {
      return Colors.grey.shade600;
    }

    switch (reg['reg_humor']) {
      case 1:
        return const Color(0xFFE00000);
      case 2:
        return const Color(0xFFE87500);
      case 3:
        return const Color(0xFFE5D500);
      case 4:
        return const Color(0xFF82D900);
      case 5:
        return const Color(0xFF00C82B);
      default:
        return Colors.transparent;
    }
  }
}
