import 'package:flutter/material.dart';
import 'core/services/hive_service.dart';
import 'features/splash/presentation/splash_screen.dart';

Future<void> main() async {
  final HiveService _hiveService = HiveService();
  WidgetsFlutterBinding.ensureInitialized();
  await _hiveService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => const SplashScreen()},
    );
  }
}
