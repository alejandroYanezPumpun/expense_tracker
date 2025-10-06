import 'package:expense_tracker_app/components/expense_item.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoved,
  });

  final void Function(Expense expense) onRemoved;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 6),
        child: Dismissible(
          key: ValueKey(expenses[index]),
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 42,
            ),
          ),
          onDismissed: (direction) {
            onRemoved(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        ),
      ),
    );
  }
}