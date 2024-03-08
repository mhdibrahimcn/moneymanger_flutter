import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/Transactions/transaction_Model.dart';

const TRANSACTION_DB_NAME = "transaction-database";

abstract class transactionDBFunctions {
  Future<void> insertTransaction(TransactionModel value);
  Future<List<TransactionModel>> getTransaction();
  Future deleteTransactions(id);
}

class transactionDB implements transactionDBFunctions {
  @override

  //singleton
  transactionDB._internal();
  static transactionDB instance = transactionDB._internal();
  factory transactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> TransactionDbNotifier =
      ValueNotifier([]);

  Future<void> insertTransaction(TransactionModel value) async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transaction_db.put(value.id, value);
  }

  Future<void> refreshUi() async {
    final _list = await getTransaction();
    _list.sort((first, second) => second.date.compareTo(second.date));
    TransactionDbNotifier.value.clear();
    TransactionDbNotifier.value.addAll(_list);
    TransactionDbNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    return transaction_db.values.toList();
  }

  @override
  Future deleteTransactions(id) async {
    final transaction_db =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transaction_db.delete(id);
    refreshUi();
  }
}
