import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetalhesUsuarioPage extends StatelessWidget {
  final Map<String, dynamic> usuario;

  const DetalhesUsuarioPage({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {

    final supabase = Supabase.instance.client;

    String dataFormatada = 'Não informada';
    if (usuario['usu_dt_nascimento'] != null) {
      DateTime dt = DateTime.parse(usuario['usu_dt_nascimento']);
      dataFormatada = "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";
    }

    // Formatação de CPF
    String formatarCPF(String cpf) {
      String numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');
      if (numeros.length != 11) return numeros;
      return "${numeros.substring(0, 3)}.${numeros.substring(3, 6)}.${numeros.substring(6, 9)}-${numeros.substring(9)}";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Usuário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              usuario['usu_nome'] ?? 'Sem nome',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 32),
            _buildDetailItem(Icons.badge, "CPF", formatarCPF(usuario['usu_cpf'] ?? 'Não informado')),
            _buildDetailItem(Icons.cake, "Data de Nascimento", dataFormatada),
            _buildDetailItem(Icons.alternate_email, "E-mail", usuario['usu_email'] ?? 'Não informado'),
            _buildDetailItem(Icons.assignment_ind, 'Cargo', usuario['cargo_nome']?.toString().toUpperCase() ?? 'Sem cargo'),

            FutureBuilder<Map<String, dynamic>?>(
              future: usuario['usu_escola'] != null
                ? supabase.from('escolas').select().eq('esc_id', usuario['usu_escola']).maybeSingle()
                : Future.value(null),
              builder: (context, snapshot) {
                String escolaNome = "Buscando...";
                if (snapshot.hasData) escolaNome = snapshot.data!['esc_nome'];
                if (snapshot.hasError) escolaNome = "Erro ao carregar";
                if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) escolaNome = "Não vinculada";
                return _buildDetailItem(Icons.school, "Escola", escolaNome);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('"A senha é criptografada e não pode ser exibida', style: TextStyle(color: Colors.redAccent, fontSize: 12, fontStyle: FontStyle.italic)),
            ),
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