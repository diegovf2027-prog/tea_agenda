import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

// Máscara para CPF
final maskCPF = MaskTextInputFormatter(
  mask: '###.###.###-##', 
  filter: {"#": RegExp(r'[0-9]')}
);

class AdicionarUsuarioPage extends StatefulWidget {
  final Map<String, dynamic>? usuarioEdicao;
  const AdicionarUsuarioPage({super.key, this.usuarioEdicao});

  @override
  State<AdicionarUsuarioPage> createState() => _AdicionarUsuarioPageState();
}

class _AdicionarUsuarioPageState extends State<AdicionarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  DateTime? _dataNascimento;
  int? _cargoIdSelecionado;
  int? _escolaIdSelecionada;

  @override
  void initState() {
    super.initState();
    if (widget.usuarioEdicao != null) {
      _nomeController.text = widget.usuarioEdicao!['usu_nome'];
      _cpfController.text = widget.usuarioEdicao!['usu_cpf'];
      _emailController.text = widget.usuarioEdicao!['usu_email'];
      _dataNascimento = widget.usuarioEdicao!['usu_dt_nascimento'];
      _cargoIdSelecionado = widget.usuarioEdicao!['usu_cargo'];
      _escolaIdSelecionada = widget.usuarioEdicao!['usu_escola'];
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

  // Validar E-mail
  String? _validarEmail(String? value) {
  if (value == null || value.isEmpty) return 'Informe o e-mail';
  
  final bool emailValido = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    ).hasMatch(value);
    
    if (!emailValido) return 'E-mail inválido';
    return null;
  }

  Future<void> _salvarUsuario() async {
    if (_formKey.currentState!.validate() && _dataNascimento != null && _escolaIdSelecionada != null && _cargoIdSelecionado != null) {

      final cpfLimpo = _nomeController.text.replaceAll(RegExp(r'[^0-9]'), '');
      
      try {
        if (widget.usuarioEdicao != null) {
          // UPDATE
          await supabase.from('usuarios').update({
            'usu_nome': _nomeController.text,
            'usu_cpf': cpfLimpo,
            'usu_dt_nascimento': _dataNascimento!.toIso8601String(),
            'usu_cargo': _cargoIdSelecionado,
            'usu_escola': _escolaIdSelecionada,
          }).eq('usu_id', widget.usuarioEdicao!['usu_id']);
        } else {
          // INSERT
          final authResponse = await supabase.auth.signUp(
            email: _emailController.text,
            password: _senhaController.text,
          );

          final String? userId = authResponse.user?.id;

          if (userId != null) {
            await supabase.from('usuarios').insert({
              'usu_id': userId,
              'usu_nome': _nomeController.text,
              'usu_cpf': cpfLimpo,
              'usu_email': _emailController.text,
              'usu_dt_nascimento': _dataNascimento!.toIso8601String(),
              'usu_cargo': _cargoIdSelecionado,
              'usu_escola': _escolaIdSelecionada,
            });
          }
        }

        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Operação realizada com sucesso!'), backgroundColor: Colors.green),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cpfController,
                inputFormatters: [maskCPF],
                decoration: const InputDecoration(labelText: 'CPF', prefixIcon: Icon(Icons.badge), hintText: '000.000.000-00'),
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
                title: Text(_dataNascimento == null
                  ? "Selecionar Data de Nascimento"
                  : "Nascimento: ${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}"),
                onTap: () => _selecionarData(context),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email)),
                validator: _validarEmail,
                keyboardType: TextInputType.emailAddress,
                enabled: widget.usuarioEdicao == null,
              ),
              if (widget.usuarioEdicao == null) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _senhaController,
                  decoration: const InputDecoration(labelText: 'Senha', prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (v) => v!.length < 8 ? 'Mínimo 8 caracteres' : null,
                ),
              ],
              const SizedBox(height: 12),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: supabase.from('cargos').select(),
                builder: (context, snapshot) {
                  final cargos = snapshot.data ?? [];
                  return DropdownButtonFormField<int>(
                    value: _cargoIdSelecionado,
                    decoration: const InputDecoration(labelText: 'Cargo', prefixIcon: Icon(Icons.assignment_ind)),
                    items: cargos.map((c) => DropdownMenuItem<int>(
                      value: c['car_id'],
                      child: Text(c['car_nome'].toString().toUpperCase())
                    )).toList(),
                    onChanged: (val) => setState(() => _cargoIdSelecionado = val),
                    validator: (v) => v == null ? 'Selecione um cargo' : null,
                  );
                }
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: supabase.from('escolas').select(),
                builder: (context, snapshot) {
                  final escolas = snapshot.data ?? [];
                  return DropdownButtonFormField<int>(
                    value: _escolaIdSelecionada,
                    decoration: const InputDecoration(labelText: 'Escola vinculada', prefixIcon: Icon(Icons.school)),
                    items: escolas.map((e) => DropdownMenuItem<int>(
                      value: e['esc_id'], 
                      child: Text(e['esc_nome'])
                    )).toList(),
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