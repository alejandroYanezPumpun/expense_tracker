import 'package:expense_tracker_app/models/custom_text_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpenseEntry extends StatefulWidget {
  const NewExpenseEntry({super.key});

  @override
  State<NewExpenseEntry> createState() => _NewExpenseEntryState();
}

class _NewExpenseEntryState extends State<NewExpenseEntry> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _presentDatePicker(){
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(context: context, firstDate: firstDate, lastDate: now);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: CustomTextDisplay(
                text: 'Title',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  decoration: InputDecoration(
                    label: CustomTextDisplay(
                      text: 'amount',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    prefixText: '\$ ',
                  ),
                ),
              ),

              SizedBox(width: 16),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextDisplay(
                      text: 'selected date',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    IconButton(onPressed: _presentDatePicker , icon: Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print('=== BOTÓN PRESIONADO ===');
                  print('Valor del título: ${_titleController.text}');
                  print('Valor del título: ${_amountController.text}');
                  print('=== FIN DEBUG ===');
                },
                child: CustomTextDisplay(
                  text: 'Save expense',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: CustomTextDisplay(
                  text: 'cancel expense',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
