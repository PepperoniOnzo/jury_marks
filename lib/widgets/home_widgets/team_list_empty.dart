import 'package:flutter/material.dart';

import '../../data/constants/colors.dart';

class TeamListEmpty extends StatelessWidget {
  const TeamListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 100,
        child: Container(
            decoration: const BoxDecoration(
                color: AppColors.backgroundAdditional,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: const Center(
              child: Text("Team list is empty", style: TextStyle(fontSize: 18)),
            )));
  }
}
