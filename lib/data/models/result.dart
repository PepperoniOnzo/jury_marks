class Result {
  String status, error;
  Map<String, dynamic>? data;

  Result({this.status = 'SUCCESS', this.error = '', this.data});
}
