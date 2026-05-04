import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/pages/admin/escolas/gerenciar_escolas_page.dart';
import 'package:tea_agenda/pages/admin/turmas/gerenciar_turmas_page.dart';
import 'package:tea_agenda/pages/admin/usuarios/gerenciar_usuarios_page.dart';
import 'package:tea_agenda/pages/admin/alunos/gerenciar_alunos_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? _perfilUsuario;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarDadosUsuario();
  }

  Future<void> _buscarDadosUsuario() async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final dados = await supabase
            .from('usuarios_com_cargos')
            .select()
            .eq('usu_id', user.id)
            .single();

        setState(() {
          _perfilUsuario = dados;
          _carregando = false;
        });
      }
    } catch (e) {
      debugPrint("Erro ao buscar perfil: $e");
      setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final String cargo = (_perfilUsuario?['cargo_nome'] ?? '')
        .toString()
        .trim()
        .toUpperCase();

    final bool ehAdmin = cargo == 'ADMINISTRADOR';
    final bool ehGestor = cargo == 'DIRETOR' || cargo == 'ORIENTADOR';

    return Scaffold(
      appBar: AppBar(title: const Text('Administração'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Painel Administrativo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),
            if (ehAdmin) ...[
              _buildAdminCard(
                title: 'Gerenciar Escolas',
                iconData: Icons.school,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GerenciarEscolasPage(),
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 16),
            if (ehAdmin) ...[
              _buildAdminCard(
                title: 'Gerenciar Usuários',
                iconData: Icons.person,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GerenciarUsuariosPage(),
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 16),
            if (ehAdmin || ehGestor) ...[
              _buildAdminCard(
                title: 'Gerenciar Turmas',
                iconData: Icons.door_front_door,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GerenciarTurmasPage(),
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 16),
            if (ehAdmin || ehGestor) ...[
              _buildAdminCard(
                title: 'Gerenciar Alunos',
                iconData: Icons.child_care,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GerenciarAlunosPage(),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard({
    required String title,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.1),
          child: Icon(iconData, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
