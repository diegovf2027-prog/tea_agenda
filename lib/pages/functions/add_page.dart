import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/data/repositories/usuarios_repository.dart';

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
  final _usuariosRepo = UsuariosRepository();
  final TextEditingController _observationController = TextEditingController();
  File? _imagemSelecionada;
  String? _nomeAssinante;

  bool _alunoFaltou = false;
  int? _idAlimentacao;
  int? _idAtividade;
  List<int> _comportamentosSelecionados = [];
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
    _carregarAssinante();
    if (widget.registroDia != null) {
      final reg = widget.registroDia!;

      _observationController.text = reg['reg_observacao'] ?? '';
      _idAlimentacao = reg['reg_alimentacao'];
      _idAtividade = reg['reg_atividade'];
      _comportamentosSelecionados = _parseComportamentos(
        reg['reg_comportamento'],
      );
      _idHumor = reg['reg_humor'] ?? 3;
      _alunoFaltou = reg['reg_falta'] ?? false;
      _carregarComportamentosRelacionados();
    }
    _carregarDados();
  }

  Future<void> _carregarAssinante() async {
    final perfil = await _usuariosRepo.obterusUarioLogado();
    if (!mounted) return;
    setState(() {
      _nomeAssinante = perfil?['usu_nome']?.toString();
    });
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
    if (_alunoFaltou) return;

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
    if (!_alunoFaltou) {
      if (_idAlimentacao == null ||
          _idAtividade == null ||
          _comportamentosSelecionados.isEmpty) {
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
    }

    final comportamentoPrimario = _comportamentosSelecionados.isNotEmpty
        ? _comportamentosSelecionados.first
        : null;

    final registroDados = {
      'reg_aluno': widget.alunoId,
      'reg_usuario': supabase.auth.currentUser?.id,
      'reg_falta': _alunoFaltou,
      'reg_alimentacao': _alunoFaltou ? null : _idAlimentacao,
      'reg_atividade': _alunoFaltou ? null : _idAtividade,
      'reg_comportamento': _alunoFaltou ? null : comportamentoPrimario,
      'reg_humor': _alunoFaltou ? null : _idHumor,
      'reg_observacao': _alunoFaltou
          ? 'Aluno Faltou.'
          : _observationController.text.trim(),
      if (widget.registroDia == null && widget.dataSelecionada != null)
        'reg_created_at': widget.dataSelecionada!.toUtc().toIso8601String(),
    };

    try {
      int registroId;

      if (widget.registroDia != null) {
        // Modo edição: atualizar registro existente
        registroId = widget.registroDia!['reg_id'];
        await supabase
            .from('registros')
            .update(registroDados)
            .eq('reg_id', registroId);
      } else {
        // Modo novo registro: verificar se já existe registro do mesmo aluno no mesmo dia
        final dataVerificacao = widget.dataSelecionada ?? DateTime.now();
        final inicioDodia = DateTime(
          dataVerificacao.year,
          dataVerificacao.month,
          dataVerificacao.day,
        ).toUtc();
        final fimDodia = inicioDodia.add(const Duration(days: 1));

        final registrosExistentes = await supabase
            .from('registros')
            .select('reg_id')
            .eq('reg_aluno', widget.alunoId)
            .gte('reg_created_at', inicioDodia.toIso8601String())
            .lt('reg_created_at', fimDodia.toIso8601String());

        if (registrosExistentes.isNotEmpty) {
          // Já existe registro neste dia: fazer UPDATE
          registroId = registrosExistentes[0]['reg_id'] as int;
          await supabase
              .from('registros')
              .update(registroDados)
              .eq('reg_id', registroId);
        } else {
          // Nenhum registro neste dia: fazer INSERT
          final response = await supabase
              .from('registros')
              .insert(registroDados)
              .select('reg_id');

          registroId = (response as List).first['reg_id'] as int;
        }
      }

      await _salvarComportamentosRelacionados(registroId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      if (widget.registroDia == null) {
        _resetForm();
      } else if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _carregarComportamentosRelacionados() async {
    if (widget.registroDia == null) return;

    try {
      final tabela = await _resolverTabelaComportamento();
      final response = await supabase
          .from(tabela)
          .select('com_id')
          .eq('reg_id', widget.registroDia!['reg_id']);

      final selecionados = (response as List)
          .map((item) => int.tryParse(item['com_id'].toString()))
          .whereType<int>()
          .toList();

      if (mounted) {
        setState(() => _comportamentosSelecionados = selecionados);
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _comportamentosSelecionados = _parseComportamentos(
            widget.registroDia!['reg_comportamento'],
          ),
        );
      }
    }
  }

  Future<String> _resolverTabelaComportamento() async {
    final tabelas = [
      'registro_comportamento',
      'reg_comportamento',
      'registros_comportamentos',
      'registro_comportamentos',
    ];

    for (final tabela in tabelas) {
      try {
        await supabase.from(tabela).select('reg_id').limit(1);
        return tabela;
      } catch (_) {}
    }

    return 'registro_comportamento';
  }

  Future<void> _salvarComportamentosRelacionados(int registroId) async {
    final tabela = await _resolverTabelaComportamento();

    await supabase.from(tabela).delete().eq('reg_id', registroId);

    if (_comportamentosSelecionados.isEmpty) return;

    final payload = _comportamentosSelecionados
        .map((comId) => {'reg_id': registroId, 'com_id': comId})
        .toList();

    await supabase.from(tabela).insert(payload);
  }

  List<int> _parseComportamentos(dynamic valor) {
    if (valor == null) return [];
    if (valor is List) {
      return valor
          .map((item) => int.tryParse(item.toString()))
          .whereType<int>()
          .toList();
    }
    if (valor is int) return [valor];
    if (valor is String) {
      return valor
          .split(',')
          .map((item) => int.tryParse(item.trim()))
          .whereType<int>()
          .toList();
    }
    return [];
  }

  void _resetForm() {
    setState(() {
      _alunoFaltou = false;
      _idAlimentacao = null;
      _idAtividade = null;
      _comportamentosSelecionados = [];
      _idHumor = 3;
      _imagemSelecionada = null;
      _observationController.clear();
    });
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

  String _nomeHumor(int humorId) {
    switch (humorId) {
      case 1:
        return 'Precisa de apoio';
      case 2:
        return 'Em adaptação';
      case 3:
        return 'Regular';
      case 4:
        return 'Bem';
      case 5:
        return 'Muito bem';
      default:
        return 'Não informado';
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
              if (_nomeAssinante?.isNotEmpty == true) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.draw, size: 18, color: Colors.blueGrey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Assinando como: $_nomeAssinante',
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: _alunoFaltou
                      ? Colors.red.shade50
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _alunoFaltou
                        ? Colors.red.shade300
                        : Colors.grey.shade300,
                  ),
                ),
                child: CheckboxListTile(
                  title: Text(
                    'Aluno faltou neste dia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _alunoFaltou
                          ? Colors.red.shade900
                          : Colors.black87,
                    ),
                  ),
                  subtitle: const Text(
                    'Marque para registrar ausência do aluno.',
                  ),
                  value: _alunoFaltou,
                  activeColor: Colors.red,
                  onChanged: (bool? val) {
                    setState(() {
                      _alunoFaltou = val ?? false;
                    });
                  },
                ),
              ),

              const SizedBox(height: 16),

              Opacity(
                opacity: _alunoFaltou ? 0.4 : 1.0,
                child: AbsorbPointer(
                  absorbing: _alunoFaltou,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Alimentação"),
                      _buildDropdown(
                        _opcaoAlimentacao,
                        _idAlimentacao,
                        (val) => setState(() => _idAlimentacao = val),
                        'ali_id',
                        'nome',
                      ),

                      _buildLabel("Rotina"),
                      _buildDropdown(
                        _opcaoAtividades,
                        _idAtividade,
                        (val) => setState(() => _idAtividade = val),
                        'ati_id',
                        'nome',
                      ),

                      _buildLabel("Comportamento"),
                      _buildCheckGroup(
                        _opcaoComportamento,
                        _comportamentosSelecionados,
                        (val) =>
                            setState(() => _comportamentosSelecionados = val),
                        'com_id',
                        'nome',
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Observações',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          for (int i = 1; i <= 5; i++)
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _idHumor = i),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.face,
                                      size: 40,
                                      color: i <= _idHumor
                                          ? _corHumor(_idHumor)
                                          : Colors.grey[300],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _nomeHumor(i),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: i == _idHumor
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: i == _idHumor
                                            ? _corHumor(i)
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
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
      items: [
        const DropdownMenuItem<int>(value: -1, child: Text('Selecione...')),
        ...opcoes.map((opt) {
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
        }),
      ],
      onChanged: _alunoFaltou
          ? null
          : (value) {
              if (value == -1) {
                onChanged(null);
                return;
              }
              onChanged(value);
            },
    );
  }

  Widget _buildCheckGroup(
    List<Map<String, dynamic>> opcoes,
    List<int> valoresSelecionados,
    Function(List<int>) onChanged,
    String idKey,
    String textKey,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: opcoes.map((opt) {
          final id =
              opt[idKey] ?? opt['id'] ?? opt.values.firstWhere((v) => v is int);
          final nome =
              opt[textKey] ??
              opt['nome'] ??
              opt.values.firstWhere((v) => v is String);
          final idInt = id as int;
          final selecionado = valoresSelecionados.contains(idInt);

          return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            value: selecionado,
            activeColor: Colors.blue,
            title: Text(nome.toString()),
            onChanged: _alunoFaltou
                ? null
                : (bool? checked) {
                    final lista = List<int>.from(valoresSelecionados);

                    if (checked == true && !lista.contains(idInt)) {
                      lista.add(idInt);
                    } else if (checked == false && lista.contains(idInt)) {
                      lista.remove(idInt);
                    }

                    onChanged(lista);
                  },
          );
        }).toList(),
      ),
    );
  }
}
