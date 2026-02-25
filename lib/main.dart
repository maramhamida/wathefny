import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zlcqpzlcxljhyzzhsuoy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpsY3FwemxjeGxqaHl6emhzdW95Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ0OTg2NDQsImV4cCI6MjA4MDA3NDY0NH0.5GuGl-L1OGoVFpGOwFLtwWPUebwbkAI2tHVP2XTObNI',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'وظفني',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      routes: Routes.getRoutes(),
    );
  }
}
