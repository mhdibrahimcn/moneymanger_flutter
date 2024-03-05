import 'package:hive/hive.dart';
import 'package:moneymanagement/models/Category/Category_Model.dart';
part 'transaction_Model.g.dart';
@HiveType(typeId: 3)
class transactionModel {

  @HiveField(0)
final String purpose;

  @HiveField(1)
final double amount;

  @HiveField(2)
final DateTime date;

  @HiveField(3)
final CategoryType type;

  @HiveField(4)
final CategoryModel category;

  transactionModel({
    required this.purpose, 
    required this.amount, 
    required this.date, 
    required this.type, 
    required this.category});
  
}