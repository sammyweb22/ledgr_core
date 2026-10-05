import 'expense.dart';

class ExpenseTracker {
  final List<Expense> _expenses = [];
  List<Expense> get expenses => List.unmodifiable(_expenses);

  void add(Expense expense) {
    _expenses.add(expense);
  }
}
