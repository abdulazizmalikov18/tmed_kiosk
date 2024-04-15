class HFilter {
  String? username;
  List<int>? status;
  int? limit;
  int? offset;

  HFilter({
    this.username,
    this.status,
    this.limit = 10000,
    this.offset,
  });

  HFilter.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    status = json['status'];
    limit = json['limit'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['username'] = username;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }
}
