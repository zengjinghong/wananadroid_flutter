class EmptyResponse {
  final dynamic data;
  final int errorCode;
  final String errorMsg;

  EmptyResponse({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory EmptyResponse.fromJson(Map<String, dynamic> json) {
    return EmptyResponse(
      data: json['data'],
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  bool get success => errorCode == 0;

}
