import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/Transactions/transaction_Model.dart';

 const TRANSACTION_DB_NAME="transaction-database";

abstract class transactionDBFunctions{
  Future<void>insertTransaction(TransactionModel value);
   Future<List<TransactionModel>> getTransaction();

}

class transactionDB implements transactionDBFunctions {
  @override

  //singleton
  transactionDB._internal();
  static transactionDB instance =transactionDB._internal();
  factory transactionDB(){
    return instance;
  }


  Future<void> insertTransaction(TransactionModel value) async{
  final  transaction_db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
  transaction_db.put(value.id, value);

  }

  @override
  Future<List<TransactionModel>> getTransaction() async{
     final  transaction_db=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transaction_db.values.toList();
  }
  
}