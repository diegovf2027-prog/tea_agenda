import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:excel/excel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

class ReportsPage extends StatefulWidget {
  final int alunoId;

  const ReportsPage({super.key, required this.alunoId});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final supabase = Supabase.instance.client;
  final List<int> _humorSelecionado = [];
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  String _shareFormat = 'pdf';
  bool _gerando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Intervalo de Tempo",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _selectStartDate(context),
                    icon: const Icon(Icons.date_range, size: 18),
                    label: Text("De: ${_formatDate(_startDate)}"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _selectEndDate(context),
                    icon: const Icon(Icons.date_range, size: 18),
                    label: Text("Até: ${_formatDate(_endDate)}"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filtrar por Humor",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => setState(() => _humorSelecionado.clear()),
                  child: Text(
                    "Todos",
                    style: TextStyle(
                      fontWeight: _humorSelecionado.isEmpty
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _humorSelecionado.isEmpty
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_humorSelecionado.contains(i)) {
                          _humorSelecionado.remove(i);
                        } else {
                          _humorSelecionado.add(i);
                        }
                      });
                    },
                    child: Icon(
                      Icons.face,
                      size: 45,
                      color: _humorSelecionado.contains(i)
                          ? _corHumor(i)
                          : Colors.grey[300],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Formato de Compartilhamento",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _shareFormat,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'pdf', child: Text('PDF (.pdf)')),
                DropdownMenuItem(value: 'excel', child: Text('Excel (.xlsx)')),
              ],
              onChanged: (value) {
                setState(() => _shareFormat = value!);
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _gerando ? null : _fetchAndGenerateReport,
                icon: _gerando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.analytics, color: Colors.white),
                label: Text(
                  _gerando ? "Processando..." : "Gerar Relatório",
                  style: const TextStyle(
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
      ),
    );
  }

  // Busca dos dados no Supabase
  Future<void> _fetchAndGenerateReport() async {
    setState(() => _gerando = true);

    try {
      final dataFimFiltro = DateTime(
        _endDate.year,
        _endDate.month,
        _endDate.day,
        23,
        59,
        59,
      );

      var query = supabase
          .from('registros')
          .select('''
        *,
        alimentacao:reg_alimentacao(ali_status),
        comportamento:reg_comportamento(com_status),
        atividades:reg_atividade(ati_status)
      ''')
          .eq('reg_aluno', widget.alunoId)
          .gte('reg_created_at', _startDate.toIso8601String())
          .lte('reg_created_at', dataFimFiltro.toIso8601String());

      if (_humorSelecionado.isNotEmpty) {
        query = query.inFilter('reg_humor', _humorSelecionado);
      }

      final finalQuery = query.order('reg_created_at', ascending: true);

      final List<Map<String, dynamic>> dados = await finalQuery;

      if (dados.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nenhum registro encontrado no período selecionado.'),
            backgroundColor: Colors.orange,
          ),
        );
        setState(() => _gerando = false);
        return;
      }

      await _showReportOptions(dados);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao coletar dados do relatório: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<void> _showReportOptions(List<Map<String, dynamic>> dados) async {
    final format = _shareFormat;
    final selected = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'O que deseja fazer com o ${format.toUpperCase()}?',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop('preview'),
                  icon: const Icon(Icons.visibility),
                  label: Text('Visualizar ${format.toUpperCase()}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop('download'),
                  icon: const Icon(Icons.download),
                  label: Text('Baixar ${format.toUpperCase()}'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected == 'preview') {
      if (format == 'pdf') {
        await _generateAndPreviewPdf(dados);
      } else {
        await _generateAndPreviewExcel(dados);
      }
    } else if (selected == 'download') {
      if (format == 'pdf') {
        await _generateAndDownloadPdf(dados);
      } else {
        await _generateAndDownloadExcel(dados);
      }
    }
  }

  Future<void> _generateAndPreviewPdf(List<Map<String, dynamic>> dados) async {
    setState(() => _gerando = true);
    try {
      final file = await _gerarPDF(dados);
      await OpenFilex.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao visualizar o PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<void> _generateAndDownloadPdf(List<Map<String, dynamic>> dados) async {
    setState(() => _gerando = true);
    try {
      final file = await _gerarPDF(dados, saveInDocuments: true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF salvo em: ${file.path}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar o PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<void> _generateAndPreviewExcel(
    List<Map<String, dynamic>> dados,
  ) async {
    setState(() => _gerando = true);
    try {
      final file = await _gerarExcel(dados);
      await OpenFilex.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao visualizar o Excel: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<void> _generateAndDownloadExcel(
    List<Map<String, dynamic>> dados,
  ) async {
    setState(() => _gerando = true);
    try {
      final file = await _gerarExcel(dados, saveInDocuments: true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Excel salvo em: ${file.path}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar o Excel: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<File> _gerarExcel(
    List<Map<String, dynamic>> dados, {
    bool saveInDocuments = false,
  }) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Relatorio_TEA'];
    excel.delete('Sheet1');

    sheetObject.appendRow([
      TextCellValue('Relatório de Acompanhamento - TEAgenda'),
    ]);
    sheetObject.appendRow([]);
    sheetObject.appendRow([
      TextCellValue('Data de Registro'),
      TextCellValue('Humor (Nível)'),
      TextCellValue('Alimentação'),
      TextCellValue('Comportamento'),
      TextCellValue('Atividades'),
      TextCellValue('Observações do Dia'),
    ]);

    for (var row in dados) {
      final dateRaw = DateTime.parse(row['reg_created_at']);
      final dataString =
          "${dateRaw.day.toString().padLeft(2, '0')}/${dateRaw.month.toString().padLeft(2, '0')}/${dateRaw.year}";

      sheetObject.appendRow([
        TextCellValue(dataString),
        TextCellValue(_textoHumor(row['reg_humor'])),
        TextCellValue(row['alimentacao']?['ali_status'] ?? 'Não informado'),
        TextCellValue(row['comportamento']?['com_status'] ?? 'Não informado'),
        TextCellValue(row['atividades']?['ati_status'] ?? 'Não informado'),
        TextCellValue(row['reg_observacao'] ?? ''),
      ]);
    }

    final fileBytes = excel.save();
    final directory = saveInDocuments
        ? await getApplicationDocumentsDirectory()
        : await getTemporaryDirectory();
    final file = File(
      '${directory.path}/relatorio_aluno_${widget.alunoId}.xlsx',
    );
    await file.writeAsBytes(fileBytes!);
    return file;
  }

  // Relatório em PDF
  Future<File> _gerarPDF(
    List<Map<String, dynamic>> dados, {
    bool saveInDocuments = false,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                "Relatório de Acompanhamento - TEAgenda",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Período analítico: ${_formatDate(_startDate)} até ${_formatDate(_endDate)}",
            ),
            pw.SizedBox(height: 20),

            // Tabela o PDF
            pw.TableHelper.fromTextArray(
              headers: [
                'Data',
                'Humor',
                'Alimentação',
                'Comportamento',
                'Atividades',
              ],
              data: dados.map((item) {
                final dateRaw = DateTime.parse(item['reg_created_at']);
                return [
                  "${dateRaw.day}/${dateRaw.month}/${dateRaw.year}",
                  _textoHumor(item['reg_humor']),
                  item['alimentacao']?['ali_status'] ?? 'N/A',
                  item['comportamento']?['com_status'] ?? 'N/A',
                  item['atividades']?['ati_status'] ?? 'N/A',
                ];
              }).toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellAlignment: pw.Alignment.centerLeft,
            ),
            pw.SizedBox(height: 25),
            pw.Text(
              "Observações Descritivas:",
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.Divider(),
            for (var item in dados) ...[
              if (item['reg_observacao'] != null &&
                  item['reg_observacao'].toString().isNotEmpty) ...[
                pw.Bullet(
                  text:
                      "Dia ${DateTime.parse(item['reg_created_at']).day}: ${item['reg_observacao']}",
                  style: const pw.TextStyle(fontSize: 11),
                ),
                pw.SizedBox(height: 4),
              ],
            ],
          ];
        },
      ),
    );

    final directory = saveInDocuments
        ? await getApplicationDocumentsDirectory()
        : await getTemporaryDirectory();
    final file = File(
      '${directory.path}/relatorio_aluno_${widget.alunoId}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<void> _previewPdfReport() async {
    setState(() => _gerando = true);
    try {
      final dados = await _fetchReportData();
      if (dados.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nenhum registro encontrado no período selecionado.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final file = await _gerarPDF(dados);
      await OpenFilex.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao visualizar o PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<void> _downloadPdfReport() async {
    setState(() => _gerando = true);
    try {
      final dados = await _fetchReportData();
      if (dados.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nenhum registro encontrado no período selecionado.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final file = await _gerarPDF(dados, saveInDocuments: true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF salvo em: ${file.path}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar o PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<List<Map<String, dynamic>>> _fetchReportData() async {
    final dataFimFiltro = DateTime(
      _endDate.year,
      _endDate.month,
      _endDate.day,
      23,
      59,
      59,
    );

    var query = supabase
        .from('registros')
        .select('''
      *,
      alimentacao:reg_alimentacao(ali_status),
      comportamento:reg_comportamento(com_status),
      atividades:reg_atividade(ati_status)
    ''')
        .eq('reg_aluno', widget.alunoId)
        .gte('reg_created_at', _startDate.toIso8601String())
        .lte('reg_created_at', dataFimFiltro.toIso8601String());

    if (_humorSelecionado.isNotEmpty) {
      query = query.inFilter('reg_humor', _humorSelecionado);
    }

    final finalQuery = query.order('reg_created_at', ascending: true);
    return List<Map<String, dynamic>>.from(await finalQuery);
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

  Color _corHumor(int humorId) {
    switch (humorId) {
      case 1:
        return const Color(0xFFD40000);
      case 2:
        return const Color(0xFFD87A00);
      case 3:
        return const Color(0xFFFFD900);
      case 4:
        return const Color(0xFF32AF00);
      case 5:
        return const Color(0xFF7B02DF);
      default:
        return Colors.grey;
    }
  }

  String _textoHumor(dynamic humorId) {
    switch (humorId) {
      case 1:
        return "Muito Ruim";
      case 2:
        return "Ruim";
      case 3:
        return "Neutro";
      case 4:
        return "Bom";
      case 5:
        return "Muito Bom";
      default:
        return "Não Informado";
    }
  }
}
