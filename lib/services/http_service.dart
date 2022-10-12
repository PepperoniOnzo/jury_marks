import 'package:dio/dio.dart';
import 'package:jury_marks/data/constants/http_constants.dart';
import 'package:jury_marks/data/models/result.dart';

import '../data/constants/configurations.dart';

class HttpService {
  Future<Result> getInitialData() async {
    try {
      Response res = await Dio().get(AppConfig.webApiUrl,
          queryParameters: {'action': HttpActions.getInitialData.name});

      if (res.statusCode == 200) {
        try {
          dynamic json = res.data;
          if (json != null) {
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
      Response s = await Dio().request(AppConfig.webApiUrl,
          queryParameters: {
            'action': HttpActions.postMarks.name,
            'marks': marks,
            'juryName': juryName,
            'teamName': teamName
          },
          options: Options(method: "GET"));

      if (s.statusCode == 200) {
        return Result();
      }
      return Result(status: HttpStatus.failed, error: "Something went wrong");
    } catch (e) {
      return Result(status: HttpStatus.failed, error: e.toString());
    }
  }
}
