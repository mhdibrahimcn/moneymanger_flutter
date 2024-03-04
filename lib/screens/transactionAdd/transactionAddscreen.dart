import 'package:flutter/material.dart';
import 'package:moneymanagement/db/Category/Category_db.dart';
import 'package:moneymanagement/models/Category/Category_Model.dart';

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
//purpose 
  DateTime? _selecteddate;
  CategoryType? _categorytypenotifier;
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
                        });
                       
                         
                      },),
                             Text('Expense')    
                      
                    ],
                   ),

                 ],
               ),

               //selectCategory
               DropdownButton(
                hint: Text('Select Category'),
                items: CategoryDB().expenseCategoryNotifier.value.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name)
                    );
               }).toList() 
               , onChanged: (value) {
                 
               },
               ),
               SizedBox(
                height: 10,
               ),
               ElevatedButton(onPressed:() {}, child: Text("Submit"))
            ],
          ),
        )
        ),
    );
  }
}