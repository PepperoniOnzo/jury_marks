import 'package:flutter/material.dart';
import 'package:jury_marks/data/constants/colors.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:provider/provider.dart';

class JuryList extends StatelessWidget {
  const JuryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Jury selection", style: TextStyle(fontSize: 20)),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: DropdownButton(
              value: context.watch<HomeView>().selectedJury,
              isExpanded: true,
              itemHeight: null,
              dropdownColor: AppColors.backgroundAdditional,
              focusColor: AppColors.backgroundAdditional,
              items: context
                  .read<HomeView>()
                  .jury
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: ((value) {
                context.read<HomeView>().setSelectionJury(value);
              })),
        ),
      ],
    );
  }
}
