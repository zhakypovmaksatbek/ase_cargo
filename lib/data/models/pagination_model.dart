class PaginationModel<T> {
  int? count;
  int? totalPages;
  String? next;
  String? previous;
  List<T>? results;

  PaginationModel({this.count, this.next, this.previous, this.results});

  PaginationModel.fromJson(Map<String, dynamic> json, Function fromJsonModel) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    totalPages = json['total_pages']?.toInt();
    if (json['results'] != null) {
      results = <T>[];
      json['results'].forEach((v) {
        results!.add(fromJsonModel(v));
      });
    }
  }
}
