import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/categories/CategoryAddPopup.dart';
import 'package:moneymanagement/screens/categories/Categoryscreen.dart';
import 'package:moneymanagement/screens/home/widgets/Bottomnavigation.dart';
import 'package:moneymanagement/screens/transaction/Transactionscreen.dart';
import 'package:moneymanagement/screens/transactionAdd/transactionAddscreen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});
  final pages =const[
    Transactionscreen(),
    Categoryscreen(),
  ];
  static ValueNotifier <int> selectedindex=ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Money Manager',
        style: TextStyle(
          fontSize: 26,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        
        ),
        centerTitle: true,
      ),
      bottomNavigationBar:const Bottomnavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if (selectedindex.value==0) {
            Navigator.of(context).pushNamed(transactionAddScreen.routeName);
          }else{
            showCategoryAddpopup(context);
          }
        },
        child: Icon(Icons.add),
        ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindex,
          builder: (BuildContext context, int updatedindex, Widget? child) {
            return  pages[updatedindex];
          },
        ),
      ),
    );
  }
}