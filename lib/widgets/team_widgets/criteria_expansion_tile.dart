import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jury_marks/data/constants/colors.dart';
import 'package:jury_marks/views/home_view.dart';
import 'package:provider/provider.dart';

class CriteriaExpansionTile extends StatelessWidget {
  const CriteriaExpansionTile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final String criteria = context.read<HomeView>().criteriaSequence[index];
    final List<String> criteriasDescription =
        context.read<HomeView>().getCriteriasDescription(index);
    return ExpansionTile(
      textColor: AppColors.buttonPrimary,
      title: Text(overflow: TextOverflow.ellipsis, criteria),
      children: List.generate(
          criteriasDescription.length,
          (index) => ListTile(
                  title: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: '$index - ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: criteriasDescription[index])
                ]),
              )))
        ..add(ListTile(
          title: Center(
              child: RatingBar.builder(
                  initialRating: context
                      .read<HomeView>()
                      .getTeamMarkById(index)
                      .toDouble(),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  glow: false,
                  unratedColor: AppColors.buttonPrimary.withOpacity(0.2),
                  itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: AppColors.buttonPrimary,
                      ),
                  onRatingUpdate: ((value) {
                    context
                        .read<HomeView>()
                        .setTeamMark(value.toInt(), index);
                  }))),
        )),
    );
  }
}
