import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tea_agenda/pages/functions/add_page.dart';
import 'package:tea_agenda/pages/functions/calendar_controller.dart';

class CalendarPage extends StatelessWidget {
  final int alunoId;

  const CalendarPage({super.key, required this.alunoId});

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(
      CalendarController(alunoId: alunoId),
      tag: alunoId.toString(),
    );

    return Scaffold(
      body: GetBuilder<CalendarController>(
        id: 'calendario',
        tag: alunoId.toString(),
        initState: (state) {
          controller.fetchRecords();
        },
        builder: (controller) {
          if (controller.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color.fromARGB(255, 125, 126, 128),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          226,
                          228,
                          229,
                        ).withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: TableCalendar(
                    locale: 'pt-BR',
                    firstDay: controller.firstDay,
                    lastDay: controller.lastDay,
                    focusedDay: controller.focusedDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Mês',
                      CalendarFormat.week: 'Semana',
                    },
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      weekendStyle: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      outsideTextStyle: TextStyle(color: Colors.grey.shade400),
                      defaultTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      weekendTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.12),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 1.5),
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selectedDayPredicate: (day) =>
                        isSameDay(day, controller.selectedDay),
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.onDaySelected(selectedDay, focusedDay);
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        final color = controller.getHumorColor(day);
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color != Colors.transparent
                                ? color.withOpacity(0.15)
                                : Colors.grey.withOpacity(0.04),
                            shape: BoxShape.circle,
                            border: color != Colors.transparent
                                ? Border.all(
                                    color: color.withOpacity(0.7),
                                    width: 1.2,
                                  )
                                : null,
                          ),
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              fontWeight: color != Colors.transparent
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        final color = controller.getHumorColor(day);
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color != Colors.transparent
                                ? color.withOpacity(0.18)
                                : Colors.blue.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: color != Colors.transparent
                                  ? color
                                  : Colors.blue,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        final color = controller.getHumorColor(day);
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color != Colors.transparent
                                ? color
                                : Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Registros do dia:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),

                _buildAgendaDetails(controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAgendaDetails(CalendarController controller) {
    final record = controller.selectedRecord;

    if (record == null) {
      final dataSelecionada = controller.selectedDay;
      final dataFormatada =
          "${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}";

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nenhum registro salvo para esse dia.',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Get.to(
                    () => AddPage(
                      alunoId: alunoId,
                      registroDia: null,
                      dataSelecionada: dataSelecionada,
                    ),
                  );
                  controller.fetchRecords();
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Realizar registro do dia $dataFormatada',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final bool alunoFaltou = record['reg_falta'] ?? false;

    if (alunoFaltou) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildRecordCard(
              title: "Assinado por",
              content:
                  record['assinante_nome']?.toString() ?? 'Não identificado',
              icon: Icons.draw,
              iconColor: Colors.blueGrey,
            ),
            _buildRecordCard(
              title: "Observação do Dia",
              content: record['reg_observacao']?.toString().isNotEmpty == true
                  ? record['reg_observacao'].toString()
                  : "ALUNO FALTOU",
              icon: Icons.notes,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Get.to(
                    () => AddPage(
                      alunoId: alunoId,
                      registroDia: record,
                      dataSelecionada: controller.selectedDay,
                    ),
                  );
                  controller.fetchRecords();
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Editar Registro',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final String alimentacaoStatus = record['alimentacao'] != null
        ? record['alimentacao']['ali_status'] ?? 'Não informado'
        : 'Não informado';
    final String comportamentoStatus = _formatComportamento(
      record['comportamentos'] ?? record['comportamento'],
    );
    final String atividadeStatus = record['atividades'] != null
        ? record['atividades']['ati_status'] ?? 'Não informado'
        : 'Não informado';

    // Observações do dia
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildRecordCard(
            title: "Assinado por",
            content: record['assinante_nome']?.toString() ?? 'Não identificado',
            icon: Icons.draw,
            iconColor: Colors.blueGrey,
          ),
          if (record['reg_observacao'] != null &&
              record['reg_observacao'].toString().isNotEmpty)
            _buildRecordCard(
              title: "Observação do Dia",
              content: record['reg_observacao'].toString(),
              icon: Icons.notes,
              iconColor: Colors.blue,
            ),

          _buildRecordCard(
            title: "Alimentação",
            content: alimentacaoStatus,
            icon: Icons.restaurant,
            iconColor: Colors.blue,
          ),

          _buildRecordCard(
            title: "Comportamento",
            content: comportamentoStatus,
            icon: Icons.accessibility_new,
            iconColor: Colors.blue,
          ),

          _buildRecordCard(
            title: "Rotina",
            content: atividadeStatus,
            icon: Icons.extension,
            iconColor: Colors.blue,
          ),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () async {
                await Get.to(
                  () => AddPage(
                    alunoId: alunoId,
                    registroDia: record,
                    dataSelecionada: controller.selectedDay,
                  ),
                );

                controller.fetchRecords();
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                'Editar Registro',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatComportamento(dynamic comportamento) {
    if (comportamento == null) return 'Não informado';

    if (comportamento is List) {
      if (comportamento.isEmpty) return 'Não informado';
      return comportamento
          .map(
            (item) => item is Map
                ? (item['com_status'] ?? item.toString())
                : item.toString(),
          )
          .join(', ');
    }

    if (comportamento is Map) {
      return comportamento['com_status'] ?? 'Não informado';
    }

    return comportamento.toString();
  }

  Widget _buildRecordCard({
    required String title,
    required String content,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
