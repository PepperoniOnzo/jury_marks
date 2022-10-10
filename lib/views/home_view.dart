import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jury_marks/data/constants/http_constants.dart';
import 'package:jury_marks/data/models/post_marks_model.dart';
import 'package:jury_marks/data/models/result.dart';
import 'package:jury_marks/services/http_service.dart';

class HomeView extends ChangeNotifier with HttpService {
  bool initialized = false;
  List<String> jury = [], teams = [], criteriaSequence = [];
  Map<String, List<String>> criterias = {};

  List<TeamMarks> teamMarks = [];
  List<int> currentMarks = [];

  String selectedJury = '';
  int selectedTeam = 0;
  String errorMessage = '';

  Future<void> initialize() async {
    // Result result = await getInitialData();
    // if (result.status == HttpStatus.success) {
    //   jury = (result.data['jury'] as List).map((e) => e as String).toList();
    //   jury = (result.data['teams'] as List).map((e) => e as String).toList();
    // } else {
    //   errorMessage = result.error;
    // }

    jury = [
      'lee changmin (리창민; 李章旻) - leader',
      'mayur',
      'wang',
      'zoe',
    ];

    teams = [
      'team leader 1',
      'team leader 2',
    ];

    criteriaSequence = [
      'Impact',
      'Duration',
    ];

    criterias = {
      'Impact': [
        'Impact 0',
        'Impact 1',
        'Impact 2',
        'Impact 3',
        'Impact 4',
        'Impact 5',
      ],
      'Duration': [
        'Duration 0',
        'Duration 1',
        'Duration 2',
        'Duration 3',
        'Duration 4',
        'Duration 5',
      ],
    };

    teamMarks = [
      TeamMarks(
        teamName: teams[0],
        marks: {
          jury[0]: [2, 0],
          jury[1]: [0, 0],
          jury[2]: [0, 0],
          jury[3]: [0, 0],
        },
      ),
      TeamMarks(
        teamName: teams[1],
        marks: {
          jury[0]: [3, 2],
          jury[1]: [4, 1],
          jury[2]: [1, 4],
          jury[3]: [0, 0],
        },
      ),
    ];

    selectedJury = jury.first;

    currentMarks = List.filled(criteriaSequence.length, 0);

    initialized = true;
    //notifyListeners();
  }

  void setSelectionJury(String? selected) {
    selectedJury = selected ?? '';
    notifyListeners();
  }

  void setTeam(int selected) {
    selectedTeam = selected;
    currentMarks = [...?teamMarks[selected].marks[selectedJury]];
    notifyListeners();
  }

  String getSelectedTeam() {
    return teams[selectedTeam];
  }

  List<String> getCriteriasDescription(int index) {
    return criterias[criteriaSequence[index]] ?? [];
  }

  int getTeamMarkById(int index) {
    return teamMarks[selectedTeam].getMarkByIndex(selectedJury, index);
  }

  void setTeamMark(int mark, int index) {
    currentMarks[index] = mark;
  }

  void submit() {
    teamMarks[selectedTeam].marks[selectedJury] = [...currentMarks];
    currentMarks = List.filled(criteriaSequence.length, 0);
  }

  void resetTeamMarks() {
    currentMarks = List.filled(criteriaSequence.length, 0);
  }
}
