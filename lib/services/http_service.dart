import 'dart:convert';

import 'package:http/http.dart';
import 'package:jury_marks/data/constants/http_constants.dart';
import 'package:jury_marks/data/models/result.dart';

import '../data/constants/configurations.dart';

class HttpService {
  Future<Result> getInitialData() async {
    Response res = await get(Uri.parse(AppConfig.webApiUrl)
        .replace(queryParameters: {'action': HttpActions.getInitialData.name}));

    if (res.statusCode == 200) {
      try {
        dynamic json = jsonDecode(res.body);
        if (json['data'] != null) {
          return Result(data: json['data']);
        } else {
          return Result(status: HttpStatus.failed, error: json['error']);
        }
      } catch (e) {
        return Result(status: HttpStatus.failed, error: e.toString());
      }
    } else {
      return Result(status: HttpStatus.failed, error: "Something went wrong");
    }
  }
}