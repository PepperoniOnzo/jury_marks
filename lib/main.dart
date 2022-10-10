import 'package:flutter/material.dart';
import 'package:jury_marks/data/constants/colors.dart';
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
      theme: ThemeData().copyWith(
          scaffoldBackgroundColor: AppColors.backgroundPrimnary,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.buttonPrimary)),
          textTheme: const TextTheme(
              bodyText1: TextStyle(color: AppColors.textPrimary))),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.team: (context) => const TeamScreen(),
      },
    );
  }
}
