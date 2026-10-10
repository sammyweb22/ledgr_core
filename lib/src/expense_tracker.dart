import 'expense.dart';
import 'category.dart';

class ExpenseTracker {
  final List<Expense> _expenses = [];
  List<Expense> get expenses => List.unmodifiable(_expenses);

  void add(Expense expense) {
    if (expense.amountCents <= 0) {
      throw ArgumentError('Amount must be positive');
    }
    if (expense.title.trim().isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }
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

  int totalFor(Category category) {
    final matching = _expenses.where((e) => e.category == category);
    return matching.fold<int>(0, (sum, e) => sum + e.amountCents);
  }

  int totalForMonth(int year, int month) {
    final matching = _expenses.where(
      (e) => e.date.year == year && e.date.month == month,
    );
    return matching.fold<int>(0, (sum, e) => sum + e.amountCents);
  }

  Map<Category, int> breakdown() {
    return {for (final c in Category.values) c: totalFor(c)};
  }
}
