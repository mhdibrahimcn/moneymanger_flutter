import 'package:hive_flutter/hive_flutter.dart';
part 'Category_Model.g.dart';



@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  bool isDeleted;

  @HiveField(3)
  final CategoryType type;

  CategoryModel({required this.id, required this.name, required this.type, this.isDeleted = false});
}