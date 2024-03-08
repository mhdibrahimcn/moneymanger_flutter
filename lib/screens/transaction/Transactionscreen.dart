import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/db/Category/Category_db.dart';
import 'package:moneymanagement/db/Transactions/transaction_db.dart';
import 'package:moneymanagement/models/Category/Category_Model.dart';
import 'package:moneymanagement/models/Transactions/transaction_Model.dart';


class Transactionscreen extends StatelessWidget {
  const Transactionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    transactionDB.instance.refreshUi();
    return ValueListenableBuilder(
      valueListenable: transactionDB.instance.TransactionDbNotifier,
      builder: (BuildContext context,  List<TransactionModel> newlist, _) {
        return  ListView.separated(  
      itemBuilder: (BuildContext context, int index) {
        final value=newlist[index];
    
        return  SizedBox(
          height: 90,
          child: Card(
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 50,
                backgroundColor: (
                value.type==CategoryType.income 
                ?Colors.green[400] 
                :Colors.red[400]),
                child: Text(parseDate(value.date),
                textAlign: TextAlign.center,
                )),
                
          
              title:Text("Rs ${value.amount}"),
              subtitle: Text(value.type.name),
            
            ),
          ),
        );
        
      },
       itemCount:newlist.length,
      separatorBuilder: (BuildContext context, int index) {
        return  SizedBox(height: 10,);
   }, 
    );
      },
    );
  }
  String parseDate(DateTime date){
    final dated=DateFormat.MMMd().format(date);
    final splitedDate=dated.split(' ');
    return '${splitedDate.last}\n ${splitedDate.first}';
  }
}