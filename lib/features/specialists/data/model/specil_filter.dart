class SpecialFilter {
  int? specCat;
  String? search;
  int? limit;
  int? offset;
  bool? canel;

  SpecialFilter({
    this.specCat,
    this.search,
    this.limit,
    this.offset,
    this.canel = false,
  });

  SpecialFilter.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    specCat = json['spec_cat'];
    search = json['search'];
    canel = json['canel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['spec_cat'] = specCat;
    data['search'] = search;
    data['limit'] = limit;
    data['offset'] = offset;
    data['canel'] = canel;
    return data;
  }
}
