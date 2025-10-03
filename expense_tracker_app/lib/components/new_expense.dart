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
          SizedBox(height: 30,),
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
                  print('=== BOTÓN PRESIONADO ===');
                  print('Valor del título: ${_titleController.text}');
                  print('Valor del título: ${_amountController.text}');
                  print('=== FIN DEBUG ===');
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
