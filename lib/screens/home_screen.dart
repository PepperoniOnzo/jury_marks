import 'package:flutter/material.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:jury_marks/widgets/home_widgets/home_error.dart';
import 'package:jury_marks/widgets/home_widgets/home_main_info.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  late Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: context.read<HomeView>().initialize(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (context.watch<HomeView>().initialized) {
          widget = context.read<HomeView>().errorMessage.isEmpty
              ? const HomeInfo()
              : const HomeError();
        } else {
          widget = const Center(
            child: CircularProgressIndicator(),
          );
        }
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500), child: widget);
      },
    ));
  }
}
