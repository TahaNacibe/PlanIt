import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plan_it/provider/theme_provider.dart';
import 'package:plan_it/services/randomizer.dart';
import 'package:plan_it/services/storage_services.dart';
import 'package:plan_it/shared/items_list.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    loadDaysList().then((value) {
      if (value.isNotEmpty) {
        weekDays = value;
      }
      setState(() {});
      loadTheme().then((value) {
        isDarkMood = value;
        ThemeProvider().updateThemeBasedOnBool(isDarkMood);
        setState(() {});
      });
    });
    qut = getRandomQuote();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.popAndPushNamed(context, "Home");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Colors.indigo,
          size: 100,
        ),
      ),
    );
  }
}
