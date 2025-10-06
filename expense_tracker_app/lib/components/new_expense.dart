import 'package:expense_tracker_app/models/custom_text_display.dart';
import 'package:expense_tracker_app/models/expense.dart';
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
  DateTime? _selectedDate;
  Category selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: CustomTextDisplay(
                text: 'invalid input',
                fontSize: 16,
                color: Colors.black,
              ),
              content: CustomTextDisplay(text: 'Please make sure a valid title, date, amount and category was selected', fontSize: 16, color: Colors.black),
              actions: [
                TextButton(onPressed: () {Navigator.pop(ctx);}, child: CustomTextDisplay(text: 'Okay', fontSize: 16, color: Colors.black))
              ],
            ),
      );
      return;
    }
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
                      text:
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!),
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: CustomTextDisplay(
                  text: 'cancel',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                },
                child: CustomTextDisplay(
                  text: 'save',
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
