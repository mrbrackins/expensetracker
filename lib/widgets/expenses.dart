import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/nex_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
    title: 'Flutter course', 
    amount: 19.99, 
    date: DateTime.now(), 
    category: Category.work
    ),
      Expense(
    title: 'Cinema', 
    amount: 7.99, 
    date: DateTime.now(), 
    category: Category.leisure
    ),


  ];

  void _openAddExpensesOverlay(){
    // ...
    showModalBottomSheet(context: context, builder: (ctx){
      return const NewExpense();
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Flutter Expense Tracker'),
        actions: [
        IconButton(onPressed: _openAddExpensesOverlay, icon: const Icon(Icons.add))
      ]),
      body: Column(
        children: [
          const Text('the chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}