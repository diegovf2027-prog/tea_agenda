import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String _reportType = 'detalhado';
  String _dayClassification = 'seguiu';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  String _shareFormat = 'pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              "Tipo de Relatório",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Detalhado"),
                    value: 'detalhado',
                    groupValue: _reportType,
                    onChanged: (value) {
                      setState(() => _reportType = value!);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Resumido"),
                    value: 'resumido',
                    groupValue: _reportType,
                    onChanged: (value) {
                      setState(() => _reportType = value!);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "Intervalo de Tempo",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _selectStartDate(context),
                    child: Text("De: ${_formatDate(_startDate)}"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _selectEndDate(context),
                    child: Text("Até: ${_formatDate(_endDate)}"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Classificação do Dia",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Todos os dias"),
                    value: 'todos',
                    groupValue: _dayClassification,
                    onChanged: (value) {
                      setState(() => _dayClassification = value!);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Seguiu a rotina"),
                    value: 'seguiu',
                    groupValue: _dayClassification,
                    onChanged: (value) {
                      setState(() => _dayClassification = value!);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Não seguiu"),
                    value: 'nao_seguiu',
                    groupValue: _dayClassification,
                    onChanged: (value) {
                      setState(() => _dayClassification = value!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Formato de Compartilhamento",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: _shareFormat,
              items: const [DropdownMenuItem(value: 'pdf', child: Text('PDF'))],
              onChanged: (value) {
                setState(() => _shareFormat = value!);
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _generateReport(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("Gerar Relatório"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: _endDate,
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  void _selectEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _endDate = picked);
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  void _generateReport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Gerando relatório $_reportType em formato $_shareFormat...",
        ),
      ),
    );
  }
}