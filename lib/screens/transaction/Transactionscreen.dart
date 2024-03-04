import 'package:flutter/material.dart';


class Transactionscreen extends StatelessWidget {
  const Transactionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return  SizedBox(height: 10,);
      },
      itemBuilder: (BuildContext context, int index) {
        return const Card(
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 50,
              child: Text("12th dec",
              // textAlign: TextAlign.center,
              )),
            title:Text('10000'),
            subtitle: Text('travelling'),
          
          ),
        );
      },
    );
  }
}