class ApiResponse<T> {
  bool isSuccess;
  late String title;
  String message;
  int code = 200;
  T? data;
  T? cacheData;

  ApiResponse({
    required this.title,
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  ApiResponse.success({
    this.isSuccess = true,
    this.message = "success",
    this.title = "success",
    required this.data,
  });

  ApiResponse.error({
    this.isSuccess = false,
    required this.message,
    this.cacheData,
    this.title = "Error",
    this.code = 200,
    this.data,
  });
}
