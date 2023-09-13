class RequestData {
  var status;
  var totalresults;
  var articles;

  RequestData({
    this.status = 0,
  });

  RequestData.fromjson(Map<String, dynamic> json) {
    this.status = json['status'] ?? '';
    this.totalresults = json['totalResults'] ?? '';
    this.articles = json['articles'] ?? '';
  }
}
