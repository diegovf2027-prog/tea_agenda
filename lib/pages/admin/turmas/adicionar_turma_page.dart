import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdicionarTurmaPage extends StatefulWidget {
  final Map<String, dynamic>? turmaEdicao;
  const AdicionarTurmaPage({super.key, this.turmaEdicao});

  @override
  State<AdicionarTurmaPage> createState() => _AdicionarTurmaPageState();
}

class _AdicionarTurmaPageState extends State<AdicionarTurmaPage> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  final _numeroController = TextEditingController();

  int? _turnoIdSelecionado;
  int? _anoIdSelecionado;
  int? _escolaIdSelecionada;
  String? _professorIdSelecionado;

  List<Map<String, dynamic>> _turnos = [];
  List<Map<String, dynamic>> _anos = [];
  List<Map<String, dynamic>> _escolas = [];
  List<Map<String, dynamic>> _professores = [];

  @override
  void initState() {
    super.initState();
    _inicializarDados();
  }

  Future<void> _inicializarDados() async {
    try {
      final resultados = await Future.wait([
        supabase.from('turnos').select(),
        supabase.from('anos').select(),
        supabase.from('escolas').select(),
      ]);

      setState(() {
        _turnos = List<Map<String, dynamic>>.from(resultados[0]);
        _anos = List<Map<String, dynamic>>.from(resultados[1]);
        _escolas = List<Map<String, dynamic>>.from(resultados[2]);
      });

      if (widget.turmaEdicao != null) {
        _numeroController.text = widget.turmaEdicao!['tur_numero'].toString();
        _turnoIdSelecionado = widget.turmaEdicao!['tur_turno'];
        _anoIdSelecionado = widget.turmaEdicao!['tur_ano'];
        _escolaIdSelecionada = widget.turmaEdicao!['tur_escola'];

        await _carregarProfessores(_escolaIdSelecionada!);

        setState(() {
          _professorIdSelecionado = widget.turmaEdicao!['tur_professor'];
        });
      }
    } catch (e) {
      debugPrint("Erro ao carregar dados: $e");
    }
  }

  Future<void> _carregarProfessores(int escolaId) async {
    try {
      final lista = await supabase
          .from('usuarios_com_cargos')
          .select()
          .eq('usu_escola', escolaId)
          .ilike('cargo_nome', 'PROFESSOR%');

      setState(() {
        _professores = List<Map<String, dynamic>>.from(lista);
      });
    } catch (e) {
      debugPrint("Erro ao carregar professores: $e");
    }
  }

  Future<void> _salvarTurma() async {
    if (_formKey.currentState!.validate()) {
      final dados = {
        'tur_numero': int.parse(_numeroController.text),
        'tur_turno': _turnoIdSelecionado,
        'tur_ano': _anoIdSelecionado,
        'tur_escola': _escolaIdSelecionada,
        'tur_professor': _professorIdSelecionado,
      };

      try {
        if (widget.turmaEdicao != null) {
          await supabase
              .from('turmas')
              .update(dados)
              .eq('tur_id', widget.turmaEdicao!['tur_id']);
        } else {
          await supabase.from('turmas').insert(dados);
        }

        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.turmaEdicao != null
                  ? 'Turma atualizada!'
                  : 'Turma cadastrada!',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao salvar: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.turmaEdicao != null ? 'Editar Turma' : 'Nova Turma'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(
                  labelText: 'Número da Turma',
                  prefixIcon: Icon(Icons.door_front_door),
                ),
                validator: (v) => v!.isEmpty ? 'Informe o número' : null,
              ),

              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: _turnoIdSelecionado,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Turno',
                  prefixIcon: Icon(Icons.schedule),
                ),
                items: _turnos.map((t) {
                  return DropdownMenuItem<int>(
                    value: t['trn_id'] as int,
                    child: Text(t['trn_nome']),
                  );
                }).toList(),
                onChanged: (val) {
                  print("Turno selecionado: $val");
                  setState(() => _turnoIdSelecionado = val);
                },
              ),

              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: _anoIdSelecionado,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Ano Letivo',
                  prefixIcon: Icon(Icons.event),
                ),
                items: _anos.map((a) {
                  return DropdownMenuItem<int>(
                    value: a['ano_id'] as int,
                    child: Text("${a['ano_numero']}º Ano"),
                  );
                }).toList(),
                onChanged: (val) {
                  print("Ano selecionado: $val");
                  setState(() => _anoIdSelecionado = val);
                },
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
                onChanged: (val) async {
                  setState(() {
                    _escolaIdSelecionada = val;
                    _professorIdSelecionado = null;
                    _professores = [];
                  });
                  if (val != null) {
                    await _carregarProfessores(val);
                  }
                },
                validator: (v) => v == null ? 'Selecione uma escola' : null,
              ),

              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _professorIdSelecionado,
                disabledHint: const Text("Selecione uma escola primeiro"),
                decoration: const InputDecoration(
                  labelText: 'Professor responsável',
                  prefixIcon: Icon(Icons.person_pin),
                ),
                items: _professores
                    .map(
                      (p) => DropdownMenuItem(
                        value: p['usu_id'] as String,
                        child: Text(p['usu_nome']),
                      ),
                    )
                    .toList(),
                onChanged: _escolaIdSelecionada == null
                    ? null
                    : (val) => setState(() => _professorIdSelecionado = val),
                validator: (v) => v == null ? 'Selecione um professor' : null,
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarTurma,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  widget.turmaEdicao != null
                      ? 'Salvar Alterações'
                      : 'Cadastrar Turma',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
