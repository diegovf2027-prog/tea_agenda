import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as d;   // Não ter conflito com o Material
import 'package:tea_agenda/data/local/database.dart';
import 'package:provider/provider.dart';

class AdicionarUsuarioPage extends StatefulWidget {
  final Usuario? usuarioEdicao;
  const AdicionarUsuarioPage({super.key, this.usuarioEdicao});

  @override
  State<AdicionarUsuarioPage> createState() => _AdicionarUsuarioPageState();
}

class _AdicionarUsuarioPageState extends State<AdicionarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  DateTime? _dataNascimento;
  Cargos? _cargoSelecionado;
  int? _escolaIdSelecionada;

  @override
  void initState() {
    super.initState();
    if (widget.usuarioEdicao != null) {
      _nomeController.text = widget.usuarioEdicao!.usuNome;
      _cpfController.text = widget.usuarioEdicao!.usuCPF;
      _emailController.text = widget.usuarioEdicao!.usuEmail;
      _senhaController.text = widget.usuarioEdicao!.usuSenha;
      _dataNascimento = widget.usuarioEdicao!.usuDtNascimento;
      _cargoSelecionado = widget.usuarioEdicao!.usuCargo;
      _escolaIdSelecionada = widget.usuarioEdicao!.usuEscola;
    }
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? data_selecionada = await showDatePicker(
      context: context,
      initialDate: _dataNascimento ?? DateTime(1990),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (data_selecionada != null) setState(() => _dataNascimento = data_selecionada);
  }

  void _salvarUsuario() async {
    if (_formKey.currentState!.validate() && _dataNascimento != null && _escolaIdSelecionada != null && _cargoSelecionado != null) {
      final database = Provider.of<AppDatabase>(context, listen: false);

      final novoUsuario = UsuariosCompanion(
        usuNome: d.Value(_nomeController.text),
        usuCPF: d.Value(_cpfController.text),
        usuEmail: d.Value(_emailController.text),
        usuSenha: d.Value(_senhaController.text),
        usuCargo: d.Value(_cargoSelecionado!),
        usuDtNascimento: d.Value(_dataNascimento!),
        usuEscola: d.Value(_escolaIdSelecionada!),
      );

      if (widget.usuarioEdicao != null) {
        await database.update(database.usuarios).replace(
          novoUsuario.copyWith(usuId: d.Value(widget.usuarioEdicao!.usuId)),
        );
      } else {
        await database.into(database.usuarios).insert(novoUsuario);
      }

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.usuarioEdicao != null ? 'Usuário atualizado!' : 'Usuário cadastrado!'), backgroundColor: Colors.green),
      );
    } else {
      String erro = "Preencha todos os campos corretamente!";
      
      if (_dataNascimento == null) {
        erro = "Selecione a data de nascimento!";
      } else if (_cargoSelecionado == null) {
        erro = "Selecione o cargo do usuário!";
      } else if (_escolaIdSelecionada == null) {
        erro = "Selecione uma escola!";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro), 
          backgroundColor: Colors.red // Vermelho para indicar erro
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.usuarioEdicao != null ? 'Editar Usuário' : 'Novo Usuário')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome Completo', prefixIcon: Icon(Icons.person)),
                validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF', prefixIcon: Icon(Icons.badge)),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text(_dataNascimento == null
                  ? "Selecionar Data de Nascimento"
                  : "Nascimento: ${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}"),
                onTap: () => _selecionarData(context),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha', prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Cargos>(
                value: _cargoSelecionado,
                decoration: const InputDecoration(labelText: 'Cargo', prefixIcon: Icon(Icons.assignment_ind)),
                items: Cargos.values.map((Cargos cargo) {
                  return DropdownMenuItem(value: cargo, child: Text(cargo.name.toUpperCase()));
                }).toList(),
                onChanged: (val) => setState(() => _cargoSelecionado = val),
              ),
              const SizedBox(height: 12),
              StreamBuilder<List<Escola>>(
                stream: database.watchEscolas(),
                builder: (context, snapshot) {
                  final escolas = snapshot.data ?? [];
                  return DropdownButtonFormField<int> (
                    value: _escolaIdSelecionada,
                    decoration: const InputDecoration(labelText: 'Escola vinculada', prefixIcon: Icon(Icons.school)),
                    items: escolas.map((e) => DropdownMenuItem(value: e.escId, child: Text(e.escNome))).toList(),
                    onChanged: (val) => setState(() => _escolaIdSelecionada = val),
                    validator: (v) => v == null ? 'Selecione uma escola' : null,
                  );
                }
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarUsuario,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: Text(widget.usuarioEdicao != null ? 'Salvar Alterações' : 'Cadastrar Usuário'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}