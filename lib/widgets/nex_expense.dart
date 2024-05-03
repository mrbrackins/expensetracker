import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  //accepting functions as values in your own widgets
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final datePicked = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    //executes after await
    setState(() {
      _selectedDate = datePicked;
    });
  }

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null ||enteredAmount <=0;

    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      // show error message
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: Text('Please make sure a valid title, amount, date and category was entered'),
        actions: [TextButton(onPressed: (){
          Navigator.pop(ctx);
        }, child: const Text('Okay'),
        ),
        ],
      ),
      );
      return;
    }

    widget.onAddExpense(Expense(title: _titleController.text, amount:enteredAmount, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // MAKE SURE TO DISOSE CONTROLLERS: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      //full screen mode padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.multiline,
            //label is decoration
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  //label is decoration
                  decoration: const InputDecoration(
                      prefixText: '\$', label: Text('Amount')),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              )),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                        value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if(value == null){
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
                  const Spacer(),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                  
                 
                },
                child: const Text('Save Expense'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
