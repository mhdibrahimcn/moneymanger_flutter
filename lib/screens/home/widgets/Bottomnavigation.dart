import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/home/Homesceen.dart';

class Bottomnavigation extends StatelessWidget {
  const Bottomnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      child: ValueListenableBuilder(
        valueListenable: Homescreen.selectedindex,
        builder: (BuildContext context, int updatedindex, _) {
          return BottomNavigationBar(
              backgroundColor: Colors.purple[500],
              selectedItemColor: Colors.purple[50],
              unselectedItemColor: Colors.black87,
              currentIndex: updatedindex,
              onTap: (newvalue) {
                Homescreen.selectedindex.value = newvalue;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Transaction'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Category'),
              ]);
        },
      ),
    );
  }
}
