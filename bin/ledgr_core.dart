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

  tracker.add(
    Expense(
      id: '3',
      title: 'Netflix',
      amountCents: 1599,
      category: Category.fun,
      date: DateTime(2026, 10, 2),
    ),
  );
  tracker.add(
    Expense(
      id: '4',
      title: 'Electricity',
      amountCents: 4520,
      category: Category.bills,
      date: DateTime(2026, 9, 28),
    ),
  );

  print(formatCents(tracker.totalFor(Category.food))); // $12.50
  print(formatCents(tracker.totalForMonth(2026, 9))); // $45.20
  print(formatCents(305)); // $3.05

  for (final entry in tracker.breakdown().entries) {
    print('${entry.key.emoji} ${entry.key.label}: ${formatCents(entry.value)}');
  }

  try {
    tracker.add(lunch.copyWith(amountCents: -5));
  } on ArgumentError catch (e) {
    print('Rejected: ${e.message}'); // Rejected: Amount must be positive
  }

  try {
    tracker.add(lunch.copyWith(title: '   '));
  } on ArgumentError catch (e) {
    print('Rejected: ${e.message}'); // Rejected: Title cannot be empty
  }
}
