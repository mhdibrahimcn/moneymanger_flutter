import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/Category/Category_Model.dart';

const CATEGORY_DB_NAME="category-database";



abstract class CategoryDbFunctions{

  Future<List<CategoryModel>> getCategories();
  Future<void>insertCategory(CategoryModel value);
  Future<void>deleteCategory(String CategoryID);

}



class CategoryDB implements CategoryDbFunctions{

//singleton
  CategoryDB._internal();

  static CategoryDB instance=CategoryDB._internal();

  factory CategoryDB(){

    return instance;
  }


  ValueNotifier <List<CategoryModel>>incomeCategoryNotifier=ValueNotifier([]);
  ValueNotifier <List<CategoryModel>>expenseCategoryNotifier=ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async{
   
    final _category_DB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _category_DB.put(value.id,value);
    refreshUI();
      }
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _category_DB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _category_DB.values.toList();
  }

  Future refreshUI() async{

    final _allcategories= await getCategories();
    incomeCategoryNotifier.value.clear();
    expenseCategoryNotifier.value.clear();
    await Future.forEach(_allcategories, (CategoryModel category) {
      if (category.type==CategoryType.income) {
        incomeCategoryNotifier.value.add(category);
      }
      else{
        expenseCategoryNotifier.value.add(category);
      }
    }
   
    );
     incomeCategoryNotifier.notifyListeners();
     expenseCategoryNotifier.notifyListeners();

  }
  
  @override
  Future<void> deleteCategory(String CategoryID) async{
     final _category_DB=await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
     await _category_DB.delete(CategoryID);
     refreshUI();
  }
  
  
}

