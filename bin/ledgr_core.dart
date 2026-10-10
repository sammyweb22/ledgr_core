import 'package:ledgr_core/ledgr_core.dart';

void main() {
  final lunch = Expense(
    id: '1',
    title: 'Lunch',
    amountCents: 1250,
    category: Category.food,
    date: DateTime.now(),
  );

  print(lunch);
  print(lunch.copyWith(amountCents: 1500));

  // ---- tracker part ----
  final tracker = ExpenseTracker();
  tracker.add(lunch);
  tracker.add(
    Expense(
      id: '2',
      title: 'Bus fare',
      amountCents: 300,
      category: Category.transport,
      date: DateTime(2026, 9, 15),
    ),
  );

  print(tracker.sorted.map((e) => e.title).toList()); // [Lunch, Bus fare]
  print(tracker.expenses.map((e) => e.title).toList()); // [Lunch, Bus fare]

  print(tracker.update(lunch.copyWith(title: 'Big lunch'))); // true
  print(tracker.remove('2')); // true
  print(tracker.remove('2')); // false: already gone
  print(tracker.remove('999')); // false: never existed
  print(tracker.expenses.length); // 1
}
