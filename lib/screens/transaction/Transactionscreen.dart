import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      builder: (BuildContext context, List<TransactionModel> newlist, _) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final value = newlist[index];
            return Slidable(
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => _,
                    icon: Icons.cancel,
                    borderRadius: BorderRadius.circular(30),
                    backgroundColor: Colors.green,
                    label: 'Cancel',
                  ),
                  SlidableAction(
                    onPressed: (context) =>
                        transactionDB.instance.deleteTransactions(value.id),
                    borderRadius: BorderRadius.circular(30),
                    label: 'Delete',
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              child: SizedBox(
                height: 84,
                child: Card(
                  color: Color.fromARGB(255, 238, 209, 243),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 50,
                        backgroundColor: (value.type == CategoryType.income
                            ? Colors.green[400]
                            : Colors.red[400]),
                        child: Text(
                          parseDate(value.date),
                          textAlign: TextAlign.center,
                        )),
                    title: Text(
                      "Rs ${value.amount}",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      value.type.name,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: newlist.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final dated = DateFormat.MMMd().format(date);
    final splitedDate = dated.split(' ');
    return '${splitedDate.last}\n ${splitedDate.first}';
  }
}
