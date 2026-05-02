import 'package:flutter/material.dart';
import 'package:tea_agenda/pages/functions/calendar_page.dart';
import 'package:tea_agenda/pages/functions/reports.dart';
import 'package:tea_agenda/widgets/bottom_nav_bar.dart';
import 'package:tea_agenda/pages/functions/add_page.dart';

class StudentPage extends StatefulWidget {
  final String name;

  const StudentPage({super.key, required this.name});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  int _selectedIndex = -1; // -1 mostra o feed inicial

  // Seções sem o Feed na navegação inferior
  late List<Widget> pages;
  final List<String> pageTitles = ['Relatórios', 'Calendário', 'Adicionar'];

  @override
  void initState() {
    super.initState();
    pages = [
      _buildRelatorioSection(),
      _buildCalendarioSection(),
      _buildAdicaoSection(),
    ];
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goBack() {
    if (_selectedIndex == -1) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _selectedIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFeed = _selectedIndex == -1;
    return Scaffold(
      appBar: AppBar(
        title: Text(isFeed ? widget.name : pageTitles[_selectedIndex]),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
      ),
      body: isFeed ? _buildFeedSection() : pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 120,
        child: BottomNavBar(
          selectedIndex: _selectedIndex,
          onTap: _onNavItemTapped,
        ),
      ),
    );
  }

  Widget _buildFeedSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Feed de Atualizações",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildUpdateCard(
              title: "Futuras Atividades",
              description: "Futuros registros do TEAgenda aparecerão aqui",
              icon: Icons.date_range,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatorioSection() {
    return const ReportsPage();
  }

  Widget _buildCalendarioSection() {
    return const CalendarPage();
  }

  Widget _buildAdicaoSection() {
    return const AddPage();
  }
}