import 'package:flutter/material.dart';
import 'package:movieapp__s/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/movie_detail_screen.dart';

//void main() => runApp(const OMDbApp());
void main() async {
  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImljbGJkdGxoeG1peWtjZHZkemh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgyNzc3ODMsImV4cCI6MjA3Mzg1Mzc4M30.0NZcY-yGAxrwf1Fvl401TzQKYOLnEmsdwetr6OZCrbY',
    url: 'https://iclbdtlhxmiykcdvdzhu.supabase.co', 
  );

  runApp(const OMDbApp());
}

class OMDbApp extends StatelessWidget {
  const OMDbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMDb App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/details': (context) => const MovieDetailScreen(), 
      },
    );
  }
}