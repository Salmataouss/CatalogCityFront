import 'dart:convert';

class CategoryModel {
  final Map<String, dynamic> name;
  final String media;

  CategoryModel({required this.name, required this.media});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json['name'],
        media: json['media'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "media": media,
      };
}

List<CategoryModel> categoryFromJson(String str) => List<CategoryModel>.from(
      json.decode(str).map(
            (category) => CategoryModel.fromJson(category),
          ),
    );

String categoryToJson(List<CategoryModel> categories) => json.encode(
      List<dynamic>.from(
        categories.map(
          (category) => category.toJson(),
        ),
      ),
    );
