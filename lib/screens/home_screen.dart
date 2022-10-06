import 'package:flutter/material.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: FutureBuilder(
          future: context.read<HomeView>().initialize(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (context.read<HomeView>().initialized) {
              return Center(
                child: Text(context.watch<HomeView>().jury.toString()),
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
