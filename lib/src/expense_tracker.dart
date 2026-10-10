import 'expense.dart';

class ExpenseTracker {
  final List<Expense> _expenses = [];
  List<Expense> get expenses => List.unmodifiable(_expenses);

  void add(Expense expense) {
    _expenses.add(expense);
  }

  bool remove(String id) {
    final index = _expenses.indexWhere(
      (e) => e.id == id,
    ); // where is it? (-1 = not found)
    if (index == -1) return false; // not found → report failure
    _expenses.removeAt(index); // found → remove it
    return true; // report success
  }

  bool update(Expense updated) {
    final index = _expenses.indexWhere((e) => e.id == updated.id);
    if (index == -1) return false;
    _expenses[index] = updated;
    return true;
  }

  List<Expense> get sorted {
    final copy = [..._expenses];
    copy.sort((a, b) => b.date.compareTo(a.date));
    return copy;
  }
}
