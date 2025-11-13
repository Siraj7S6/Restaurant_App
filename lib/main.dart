import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart'; // Import MainScreen
import 'state/cart_model.dart'; // Import CartModel

void main() {
  // Use ChangeNotifierProvider to provide the CartModel to the entire app
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const RestaurantApp(),
    ),
  );
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlavourFusion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981), // A pleasant green for food/freshness
          primary: const Color(0xFF10B981),
          secondary: const Color(0xFFFACC15), // Accent yellow
          background: Colors.grey[50],
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF10B981),
          foregroundColor: Colors.white,
          elevation: 2.0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}