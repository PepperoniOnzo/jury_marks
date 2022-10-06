import 'package:flutter/material.dart';
import 'package:jury_marks/data/routes/routes.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => HomeView(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.team: (context) => const TeamScreen(),
      },
    );
  }
}
