
import 'package:flutter/material.dart';
import 'package:moneymanagement/db/Category/Category_db.dart';
import 'package:moneymanagement/db/Transactions/transaction_db.dart';
import 'package:moneymanagement/models/Category/Category_Model.dart';
import 'package:moneymanagement/models/Transactions/transaction_Model.dart';

class transactionAddScreen extends StatefulWidget {
  static const routeName='add-transaction';
    
    const transactionAddScreen({super.key});

  @override
  State<transactionAddScreen> createState() => _transactionAddScreenState();
}

class _transactionAddScreenState extends State<transactionAddScreen> {
  @override
  void initState() {
    CategoryDB().refreshUI();
    super.initState();
  }

  DateTime? _selecteddate;
  CategoryType? _categorytypenotifier;
  String? categoryId;
  final _purposetxtcontroller=TextEditingController();
  final _amounttxtcontroller=TextEditingController();
  CategoryModel? _selectedcategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              //puropose
              TextFormField(
                controller: _purposetxtcontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                  labelText: 'Purpose',
                  hintText: 'purpose....',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //amount

               TextFormField(
                controller: _amounttxtcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                   labelText: 'Amount',
                  hintText: 'Amount...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                ),
                ),
                //Date
                  SizedBox(
                    height: 10,
                  ),

                  //date

               TextButton.icon(onPressed: () async{
                final  _tempselecteddate= await showDatePicker(
                                context: context, 
                                currentDate: DateTime.now(),
                                firstDate: DateTime.now().subtract(Duration(days: 30)), 
                                lastDate: DateTime.now() 
                                );     
                                 setState(() {
                                    _selecteddate=_tempselecteddate;
                                 });
                               
                                      
               }, 
               icon: Icon(Icons.date_range_outlined), 

               label:
               Text(
                _selecteddate==null ?'SelectDate' : _selecteddate.toString().replaceAll("00:00:00.000", ""))),
              //CategoryType
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                  //income
                   Row(
                    children: [
                      Radio(value:CategoryType.income, 
                      groupValue: _categorytypenotifier, 
                      onChanged: (value) {
                        setState(() {
                          _categorytypenotifier=value;
                          categoryId=null;
                        });
                       
                      },),
                        Text('Income')
                    ],
                  
                   ),
                   //expense
                    Row(
                    children: [
                      Radio(value:CategoryType.expense , 
                      groupValue:_categorytypenotifier , 
                      onChanged: (value) {
                         setState(() {
                          _categorytypenotifier=value;
                          categoryId=null;
                        });
                       
                         
                      },),
                             Text('Expense')    
                      
                    ],
                   ),

                 ],
               ),

               //selectCategory
               DropdownButton(
                value: categoryId,
                hint: Text('Select Category'),
                items: (_categorytypenotifier==CategoryType.income 
                ?CategoryDB().incomeCategoryNotifier 
                :CategoryDB().expenseCategoryNotifier)
                .value.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () => _selectedcategory=e,
                    );
               }).toList() 
               , onChanged: (value) {
                 setState(() {
                   categoryId=value;

                 });
               },
               ),
               SizedBox(
                height: 10,
               ),
               ElevatedButton(onPressed:() {
                addTransaction();
                Navigator.of(context).pop();
               }, child: Text("Submit"))
            ],
          ),
        )
        ),
    );
  }

  Future<void> addTransaction() async{
    final purpose=_purposetxtcontroller.text;
    final amount=_amounttxtcontroller.text;

    if (purpose==null) {
      return;
      
    }

     if (amount==null) {
      return;
    }
    final amountValue=double.tryParse(amount);
      if (amountValue==null) {
      return;
    }

    if (_selecteddate==null) {
      return;
    }

     if (_categorytypenotifier==null) {
      return;
    }
    final  transactionmodel= TransactionModel(
      purpose: purpose, 
      amount: amountValue, 
      date: _selecteddate!, 
      type: _categorytypenotifier!, 
      category: _selectedcategory!
      );
      print(transactionmodel.purpose);
      transactionDB.instance.insertTransaction(transactionmodel); 
    }


  }
