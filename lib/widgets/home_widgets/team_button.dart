import 'package:flutter/material.dart';
import 'package:jury_marks/data/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../views/home_view.dart';

class TeamButton extends StatelessWidget {
  const TeamButton({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent.withOpacity(0.1)),
        onPressed: () {
          context.read<HomeView>().setTeam(index);
          Navigator.pushNamed(context, AppRoutes.team);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(context.read<HomeView>().teams[index],
                  overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ));
  }
}
