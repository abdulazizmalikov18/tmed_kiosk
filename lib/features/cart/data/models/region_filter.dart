class Filter {
  String? search;
  int? limit;
  int? offset;
  int? id;
  String? timestamp;

  Filter({
    this.id,
    this.search,
    this.limit = 100,
    this.offset,
  });

  Filter.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    search = json['search'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['offset'] = offset;
    data['limit'] = limit;
    data['timestamp'] = timestamp;
    return data;
  }
}
