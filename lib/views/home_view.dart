import 'package:flutter/cupertino.dart';
import 'package:jury_marks/data/constants/http_constants.dart';
import 'package:jury_marks/data/models/result.dart';
import 'package:jury_marks/services/http_service.dart';

class HomeView extends ChangeNotifier with HttpService {
  bool initialized = false;
  List<String> jury = [], teams = [], criteriaSequence = [];
  Map<String, List<String>> criterias = {};
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
      'lee',
      'mayur',
      'wang',
      'zoe',
    ];

    teams = [
      'team leader 1',
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

    initialized = true;
    //notifyListeners();
  }
}
