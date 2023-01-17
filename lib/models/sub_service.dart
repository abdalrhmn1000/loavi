class SubService {
  final String id;
  final String name;
  final String categoryId;
  final String parentId;

  SubService(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.parentId});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
        id: json['id'].toString(),
        categoryId: json['category_id'].toString(),
        name: json['name'].toString(),
        parentId: json['parent_id'].toString());
  }
}
