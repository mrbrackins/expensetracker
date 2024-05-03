import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  //2. add a parameter to accept expenses and assign to final list expenses value on step 1
  const ExpensesList({super.key, 
  required this.expenses,
  required this.onRemoveExpense,
  });

  //1. accept input like a prop
  final List<Expense> expenses;
  //accept function from expenses file so we can remove
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //ListView Builder will be called however many times item count is...
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) {
          Expense currentExpense = expenses[index];
          return Dismissible(
            background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal)),
            key: ValueKey(currentExpense),
            onDismissed: (direction){
              onRemoveExpense(currentExpense);
            } ,
            child: ExpenseItem(currentExpense));
        });
  }
}
