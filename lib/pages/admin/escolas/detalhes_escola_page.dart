import 'package:flutter/material.dart';

class DetalhesEscolaPage extends StatelessWidget {
  final Map<String, dynamic> escola;
  
  const DetalhesEscolaPage({super.key, required this.escola});

  // Formatações do CPNJ e CEP
  String formatarCNPJ(String cnpj) {
    if (cnpj.length != 14) return cnpj;
    return "${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12)}";
  }

  String formatarCEP(String cep) {
    if (cep.length != 8) return cep;
    return "${cep.substring(0, 5)}-${cep.substring(5)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Escola'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.school, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              escola['esc_nome'] ?? 'Sem nome',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 32),
            _buildDetailItem(Icons.description, "CNPJ", formatarCNPJ(escola['esc_cnpj'] ?? 'Não informado')),
            _buildDetailItem(Icons.location_on, "Endereço", escola['esc_endereco'] ?? 'Não informado'),
            _buildDetailItem(Icons.numbers, "Número", escola['esc_numero']?.toString() ?? 'Não informado'),
            _buildDetailItem(Icons.map, "Bairro", escola['esc_bairro'] ?? 'Não informado'),
            _buildDetailItem(Icons.location_city, "Cidade", escola['esc_cidade'] ?? 'Não informado'),
            _buildDetailItem(Icons.local_post_office, "CEP", formatarCEP(escola['esc_cep'] ?? 'Não informado')),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black87)),
    );
  }
}