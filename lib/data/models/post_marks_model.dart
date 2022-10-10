class TeamMarks {
  late String teamName;
  late Map<String, List<int>> marks;

  TeamMarks({
    required this.teamName,
    required this.marks,
  });

  TeamMarks.fromJson(Map<dynamic, dynamic> json) {
    teamName = json["teamName"];
    marks = json["marks"]as Map<String, List<int>>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["teamName"] = teamName;
    data["marks"] = marks;
    return data;
  }

  int getMarkByIndex(String juryName, int index) {
    return marks[juryName]![index];
  }

  void setMarkByIndex(String juryName, int index, int value) {
    marks[juryName]![index] = value;
  }

  // TeamMarks({
  //   required this.teamName,
  //   required this.juryName,
  //   required this.action,
  //   required this.marks,
  // });

  // TeamMarks.fromJson(Map<String, dynamic> json) {
  //   teamName = json['teamName'];
  //   juryName = json['juryName'];
  //   action = json['action'];
  //   marks = json['marks'].cast<int>();
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['teamName'] = teamName;
  //   data['juryName'] = juryName;
  //   data['action'] = action;
  //   data['marks'] = marks;
  //   return data;
  // }
}
