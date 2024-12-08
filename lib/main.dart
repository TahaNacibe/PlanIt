import 'package:flutter/material.dart';
import 'package:plan_it/provider/theme_provider.dart';
import 'package:plan_it/screens/home_screen.dart';
import 'package:plan_it/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          routes: {
            "Home": (context) => const SchedularPage()
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeProvider.themeMode,
           theme: ThemeData.light(), // Define light theme
          darkTheme: ThemeData.dark(), // Define dark theme
          home: const LoadingScreen(),
        );
      }
    );
  }
}
