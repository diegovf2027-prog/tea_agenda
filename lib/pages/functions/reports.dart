import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:excel/excel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
    final todosSelecionados = [
      1,
      2,
      3,
      4,
      5,
    ].every((humor) => _humorSelecionado.contains(humor));

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
                  onPressed: () {
                    setState(() {
                      _humorSelecionado
                        ..clear()
                        ..addAll([1, 2, 3, 4, 5]);
                    });
                  },
                  child: Text(
                    "Todos",
                    style: TextStyle(
                      fontWeight: todosSelecionados
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: todosSelecionados ? Colors.blue : Colors.grey,
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
      final comportamentosPorRegistro =
          await _carregarComportamentosPorRegistro();

      for (final registro in dados) {
        final regId = registro['reg_id'] as int;
        final lista = comportamentosPorRegistro[regId] ?? [];
        registro['comportamentos'] = lista;
        if (lista.isNotEmpty) {
          registro['comportamento'] = {'com_status': lista.join(', ')};
        }
      }

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
    if (kIsWeb) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'A visualização do PDF não é suportada no navegador. Use o app em Android/iOS/desktop.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    setState(() => _gerando = true);
    try {
      final file = await _gerarPDF(dados);

      if (!await file.exists()) {
        throw Exception('O arquivo PDF não foi gerado corretamente.');
      }

      final result = await OpenFilex.open(file.path);
      if (result.type != ResultType.done) {
        await Share.shareXFiles([XFile(file.path)], text: 'Relatório em PDF');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao visualizar o PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<void> _generateAndDownloadPdf(List<Map<String, dynamic>> dados) async {
    if (kIsWeb) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'O download do PDF não é suportado no navegador. Use o app em Android/iOS/desktop.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

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
    if (kIsWeb) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'A visualização do Excel não é suportada no navegador. Use o app em Android/iOS/desktop.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    setState(() => _gerando = true);
    try {
      final file = await _gerarExcel(dados);

      if (!await file.exists()) {
        throw Exception('O arquivo Excel não foi gerado corretamente.');
      }

      final result = await OpenFilex.open(file.path);
      if (result.type != ResultType.done) {
        await Share.shareXFiles([XFile(file.path)], text: 'Relatório em Excel');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao visualizar o Excel: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _gerando = false);
    }
  }

  Future<void> _generateAndDownloadExcel(
    List<Map<String, dynamic>> dados,
  ) async {
    if (kIsWeb) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'O download do Excel não é suportado no navegador. Use o app em Android/iOS/desktop.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

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

  Future<Directory> _obterDiretorioRelatorio({
    required bool saveInDocuments,
  }) async {
    final baseDir = Directory.systemTemp;
    final dir = Directory('${baseDir.path}/tea_agenda_relatorios');
    await dir.create(recursive: true);
    return dir;
  }

  Future<File> _gerarExcel(
    List<Map<String, dynamic>> dados, {
    bool saveInDocuments = false,
  }) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Relatorio_TEA'];
    excel.delete('Sheet1');

    final agrupado = _agruparPorData(dados);

    sheetObject.appendRow([
      TextCellValue('Relatório de Acompanhamento - TEAgenda'),
    ]);
    sheetObject.appendRow([]);
    sheetObject.appendRow([
      TextCellValue('Data de Registro'),
      TextCellValue('Humor (Nível)'),
      TextCellValue('Alimentação'),
      TextCellValue('Comportamento'),
      TextCellValue('Rotina'),
      TextCellValue('Observações do Dia'),
      TextCellValue('Quantidade de Registros'),
    ]);

    for (var entry in agrupado.entries) {
      final registros = entry.value;
      final dataKey = entry.key;

      // Consolida múltiplos registros
      final humores = registros
          .map((r) => _textoHumor(r['reg_humor']))
          .toSet()
          .join(' / ');
      final alimentacoes = registros
          .map((r) => r['alimentacao']?['ali_status'] ?? 'Não informado')
          .toSet()
          .join(' / ');
      final comportamentos = _coletarComportamentosDoDia(registros).join(' / ');
      final atividades = registros
          .map((r) => r['atividades']?['ati_status'] ?? 'Não informado')
          .toSet()
          .join(' / ');
      final observacoes = registros
          .where((r) => r['reg_observacao'] != null)
          .map((r) => r['reg_observacao'].toString())
          .toSet()
          .join(' | ');

      sheetObject.appendRow([
        TextCellValue(dataKey),
        TextCellValue(humores),
        TextCellValue(alimentacoes),
        TextCellValue(comportamentos),
        TextCellValue(atividades),
        TextCellValue(observacoes.isEmpty ? 'Nenhuma' : observacoes),
        TextCellValue(registros.length.toString()),
      ]);
    }

    final fileBytes = excel.save();
    final directory = await _obterDiretorioRelatorio(
      saveInDocuments: saveInDocuments,
    );
    final file = File(
      '${directory.path}/relatorio_aluno_${widget.alunoId}.xlsx',
    );
    await file.writeAsBytes(fileBytes!);
    return file;
  }

  // Agrupa registros por data
  Map<String, List<Map<String, dynamic>>> _agruparPorData(
    List<Map<String, dynamic>> dados,
  ) {
    final agrupado = <String, List<Map<String, dynamic>>>{};
    for (var registro in dados) {
      final dateRaw = DateTime.parse(registro['reg_created_at']);
      final dataKey =
          "${dateRaw.day.toString().padLeft(2, '0')}/${dateRaw.month.toString().padLeft(2, '0')}/${dateRaw.year}";
      agrupado.putIfAbsent(dataKey, () => []).add(registro);
    }
    return agrupado;
  }

  // Relatório em PDF
  Future<File> _gerarPDF(
    List<Map<String, dynamic>> dados, {
    bool saveInDocuments = false,
  }) async {
    final pdf = pw.Document();
    final agrupado = _agruparPorData(dados);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          final widgets = <pw.Widget>[
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
          ];

          // Para cada dia, adiciona a tabela com dados do dia + observações
          for (var entry in agrupado.entries) {
            final registros = entry.value;
            final dataKey = entry.key;

            // Consolida múltiplos registros
            final humores = registros
                .map((r) => _textoHumor(r['reg_humor']))
                .toSet()
                .join(' / ');
            final alimentacoes = registros
                .map((r) => r['alimentacao']?['ali_status'] ?? 'N/A')
                .toSet()
                .join(' / ');
            final comportamentos = _coletarComportamentosDoDia(
              registros,
            ).join(' / ');
            final atividades = registros
                .map((r) => r['atividades']?['ati_status'] ?? 'N/A')
                .toSet()
                .join(' / ');

            // Adiciona tabela para o dia
            widgets.add(
              pw.Text(
                "Dia $dataKey",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            );
            widgets.add(pw.SizedBox(height: 8));

            widgets.add(
              pw.TableHelper.fromTextArray(
                headers: ['Humor', 'Alimentação', 'Comportamento', 'Rotina'],
                data: [
                  [humores, alimentacoes, comportamentos, atividades],
                ],
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
              ),
            );

            widgets.add(pw.SizedBox(height: 12));

            // Adiciona observações do dia (removendo duplicatas)
            final observacoesUnicas = registros
                .where(
                  (r) =>
                      r['reg_observacao'] != null &&
                      r['reg_observacao'].toString().isNotEmpty,
                )
                .map((r) => r['reg_observacao'].toString())
                .toSet()
                .toList();

            if (observacoesUnicas.isNotEmpty) {
              widgets.add(
                pw.Text(
                  "Observações:",
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              );

              for (int i = 0; i < observacoesUnicas.length; i++) {
                widgets.add(
                  pw.Bullet(
                    text: "Observação ${i + 1}: ${observacoesUnicas[i]}",
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                );
              }
            } else {
              widgets.add(
                pw.Text(
                  "Observações: Nenhuma",
                  style: const pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.grey,
                  ),
                ),
              );
            }

            widgets.add(pw.Divider());
            widgets.add(pw.SizedBox(height: 16));
          }

          return widgets;
        },
      ),
    );

    final directory = await _obterDiretorioRelatorio(
      saveInDocuments: saveInDocuments,
    );
    final file = File(
      '${directory.path}/relatorio_aluno_${widget.alunoId}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<Map<int, List<String>>> _carregarComportamentosPorRegistro() async {
    final tabelas = [
      'registro_comportamento',
      'reg_comportamento',
      'registros_comportamentos',
      'registro_comportamentos',
    ];

    final resultado = <int, List<String>>{};

    for (final tabela in tabelas) {
      try {
        final associados = await supabase
            .from(tabela)
            .select('reg_id, com_id, comportamento:com_id(com_status)');

        for (final item in associados) {
          final regId = item['reg_id'] as int;
          final nome = item['comportamento']?['com_status'];
          if (nome == null) continue;

          resultado.putIfAbsent(regId, () => []);
          final lista = resultado[regId]!;
          if (!lista.contains(nome.toString())) {
            lista.add(nome.toString());
          }
        }

        if (resultado.isNotEmpty) {
          return resultado;
        }
      } catch (_) {}
    }

    return resultado;
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

  List<String> _coletarComportamentosDoDia(
    List<Map<String, dynamic>> registros,
  ) {
    final itens = <String>{};

    for (final registro in registros) {
      final valores = registro['comportamentos'] ?? registro['comportamento'];
      final lista = _normalizarListaComportamentos(valores);
      for (final item in lista) {
        if (item.isNotEmpty) {
          itens.add(item);
        }
      }
    }

    return itens.toList();
  }

  List<String> _normalizarListaComportamentos(dynamic valor) {
    if (valor == null) return const [];

    if (valor is List) {
      return valor
          .map((item) {
            if (item is Map) {
              return (item['com_status'] ?? item['status'] ?? '').toString();
            }
            return item.toString();
          })
          .where((item) => item.trim().isNotEmpty)
          .toList();
    }

    if (valor is Map) {
      final status = valor['com_status'] ?? valor['status'];
      return status == null || status.toString().trim().isEmpty
          ? const []
          : [status.toString()];
    }

    final texto = valor.toString();
    return texto.trim().isEmpty ? const [] : [texto];
  }

  Color _corHumor(int humorId) {
    switch (humorId) {
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
        return Colors.grey;
    }
  }

  String _textoHumor(dynamic humorId) {
    switch (humorId) {
      case 1:
        return "Precisa de apoio";
      case 2:
        return "Em adaptação";
      case 3:
        return "Regular";
      case 4:
        return "Bem";
      case 5:
        return "Muito bem";
      default:
        return "Não Informado";
    }
  }
}
