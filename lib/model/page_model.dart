import 'dart:convert';

class PageModel {
  int? page;
  int? total_pages;
  int? total_results;

  PageModel({
    this.page,
    this.total_pages,
    this.total_results,
  });

  factory PageModel.fromJson(String str) {
    return PageModel.fromMap(json.decode(str));
  }

  factory PageModel.fromMap(Map<String, dynamic> json) {
    return PageModel(
      page: json["page"],
      total_pages: json["total_pages"],
      total_results: json["total_results"],
    );
  }
}
