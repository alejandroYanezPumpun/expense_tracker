import 'package:expense_tracker_app/components/expenses_list.dart';
import 'package:expense_tracker_app/components/new_expense.dart';
import 'package:expense_tracker_app/models/custom_text_display.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseMainScreen extends StatefulWidget {
  const ExpenseMainScreen({super.key});

  @override
  State<ExpenseMainScreen> createState() => _ExpenseMainScreenState();
}

class _ExpenseMainScreenState extends State<ExpenseMainScreen> {
  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenseEntry(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: CustomTextDisplay(
          text: 'Espense ${expense.title} was deleted',
          fontSize: 18,
          color: Colors.white,
        ),
        action: SnackBarAction(label: 'Undo', onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }),
      ),
    );
  }

  final List<Expense> _registeredExpenses = [];

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: CustomTextDisplay(
        text: 'No expenses found. Start adding some!',
        fontSize: 20,
        color: Colors.black,
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoved: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: CustomTextDisplay(
          text: 'expense tracker',
          fontSize: 16,
          color: Colors.black,
        ),
        actions: [
          IconButton(onPressed: _openAddExpensesOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          CustomTextDisplay(
            text: 'placeholder',
            fontSize: 20,
            color: Colors.black,
          ),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
