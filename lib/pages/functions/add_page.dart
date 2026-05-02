import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _observationController = TextEditingController();
  File? _selectedImage;

  String? _alimentacao;
  String? _atividades;
  String? _comportamento;
  double _humor = 3;
  double _atividade = 3;

  // Opções de dropdown
  final List<String> alimentacaoOptions = [
    'Se alimentou pouco',
    'Se alimentou muito',
    'Não se alimentou',
  ];

  final List<String> atividadesOptions = [
    'Concluiu as atividades',
    'Concluiu parcialmente',
    'Não concluiu',
  ];

  final List<String> comportamentoOptions = [
    'Seguiu a rotina',
    'Saiu da rotina',
  ];

  @override
  void dispose() {
    _observationController.dispose();
    super.dispose();
  }

  // Função de Salvar o Registro
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final String extension = path.extension(pickedFile.path).toLowerCase();
      if (extension == '.jpg' || extension == '.jpeg') {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione uma imagem no formato JPG ou JPEG.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _salvarRegistro() {
    if (_alimentacao == null || _atividades == null || _comportamento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Implementar banco de dados!!
    final registro = {
      'alimentacao': _alimentacao,
      'atividades': _atividades,
      'comportamento': _comportamento,
      'humor': _humor,
      'atividade': _atividade,
      'observacoes': _observationController.text,
      'data': DateTime.now(),
    };

    print('Registro salvo: $registro');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro salvo com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    _resetForm();
  }

  void _resetForm() {
    setState(() {
      _alimentacao = null;
      _atividades = null;
      _comportamento = null;
      _humor = 3;
      _atividade = 3;
      _selectedImage = null;
      _observationController.clear();
    });
  }

  Color _getHumorColor(double humor) {
    if (humor == 1) return const Color.fromARGB(255, 212, 0, 0);
    if (humor == 2) return const Color.fromARGB(255, 216, 122, 0);
    if (humor == 3) return const Color.fromARGB(255, 255, 217, 0);
    if (humor == 4) return const Color.fromARGB(255, 50, 175, 0);
    return const Color.fromARGB(255, 123, 2, 223);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formattedDate = '${today.day}/${today.month}/${today.year}';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seção de Avaliação
          Text(
            'Avaliação do Dia - $formattedDate',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Campo: Alimentação
          const Text(
            'Alimentação',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _alimentacao,
            hint: const Text('Selecione uma opção'),
            items: alimentacaoOptions.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _alimentacao = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Campo: Atividades
          const Text(
            'Atividades',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _atividades,
            hint: const Text('Selecione uma opção'),
            items: atividadesOptions.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _atividades = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Campo: Comportamento
          const Text(
            'Comportamento',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _comportamento,
            hint: const Text('Selecione uma opção'),
            items: comportamentoOptions.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _comportamento = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Seção de Observações
          const Text(
            'Observações do Dia',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _observationController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Digite observações e notas adicionais sobre o dia...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Importar Foto',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Selecionar imagem'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_selectedImage != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.file(
                  _selectedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ] else ...[
            const SizedBox(height: 24),
          ],

          // Seção de Classificação
          const Text(
            'Classificação do Dia',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Classificação de Humor
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Humor'),
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _humor = i.toDouble();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.face,
                          size: 32,
                          color: _humor >= i
                              ? _getHumorColor(_humor)
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Classificação de Atividade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Atividades'),
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _atividade = i.toDouble();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.star,
                          size: 32,
                          color: _atividade >= i
                              ? Colors.amber
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _resetForm,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _salvarRegistro,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar Registro'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}