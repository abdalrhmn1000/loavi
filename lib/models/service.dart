class CategoryService {
  final int id;
  final String name;
  final String categoryId;

  CategoryService(
      {required this.categoryId, required this.name, required this.id});
  factory CategoryService.fromJson(Map<String, dynamic> json) =>
      CategoryService(
          categoryId: json['category_id'], name: json['name'], id: json['id']);
}
