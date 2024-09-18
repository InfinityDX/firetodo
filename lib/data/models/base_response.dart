class BaseResponse<T> {
  final T? data;
  final String msg;
  final bool isSuccess;
  BaseResponse({
    this.data,
    this.msg = '',
    this.isSuccess = false,
  });
}
