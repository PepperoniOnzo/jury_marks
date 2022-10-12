import 'package:flutter/material.dart';
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
    Result result = await getInitialData();
    if (result.status == HttpStatus.success) {
      jury =
          (result.data?['juryNames'] as List).map((e) => e as String).toList();
      teams =
          (result.data?['teamNames'] as List).map((e) => e as String).toList();
      criteriaSequence = (result.data?['criteriaSequence'] as List)
          .map((e) => e as String)
          .toList();

      criterias = Map<String, List<String>>.from(result.data?['criterias'].map(
          (key, value) => MapEntry(
              key, (value as List).map((e) => e.toString()).toList())));

      Map<String, dynamic>.from(
              result.data?['marks'].map((key, value) => MapEntry(key, value)))
          .forEach((key, value) {
        teamMarks.add(TeamMarks(
            teamName: key,
            marks: Map<String, List<int>>.from(value.map((key, value) =>
                MapEntry(
                    key, (value as List).map((e) => e as int).toList())))));
      });

      selectedJury = jury.first;
      currentMarks = List.filled(criteriaSequence.length, 0);

      errorMessage = '';
    } else {
      errorMessage = result.error;
    }

    initialized = true;
    notifyListeners();
  }

  void tryRefresh() {
    initialized = false;
    notifyListeners();
    initialize();
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
    return criterias.values.elementAt(index);
  }

  int getTeamMarkById(int index) {
    return currentMarks[index];
  }

  void setTeamMark(int mark, int index) {
    currentMarks[index] = mark;
    notifyListeners();
  }

  Future<String> submit() async {
    Result result = await postMarks(
        teamName: teams[selectedTeam],
        juryName: selectedJury,
        marks: currentMarks);
    if (result.status == HttpStatus.failed) {
      return result.error;
    }

    teamMarks[selectedTeam].marks[selectedJury] = [...currentMarks];
    currentMarks = List.filled(criteriaSequence.length, 0);

    return '';
  }

  void resetTeamMarks() {
    currentMarks = List.filled(criteriaSequence.length, 0);
  }
}
