import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

// Máscara para CPF
final maskCPF = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {"#": RegExp(r'[0-9]')},
);

class AdicionarAlunoPage extends StatefulWidget {
  final Map<String, dynamic>? alunoEdicao;
  const AdicionarAlunoPage({super.key, this.alunoEdicao});

  @override
  State<AdicionarAlunoPage> createState() => _AdicionarAlunoPageState();
}

class _AdicionarAlunoPageState extends State<AdicionarAlunoPage> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();

  DateTime? _dataNascimento;
  int? _turmaIdSelecionada;
  int? _escolaIdSelecionada;
  String? _cuidadorIdSelecionado;

  List<Map<String, dynamic>> _escolas = [];
  List<Map<String, dynamic>> _turmas = [];
  List<Map<String, dynamic>> _cuidadores = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _inicializarDados();
  }

  Future<void> _inicializarDados() async {
    try {
      final escolasData = await supabase
          .from('escolas')
          .select()
          .order('esc_nome');

      setState(() {
        _escolas = List<Map<String, dynamic>>.from(escolasData);
        _carregando = false;
      });

      if (widget.alunoEdicao != null) {
        final a = widget.alunoEdicao!;
        _nomeController.text = a['alu_nome'] ?? '';
        _cpfController.text = a['alu_cpf'] ?? '';
        _dataNascimento = a['alu_dt_nascimento'] != null
            ? DateTime.parse(a['alu_dt_nascimento'])
            : null;
        _escolaIdSelecionada = a['alu_escola'];

        if (_escolaIdSelecionada != null) {
          await _carregarListasDependente(_escolaIdSelecionada!);
          setState(() {
            _turmaIdSelecionada = a['alu_turma'];
            _cuidadorIdSelecionado = a['alu_cuidador'];
          });
        }
      }
    } catch (e) {
      debugPrint("Erro ao inicializar: $e");
    }
  }

  Future<void> _carregarListasDependente(int escolaId) async {
    final resultados = await Future.wait([
      supabase
          .from('turmas')
          .select()
          .eq('tur_escola', escolaId)
          .order('tur_numero'),
      supabase
          .from('usuarios_com_cargos')
          .select()
          .eq('usu_escola', escolaId)
          .ilike('cargo_nome', 'CUIDADOR%'),
    ]);

    setState(() {
      _turmas = List<Map<String, dynamic>>.from(resultados[0]);
      _cuidadores = List<Map<String, dynamic>>.from(resultados[1]);
    });
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: _dataNascimento ?? DateTime(2015),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (dataSelecionada != null) {
      setState(() => _dataNascimento = dataSelecionada);
    }
  }

  Future<void> _salvarAluno() async {
    if (_formKey.currentState!.validate() && _dataNascimento != null) {
      final cpfLimpo = _cpfController.text.replaceAll(RegExp(r'[^0-9]'), '');

      final dados = {
        'alu_nome': _nomeController.text.trim(),
        'alu_cpf': cpfLimpo,
        'alu_dt_nascimento': _dataNascimento!.toIso8601String().split('T')[0],
        'alu_escola': _escolaIdSelecionada,
        'alu_turma': _turmaIdSelecionada,
        'alu_cuidador': _cuidadorIdSelecionado,
      };

      try {
        if (widget.alunoEdicao != null) {
          await supabase
              .from('alunos')
              .update(dados)
              .eq('alu_id', widget.alunoEdicao!['alu_id']);
        } else {
          await supabase.from('alunos').insert(dados);
        }

        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alunoEdicao != null ? 'Editar Aluno' : 'Novo Aluno'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Aluno',
                  prefixIcon: Icon(Icons.child_care),
                ),
                validator: (v) => v!.isEmpty ? 'informe o nome' : null,
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: _cpfController,
                inputFormatters: [maskCPF],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  prefixIcon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o CPF';
                  if (!CPFValidator.isValid(value)) return 'CPF inválido';
                  return null;
                },
              ),

              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  _dataNascimento == null
                      ? "Selecionar Data de Nascimento"
                      : "Nascimento: ${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}",
                ),
                onTap: () => _selecionarData(context),
              ),

              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: _escolaIdSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Escola vinculada',
                  prefixIcon: Icon(Icons.school),
                ),
                items: _escolas
                    .map(
                      (e) => DropdownMenuItem(
                        value: e['esc_id'] as int,
                        child: Text(e['esc_nome']),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _escolaIdSelecionada = val;
                    _turmaIdSelecionada = null;
                    _cuidadorIdSelecionado = null;
                  });
                  if (val != null) _carregarListasDependente(val);
                },
                validator: (v) => v == null ? 'Selecione uma escola' : null,
              ),

              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: _turmaIdSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Turma',
                  prefixIcon: Icon(Icons.groups_3),
                ),
                disabledHint: const Text("Selecione a escola primeiro"),
                items: _turmas
                    .map(
                      (t) => DropdownMenuItem(
                        value: t['tur_id'] as int,
                        child: Text("Turma ${t['tur_numero']}"),
                      ),
                    )
                    .toList(),
                onChanged: _escolaIdSelecionada == null
                    ? null
                    : (val) => setState(() => _turmaIdSelecionada = val),
                validator: (v) => v == null ? 'Selecione a turma' : null,
              ),

              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _cuidadorIdSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Responsável (Cuidador)',
                  prefixIcon: Icon(Icons.person_pin),
                ),
                disabledHint: const Text("Selecione a escola primeiro"),
                items: _cuidadores
                    .map(
                      (c) => DropdownMenuItem(
                        value: c['usu_id'] as String,
                        child: Text(c['usu_nome']),
                      ),
                    )
                    .toList(),
                onChanged: _escolaIdSelecionada == null
                    ? null
                    : (val) => setState(() => _cuidadorIdSelecionado = val),
                validator: (v) => v == null ? 'Selecione o responsável' : null,
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarAluno,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  widget.alunoEdicao != null
                      ? 'Salvar Alterações'
                      : 'Cadastrar Aluno',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
