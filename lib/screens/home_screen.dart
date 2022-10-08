import 'package:flutter/material.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:jury_marks/widgets/home_widgets/jury_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: context.read<HomeView>().initialize(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (context.read<HomeView>().initialized) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: const <Widget>[JuryList()],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
