import 'package:expense_tracker_app/components/expenses_list.dart';
import 'package:expense_tracker_app/models/custom_text_display.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseMainScreen extends StatefulWidget {
  const ExpenseMainScreen({super.key});

  @override
  State<ExpenseMainScreen> createState() => _ExpenseMainScreenState();
}

class _ExpenseMainScreenState extends State<ExpenseMainScreen> {

  final List<Expense> _registeredExpenses = [

    Expense(title: 'flutter curse', amount: 100, date: DateTime.now(), category: Category.work),
    Expense(title: 'maldivas', amount: 4000, date: DateTime.now(), category: Category.travel),
    Expense(title: 'cinema', amount: 20, date: DateTime.now(), category: Category.leisure)

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTextDisplay(
            text: 'placeholder',
            fontSize: 20,
            color: Colors.black,
          ),
          Expanded(child: ExpensesList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}
