import 'package:flutter/material.dart';
import 'package:tea_agenda/pages/student_page.dart';

class StudentSelection extends StatelessWidget {
  const StudentSelection({super.key});

  final List<String> studentList = const [
    "Aluno 1",
    "Aluno 2",
    "Aluno 3",
    "Aluno 4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecione o aluno'), centerTitle: true),
      body: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(studentList[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentPage(name: studentList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
