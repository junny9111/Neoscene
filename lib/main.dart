import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ncazqzvkcjvewatxwbzz.supabase.co',
    anonKey: 'sb_publishable_z5H0jtZs6eGuLYiYRmMzQQ_hvTwS0-Y',
  );

  runApp(const NeoSceneApp());
}

class NeoSceneApp extends StatelessWidget {
  const NeoSceneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoScene',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFF00E5FF),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
