import 'dart:convert';

import 'package:http/http.dart';
import 'package:jury_marks/data/constants/http_constants.dart';
import 'package:jury_marks/data/models/result.dart';

import '../data/constants/configurations.dart';

class HttpService {
  Future<Result> getInitialData() async {
    try {
      Response res = await get(Uri.parse(AppConfig.webApiUrl).replace(
          queryParameters: {'action': HttpActions.getInitialData.name}));

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
    } catch (e) {
      return Result(status: HttpStatus.failed, error: e.toString());
    }
  }

  Future<Result> postMarks(
      {required String teamName,
      required String juryName,
      required List<int> marks}) async {
    try {
      Response res = await post(
          Uri.parse(AppConfig.webApiUrl).replace(queryParameters: {
            'action': HttpActions.postMarks.name,
          }),
          body: jsonEncode(
              {'teamName': teamName, 'juryName': juryName, 'marks': marks}));


      res = await get(Uri.parse(res.headers['location']!));
      print(res.body);


      if (res.statusCode == 200) {
        dynamic json = jsonDecode(res.body);
        if (json['status'] == HttpStatus.success) {
          return Result(status: HttpStatus.success);
        } else {
          return Result(status: HttpStatus.failed, error: json['message']);
        }
      }
      return Result(status: HttpStatus.failed, error: "Something went wrong");
    } catch (e) {
      return Result(status: HttpStatus.failed, error: e.toString());
    }
  }
}
