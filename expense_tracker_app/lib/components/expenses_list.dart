import 'package:expense_tracker_app/models/custom_text_display.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (ctx, index) => CustomTextDisplay(
            text: expenses[index].title,
            fontSize: 16,
            color: Colors.black38,
          ),
    );
  }
}
