import 'package:expense_tracker_app/components/expenses_list.dart';
import 'package:expense_tracker_app/components/new_expense.dart';
import 'package:expense_tracker_app/models/charts/chart.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseMainScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  
  const ExpenseMainScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

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
        content: Text(
          'Expense ${expense.title} was deleted',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Lunch at Restaurant',
      amount: 15.99,
      date: DateTime.now().subtract(Duration(days: 1)),
      category: Category.food,
    ),
    Expense(
      title: 'Cinema Tickets',
      amount: 25.50,
      date: DateTime.now().subtract(Duration(days: 3)),
      category: Category.leisure,
    ),
    Expense(
      title: 'Lunch at Restaurant',
      amount: 15.99,
      date: DateTime.now().subtract(Duration(days: 1)),
      category: Category.food,
    ),
    Expense(
      title: 'Cinema Tickets',
      amount: 25.50,
      date: DateTime.now().subtract(Duration(days: 3)),
      category: Category.leisure,
    ),
    Expense(
      title: 'Lunch at Restaurant',
      amount: 15.99,
      date: DateTime.now().subtract(Duration(days: 1)),
      category: Category.food,
    ),
    Expense(
      title: 'Cinema Tickets',
      amount: 25.50,
      date: DateTime.now().subtract(Duration(days: 3)),
      category: Category.leisure,
    ),
    Expense(
      title: 'Lunch at Restaurant',
      amount: 15.99,
      date: DateTime.now().subtract(Duration(days: 1)),
      category: Category.food,
    ),
    Expense(
      title: 'Cinema Tickets',
      amount: 25.50,
      date: DateTime.now().subtract(Duration(days: 3)),
      category: Category.leisure,
    ),
  ];

  double get _totalExpenses {
    return _registeredExpenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black54,
        ),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = Padding(
        padding: const EdgeInsets.only(bottom: 90), // Espacio para los botones flotantes
        child: ExpensesList(
          expenses: _registeredExpenses,
          onRemoved: _removeExpense,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
        ),
        actions: [
          IconButton(onPressed: _openAddExpensesOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 18),
          Chart(expenses: _registeredExpenses),
          SizedBox(height: 2),
          Expanded(child: mainContent),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          // Total de gastos (abajo izquierda)
          Positioned(
            bottom: 6,
            left: 30,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Total Spent: \$${_totalExpenses.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Botón de cambiar tema (abajo derecha)
          Positioned(
            bottom: 6,
            right: 5,
            child: FloatingActionButton(
              onPressed: widget.onThemeToggle,
              tooltip: widget.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              child: Icon(
                widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}