import 'package:flutter/material.dart';
import 'package:moneymanagement/db/Category/Category_db.dart';
import 'package:moneymanagement/screens/categories/ExpenseCategoryList.dart';
import 'package:moneymanagement/screens/categories/IncomeCategoryList.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({super.key});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabarcontroller;

  @override
  void initState() {
    _tabarcontroller = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabarcontroller,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              )
            ]),
        Expanded(
          child: TabBarView(controller: _tabarcontroller, children: [
            const IncomeCategoryList(),
            const ExpenseCategoryList()
          ]),
        )
      ],
    );
  }
}
