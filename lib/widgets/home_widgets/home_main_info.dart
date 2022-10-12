import 'package:flutter/material.dart';

import 'jury_list.dart';
import 'team_list.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
        child: Column(
          children: const <Widget>[JuryList(), TeamList()],
        ),
      ),
    );
  }
}
