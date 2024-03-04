import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/home/Homesceen.dart';

class Bottomnavigation extends StatelessWidget {
  const Bottomnavigation({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: Homescreen.selectedindex,
      builder: (BuildContext context, int updatedindex,_) {
        return BottomNavigationBar(
        selectedItemColor: Colors.purple,
        currentIndex: updatedindex,
        onTap: (newvalue) {
          Homescreen.selectedindex.value=newvalue;
        },
        items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Transaction'),
      BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Category'),
      
      ]);
        
      },
    
    );
    
  }
}