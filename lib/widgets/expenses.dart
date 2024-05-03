import 'package:expense_tracker/widgets/chart/chart.dart';
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
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (ctx){
      return  NewExpense(onAddExpense: _addExpense);
    });

  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
 ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }),
        duration: Duration(seconds: 3),
        content:  Text('Expense Deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(child: Text('No expenses found. Start adding some!'),);

    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense, );
    }


    return  Scaffold(
      appBar: AppBar(title: const Text('Flutter Expense Tracker'),
        actions: [
        IconButton(onPressed: _openAddExpensesOverlay, icon: const Icon(Icons.add))
      ]),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}