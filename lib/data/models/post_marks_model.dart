class TeamMarks {
  late String teamName;
  late Map<String, List<int>> marks;

  TeamMarks({
    required this.teamName,
    required this.marks,
  });

  TeamMarks.fromJson(Map<dynamic, dynamic> json) {
    teamName = json["teamName"];
    marks = json["marks"] as Map<String, List<int>>;
  }

  int getMarkByIndex(String juryName, int index) {
    return marks[juryName]![index];
  }

  void setMarkByIndex(String juryName, int index, int value) {
    marks[juryName]![index] = value;
  }
}
