import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';

class AdicionarEscolaPage extends StatefulWidget {
  final Map<String, dynamic>? escolaEdicao;
  const AdicionarEscolaPage({super.key, this.escolaEdicao});

  @override
  State<AdicionarEscolaPage> createState() => _AdicionarEscolaPageState();
}

class _AdicionarEscolaPageState extends State<AdicionarEscolaPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _cepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.escolaEdicao != null) {
      _nomeController.text = widget.escolaEdicao!['esc_nome'] ?? '';
      _cnpjController.text = widget.escolaEdicao!['esc_cnpj'] ?? '';
      _enderecoController.text = widget.escolaEdicao!['esc_endereco'] ?? '';
      _numeroController.text = widget.escolaEdicao!['esc_numero']?.toString() ?? '';
      _bairroController.text = widget.escolaEdicao!['esc_bairro'] ?? '';
      _cidadeController.text = widget.escolaEdicao!['esc_cidade'] ?? '';
      _cepController.text = widget.escolaEdicao!['esc_cep'] ?? '';
    }
  }

  Future<void> _salvarEscola() async {
    if (_formKey.currentState!.validate()) {

      final cepLimpo = _cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final cnpjLimpo = _cnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final supabase = Supabase.instance.client;

      final dadosEscola = {
        'esc_nome': _nomeController.text,
        'esc_cnpj': cnpjLimpo,
        'esc_endereco': _enderecoController.text,
        'esc_numero': int.tryParse(_numeroController.text),
        'esc_bairro': _bairroController.text,
        'esc_cidade': _cidadeController.text,
        'esc_cep': cepLimpo,
      };

      try {
        if (widget.escolaEdicao != null) {
          // UPDATE
          await supabase
              .from('escolas')
              .update(dadosEscola)
              .eq('esc_id', widget.escolaEdicao!['esc_id']);
        } else {
          // INSERT
          await supabase.from('escolas').insert(dadosEscola);
        }

        if (!mounted) return;

        String mensagem = widget.escolaEdicao != null
            ? 'Escola alterada com sucesso!'
            : 'Escola cadastrada com sucesso!';

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagem),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao salvar: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Máscara para CNPJ
  final maskCNPJ = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')}
  );

  // Máscara para CEP
  final maskCEP = MaskTextInputFormatter(
    mask: '#####-###', 
    filter: {"#": RegExp(r'[0-9]')}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.escolaEdicao != null ? 'Editar Escola' : 'Nova Escola')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da Escola'),
                validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cnpjController,
                inputFormatters: [maskCNPJ],
                decoration: const InputDecoration(labelText: 'CNPJ', hintText: '00.000.000/0000-00'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o CNPJ';
                  if (!CNPJValidator.isValid(value)) return 'CNPJ inválido';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cidadeController,
                decoration: const InputDecoration(labelText: 'Cidade'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cepController,
                inputFormatters: [maskCEP],
                decoration: const InputDecoration(labelText: 'CEP', hintText: '00000-000'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvarEscola,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: Text(widget.escolaEdicao != null ? 'Salvar Alterações' : 'Cadastrar Escola'),
              ),
            ],
          ),
        ),
      )
    );
  }
}