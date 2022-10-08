import 'package:flutter/material.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:provider/provider.dart';

class JuryList extends StatelessWidget {
  const JuryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: DropdownButton(
        isExpanded: true,
          items: context
              .read<HomeView>()
              .jury
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: ((value) {})),
    );
  }
}
