

import 'package:flutter/material.dart';
import 'package:moneymanagement/db/Category/Category_db.dart';
import 'package:moneymanagement/models/Category/Category_Model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenseCategoryNotifier,
      builder: (BuildContext context, List<CategoryModel> newList,_) {
        return  ListView.separated(
      itemBuilder: (context, index) {
        final category=newList[index];
        return Card(
          elevation:2,
          child: ListTile(
            title: Text(category.name),
            trailing: IconButton(onPressed: () {
              CategoryDB.instance.deleteCategory(category.id);
            }, icon: Icon(Icons.delete),
            color: Colors.red,
            ),
          ),
        );
      },
       separatorBuilder: (context, index) => SizedBox(height: 2,), 
       itemCount: newList.length);
      },
    );
  }
}