import 'package:flutter/material.dart';
import 'screens/main_navigation.dart'; // আমাদের মূল নেভিগেশন স্ক্রিন

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ভবিষ্যতে ফায়ারবেস বা লোকাল ডাটাবেস ইনিট করতে চাইলে এখানে কোড বসবে
  // await Firebase.initializeApp();

  runApp(const FriendsZoneApp());
}

class FriendsZoneApp extends StatelessWidget {
  const FriendsZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends Zone',
      debugShowCheckedModeBanner: false,
      // থিম ও কালার কনফিগারেশন (Royal Pink & Neon Rose Aesthetic)
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F051D),
        primaryColor: const Color(0xFFFF2E93),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF2E93),
          secondary: Color(0xFFFFD700),
          surface: Color(0xFF1A0B2E),
        ),
        fontFamily: 'Roboto', // ডিফল্ট ফন্ট
      ),
      // অ্যাপ ওপেন হলেই সরাসরি আমাদের MainNavigation (Nearby, Voice, Arcade, Profile) শো করবে
      home: const MainNavigation(),
    );
  }
}
