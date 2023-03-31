
class ResponseModel {
  final bool _isSuccess;
  final String _message;
  Map<String, dynamic>? data;
  List<dynamic>? lists;

  ResponseModel(this._isSuccess, this._message, {this.data, this.lists});

  String get message => _message;
  bool get isSuccess => _isSuccess;
  Map<String, dynamic>? get dataa => data;
  List<dynamic>? get list => lists;

  @override
  String toString() {
    return "Response: is success:$isSuccess, $message";
  }
}
