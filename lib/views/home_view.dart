import 'package:flutter/cupertino.dart';
import 'package:jury_marks/data/constants/http_constants.dart';
import 'package:jury_marks/data/models/result.dart';
import 'package:jury_marks/services/http_service.dart';

class HomeView extends ChangeNotifier with HttpService {
  bool initialized = false;
  List<String> jury = [], teams = [];
  String errorMessage = '';

  Future<void> initialize() async {
    Result result = await getInitialData();
    if (result.status == HttpStatus.success) {
      jury = (result.data['jury'] as List).map((e) => e as String).toList();
      jury = (result.data['teams'] as List).map((e) => e as String).toList();
    } else {
      errorMessage = result.error;
    }

    initialized = true;
    notifyListeners();
  }
}
