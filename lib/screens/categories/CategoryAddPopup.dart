import 'package:flutter/material.dart';
import 'package:moneymanagement/db/Category/Category_db.dart';
import 'package:moneymanagement/models/Category/Category_Model.dart';


ValueNotifier<CategoryType>SelectedCategoryNotifier=ValueNotifier(CategoryType.income);
Future<void>showCategoryAddpopup(BuildContext context) async{
  final texteditcontroller=TextEditingController();
  showDialog(
    context:context , 
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleDialog(
          title: const Text('Add category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: texteditcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'income', type: CategoryType.income),
                  RadioButton(title: 'expense', type: CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {
                if (texteditcontroller.text.isEmpty) {
                  return;
                }
          
                CategoryDB.instance.insertCategory(CategoryModel(
                  id: DateTime.now().microsecondsSinceEpoch.toString(), 
                  name:texteditcontroller.text , 
                  type: SelectedCategoryNotifier.value));
                
                CategoryDB().refreshUI();
                Navigator.of(ctx).pop();
                
              }, 
              child: Text('Add')
              ),
            )
          ],
        ),
      );
    },
    );
}


class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key,required this.title,required this.type});
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:SelectedCategoryNotifier ,
      builder: (BuildContext context, newvalue,_) {
        return  Row(
      children: [
        Radio<CategoryType>(
          value: type, 
          groupValue: newvalue, 
          onChanged:(value) {
            if (value==null) {
              return;
            }
            SelectedCategoryNotifier.value=value;
            //heloo
          },
          ),
          Text(title)
          
      ],
    );
      },
    );
  }
}