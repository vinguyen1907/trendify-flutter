import 'dart:convert';

class ApiException {
  final String? status;
  final String? errorCode;
  final String? message;
  final String? debugMessage;
  final Object? subErrors;

  const ApiException({
    this.status,
    this.errorCode,
    this.message,
    this.debugMessage,
    this.subErrors,
  });

  factory ApiException.fromJson(String json) {
    return ApiException.fromMap(jsonDecode(json));
  }

  factory ApiException.fromMap(Map map) {
    return ApiException(
      status: map["apierror"]['status'],
      errorCode: map["apierror"]['errorCode'],
      message: map["apierror"]['message'],
      debugMessage: map["apierror"]['debugMessage'],
      subErrors: map["apierror"]['subErrors'],
    );
  }

  @override
  String toString() {
    return 'ApiException(status: $status, errorCode: $errorCode, message: $message, debugMessage: $debugMessage, subErrors: $subErrors)';
  }
}
