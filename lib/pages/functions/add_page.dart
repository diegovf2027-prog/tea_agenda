import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddPage extends StatefulWidget {
  final int alunoId;
  final Map<String, dynamic>? registroDia;
  final DateTime? dataSelecionada;
  const AddPage({
    super.key,
    required this.alunoId,
    this.registroDia,
    this.dataSelecionada,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final supabase = Supabase.instance.client;
  final TextEditingController _observationController = TextEditingController();
  File? _imagemSelecionada;

  int? _idAlimentacao;
  int? _idAtividade;
  int? _idComportamento;
  int _idHumor = 3;

  List<Map<String, dynamic>> _opcaoAlimentacao = [];
  List<Map<String, dynamic>> _opcaoAtividades = [];
  List<Map<String, dynamic>> _opcaoComportamento = [];

  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _inicializarFormulario();
  }

  void _inicializarFormulario() {
    if (widget.registroDia != null) {
      final reg = widget.registroDia!;

      _observationController.text = reg['reg_observacao'] ?? '';
      _idAlimentacao = reg['reg_alimentacao'];
      _idAtividade = reg['reg_atividade'];
      _idComportamento = reg['reg_comportamento'];
      _idHumor = reg['reg_humor'] ?? 3;
    }
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final alimentacao = await supabase.from('alimentacao').select();
      final atividades = await supabase.from('atividades').select();
      final comportamento = await supabase.from('comportamentos').select();

      setState(() {
        _opcaoAlimentacao = List<Map<String, dynamic>>.from(alimentacao);
        _opcaoAtividades = List<Map<String, dynamic>>.from(atividades);
        _opcaoComportamento = List<Map<String, dynamic>>.from(comportamento);
        _carregando = false;
      });
    } catch (e) {
      debugPrint("Erro ao carregar as opções: $e");
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  Future<void> _salvarRegistro() async {
    if (_idAlimentacao == null ||
        _idAtividade == null ||
        _idComportamento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha os campos de Alimentação, Atividade e Comportamento',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final registroDados = {
      'reg_aluno': widget.alunoId,
      'reg_alimentacao': _idAlimentacao,
      'reg_atividade': _idAtividade,
      'reg_comportamento': _idComportamento,
      'reg_humor': _idHumor,
      'reg_observacao': _observationController.text.trim(),
      // VERIFICAR COM O DIEGO
      if (widget.registroDia == null && widget.dataSelecionada != null)
        'reg_created_at': widget.dataSelecionada!.toIso8601String(),
    };

    try {
      if (widget.registroDia != null) {
        await supabase
            .from('registros')
            .update(registroDados)
            .eq('reg_id', widget.registroDia!['reg_id']);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pop();
      } else {
        await supabase.from('registros').insert(registroDados);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        _resetForm();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetForm() {
    setState(() {
      _idAlimentacao = null;
      _idAtividade = null;
      _idComportamento = null;
      _idHumor = 3;
      _imagemSelecionada = null;
      _observationController.clear();
    });
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

  @override
  Widget build(BuildContext context) {
    if (_carregando) return const Center(child: CircularProgressIndicator());

    final dataExibicao =
        widget.dataSelecionada ??
        (widget.registroDia != null &&
                widget.registroDia!['reg_created_at'] != null
            ? DateTime.parse(widget.registroDia!['reg_created_at'])
            : DateTime.now());
    final dataFormatada =
        '${dataExibicao.day}/${dataExibicao.month}/${dataExibicao.year}';
    final today = DateTime.now();
    final selectedDay = DateTime(
      dataExibicao.year,
      dataExibicao.month,
      dataExibicao.day,
    );
    final showBackNavigation =
        widget.registroDia != null ||
        (widget.dataSelecionada != null &&
            selectedDay.isBefore(DateTime(today.year, today.month, today.day)));

    return Scaffold(
      appBar: showBackNavigation
          ? AppBar(
              title: Text(
                widget.registroDia != null
                    ? "Editar Registro"
                    : "Novo Registro",
              ),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Avaliação do dia - $dataFormatada',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              _buildLabel("Alimentação"),
              _buildDropdown(
                _opcaoAlimentacao,
                _idAlimentacao,
                (val) => setState(() => _idAlimentacao = val),
                'ali_id',
                'nome',
              ),

              _buildLabel("Atividades"),
              _buildDropdown(
                _opcaoAtividades,
                _idAtividade,
                (val) => setState(() => _idAtividade = val),
                'ati_id',
                'nome',
              ),

              _buildLabel("Comportamento"),
              _buildDropdown(
                _opcaoComportamento,
                _idComportamento,
                (val) => setState(() => _idComportamento = val),
                'com_id',
                'nome',
              ),
              const SizedBox(height: 24),
              const Text(
                'Observações',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _observationController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Notas sobre o dia...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'Foto do Registro',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: _pickImage,
                icon: const Icon(
                  Icons.add_a_photo,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
              if (_imagemSelecionada != null)
                Image.file(_imagemSelecionada!, height: 150),

              const SizedBox(height: 24),
              const Text(
                'Humor do Dia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () => setState(() => _idHumor = i),
                      child: Icon(
                        Icons.face,
                        size: 45,
                        color: i <= _idHumor
                            ? _corHumor(_idHumor)
                            : Colors.grey[300],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetForm,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text("Limpar"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _salvarRegistro,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text("Salvar Registro"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 12),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _buildDropdown(
    List<Map<String, dynamic>> opcoes,
    int? valor,
    Function(int?) onChanged,
    String idKey,
    String textKey,
  ) {
    return DropdownButtonFormField<int>(
      initialValue: valor,
      hint: const Text("Selecione..."),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: opcoes.map((opt) {
        final id =
            opt[idKey] ?? opt['id'] ?? opt.values.firstWhere((v) => v is int);
        final nome =
            opt[textKey] ??
            opt['nome'] ??
            opt.values.firstWhere((v) => v is String);
        return DropdownMenuItem<int>(
          value: id as int,
          child: Text(nome.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
