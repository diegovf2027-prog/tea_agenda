import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_agenda/pages/functions/calendar_controller.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TEAgenda',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: BindingsBuilder(() {
        Get.put(CalendarController());
      }),
      home: const LoginPage(),
    );
  }
}
