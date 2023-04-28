class APIResponse {
  Dates? dates;
  int? page;
  dynamic results;
  dynamic genres;
  int? totalPages;
  int? totalResults;

  APIResponse({
    this.dates,
    this.page,
    this.results,
    this.genres,
    this.totalPages,
    this.totalResults,
  });

  APIResponse.fromJson(Map<String, dynamic> json) {
    dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    page = json['page'];
    results = json['results'];
    genres = json['genres'];
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

// when errror
class APIError implements Exception {
  bool? success;
  int? statusCode;
  String? statusMessage;

  APIError({this.success, this.statusCode, this.statusMessage});

  APIError.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
  }

  @override
  String toString() {
    return statusMessage ?? 'An unexpected error occurred.';
  }
}

class Dates {
  String? maximun;
  String? minimum;

  Dates({this.maximun, this.minimum});

  Dates.fromJson(Map<String, dynamic> json) {
    maximun = json['maximun'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maximun'] = maximun;
    data['minimum'] = minimum;
    return data;
  }
}
