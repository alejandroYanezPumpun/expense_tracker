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
    Navigator.of(context).pop();
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
      title: 'Flight Tickets',
      amount: 299.99,
      date: DateTime.now().subtract(Duration(days: 5)),
      category: Category.travel,
    ),
    Expense(
      title: 'Office Supplies',
      amount: 45.00,
      date: DateTime.now().subtract(Duration(days: 2)),
      category: Category.work,
    ),
    Expense(
      title: 'Coffee Meeting',
      amount: 12.99,
      date: DateTime.now().subtract(Duration(days: 4)),
      category: Category.work,
    ),
    Expense(
      title: 'Movie Night',
      amount: 18.50,
      date: DateTime.now().subtract(Duration(days: 6)),
      category: Category.leisure,
    ),
    Expense(
      title: 'Breakfast',
      amount: 8.75,
      date: DateTime.now().subtract(Duration(days: 7)),
      category: Category.food,
    ),
    Expense(
      title: 'Uber Ride',
      amount: 22.30,
      date: DateTime.now().subtract(Duration(days: 8)),
      category: Category.travel,
    ),
  ];

  double get _totalExpenses {
    return _registeredExpenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLandscape = width > MediaQuery.of(context).size.height;
    
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
        padding: EdgeInsets.only(bottom: isLandscape ? 65 : 82),
        child: ExpensesList(
          expenses: _registeredExpenses,
          onRemoved: _removeExpense,
          isLandscape: isLandscape,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a new expense',
        ),
        actions: [
          IconButton(onPressed: _openAddExpensesOverlay, icon: Icon(Icons.add),iconSize: 36,),
        ],
      ),
      body: isLandscape 
        ? Row(
            children: [
              // Chart a la izquierda en modo apaisado
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chart(expenses: _registeredExpenses),
                ),
              ),
              // Lista de expenses a la derecha en modo apaisado
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'Expense List',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(child: mainContent),
                  ],
                ),
              ),
            ],
          )
        : Column(
            // Layout vertical en modo retrato
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
            bottom: 7,
            left: 30,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isLandscape ? 12 : 16, 
                vertical: isLandscape ? 8 : 12,
              ),
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
                    size: isLandscape ? 18 : 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Total: \$${_totalExpenses.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: isLandscape ? 14 : 16,
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
            bottom: 1,
            right: 6,
            child: FloatingActionButton(
              mini: isLandscape, // Botón más pequeño en modo apaisado
              onPressed: widget.onThemeToggle,
              tooltip: widget.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              child: Icon(
                widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                size: isLandscape ? 20 : 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}