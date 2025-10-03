import 'package:expense_tracker_app/components/custom_text_display.dart';
import 'package:flutter/material.dart';

class ExpenseMainScreen extends StatefulWidget {
  const ExpenseMainScreen({super.key});

  @override
  State<ExpenseMainScreen> createState() => _ExpenseMainScreenState();
}

class _ExpenseMainScreenState extends State<ExpenseMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTextDisplay(
            text: 'some text',
            fontSize: 20,
            color: Colors.black,
          ),
          CustomTextDisplay(
            text: 'some more text',
            fontSize: 20,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
