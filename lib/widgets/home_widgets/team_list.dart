import 'package:flutter/material.dart';
import 'package:jury_marks/data/constants/colors.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:jury_marks/widgets/home_widgets/team_button.dart';
import 'package:jury_marks/widgets/home_widgets/team_list_empty.dart';
import 'package:provider/provider.dart';

class TeamList extends StatelessWidget {
  const TeamList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                "Teams list",
                style: TextStyle(fontSize: 20),
              ),
            ),
            context.read<HomeView>().teams.isEmpty
                ? const TeamListEmpty()
                : Container(
                    decoration: const BoxDecoration(
                        color: AppColors.backgroundAdditional,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        itemCount: context.read<HomeView>().teams.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TeamButton(index: index);
                        }),
                  ),
          ],
        ));
  }
}
