import 'package:expense_tracker_app/models/custom_text_display.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        child: Column(
          children: [
            CustomTextDisplay(
              text: expense.title,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 4,),
            Row(
              children: [
                CustomTextDisplay(text: '\$${expense.amount.toStringAsFixed(2)}', fontSize: 14, color: Colors.black),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width: 8,),
                    CustomTextDisplay(text: expense.formattedDate, fontSize: 14, color: Colors.black)

                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
