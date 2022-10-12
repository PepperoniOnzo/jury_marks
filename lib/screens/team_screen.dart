import 'package:flutter/material.dart';
import 'package:jury_marks/data/constants/colors.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:jury_marks/widgets/team_widgets/criteria_expansion_tile.dart';
import 'package:provider/provider.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeView>().resetTeamMarks();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.read<HomeView>().getSelectedTeam()),
          backgroundColor: AppColors.backgroundAdditional,
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: context.read<HomeView>().criteriaSequence.length,
                itemBuilder: (context, index) {
                  return CriteriaExpansionTile(index: index);
                }),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.buttonPrimary),
            ),
            onPressed: () {
              context.read<HomeView>().submit().then((value) {
                if (value.isNotEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value)));
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Submited!')));
                }
              });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('Submit', style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}
