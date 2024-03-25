//Manage all the API REST responses

//All possible status for the response
enum Status {BUSY, COMPLETED, ERROR}

//Generic response Api class
class ApiResponse<T> {
  T? data;
  String? message;
  Status? status;

  //Constructor
  ApiResponse(this.status, this.data, this.message);

  //For debug
  @override
  String toString() {
    return "ApiResponse - toString() :\n Status : $status\n Data : $data\n Message : $message";
  }
}