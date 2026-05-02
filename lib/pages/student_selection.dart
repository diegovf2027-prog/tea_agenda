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
      appBar: AppBar(title: const Text('Selecione o Aluno'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(
                          0xFF2196F3,
                        ).withValues(alpha: 0.1),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                      title: Text(
                        studentList[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentPage(name: studentList[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}