class CategoryModel {
  final String id;
  final String name;
  final String icon; // Added to match the UI's needs

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String name = json['name'] ?? '';
    return CategoryModel(
      id: json['id'] ?? '',
      name: name,
      // Generate an icon from the first letter of the name
      icon: name.isNotEmpty ? name[0].toUpperCase() : '?',
    );
  }
}