import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_agenda/data/local/database.dart';
import 'package:tea_agenda/pages/functions/calendar_controller.dart';
import 'package:tea_agenda/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  // Inicializnado o Supabase
  await Supabase.initialize(
    url: 'https://zzoadaxqwvewiisymdfk.supabase.co', // URL do supabase
    anonKey: 'sb_publishable_fEwVPjjLvoM5BGimwlAGrg_nRf9tlKS', // Senha da API
  );

  // Banco de dados local
  final database = AppDatabase();

  runApp(
    Provider<AppDatabase>(
      create: (context) => database,
      dispose: (context, db) => db.close(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TEAgenda',
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: BindingsBuilder(() {
        Get.put(CalendarController());
      }),
      home: const LoginPage(),
    );
  }
}
