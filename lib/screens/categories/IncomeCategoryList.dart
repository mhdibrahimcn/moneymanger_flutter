// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moneymanagement/db/Category/Category_db.dart';
import 'package:moneymanagement/models/Category/Category_Model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryNotifier,
      builder: (BuildContext context, List<CategoryModel> newList, _) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final category = newList[index];
              return Card(
                elevation: 2,
                color: Color.fromARGB(255, 238, 209, 243),
                child: ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDB.instance.deleteCategory(category.id);
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 2,
                ),
            itemCount: newList.length);
      },
    );
  }
}
