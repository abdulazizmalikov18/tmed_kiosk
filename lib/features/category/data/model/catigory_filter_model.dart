class CatigoryFilter {
  String? search;
  int? limit;
  int? offset;
  bool? isOfline;

  CatigoryFilter({
    this.search,
    this.limit = 500,
    this.offset,
    this.isOfline = false,
  });

  CatigoryFilter.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    search = json['search'];
    isOfline = json['isOfline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search'] = search;
    data['limit'] = limit;
    data['offset'] = offset;
    data['isOfline'] = isOfline;
    return data;
  }
}
