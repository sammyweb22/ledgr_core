import 'package:ledgr_core/ledgr_core.dart';
import 'package:test/test.dart';

// Helper: makes a test expense. Only pass the values a test cares about.
Expense makeExpense({
  String id = '1',
  String title = 'Lunch',
  int amountCents = 1000,
  Category category = Category.food,
  DateTime? date,
}) {
  return Expense(
    id: id,
    title: title,
    amountCents: amountCents,
    category: category,
    date: date ?? DateTime(2026, 10, 15),
  );
}

void main() {
  group('formatCents', () {
    test('formats dollars and cents', () {
      expect(formatCents(1250), '\$12.50');
    });

    test('pads single-digit cents', () {
      expect(formatCents(305), '\$3.05');
    });

    test('formats zero', () {
      expect(formatCents(0), '\$0.00');
    });
  });

  group('ExpenseTracker', () {
    late ExpenseTracker tracker;

    setUp(() {
      tracker = ExpenseTracker();
    });

    test('starts empty', () {
      expect(tracker.expenses, isEmpty);
    });

    test('add stores the expense', () {
      tracker.add(makeExpense());
      expect(tracker.expenses, hasLength(1));
    });

    test('add rejects a zero amount', () {
      expect(
        () => tracker.add(makeExpense(amountCents: 0)),
        throwsArgumentError,
      );
    });

    test('remove returns false for an unknown id', () {
      expect(tracker.remove('999'), isFalse);
    });

    test('update replaces the expense with the same id', () {
      tracker.add(makeExpense(title: 'Lunch'));
      tracker.update(makeExpense(title: 'Big lunch'));
      expect(tracker.expenses.single.title, 'Big lunch');
    });

    test('sorted returns newest first without changing the original order', () {
      tracker.add(makeExpense(id: 'old', date: DateTime(2026, 9, 1)));
      tracker.add(makeExpense(id: 'new', date: DateTime(2026, 10, 1)));

      expect(tracker.sorted.first.id, 'new');
      expect(tracker.expenses.first.id, 'old');
    });

    test('add rejects a blank title', () {
      expect(() => tracker.add(makeExpense(title: '   ')), throwsArgumentError);
      tracker.add(makeExpense());
    });

    test('remove deletes an existing expense', () {
      tracker.add(makeExpense());
      expect(tracker.remove('1'), isTrue);
      expect(tracker.expenses, isEmpty);
    });

    test('totalForMonth ignores other months', () {
      tracker.add(
        makeExpense(id: 'a', amountCents: 500, date: DateTime(2026, 9, 10)),
      );
      tracker.add(
        makeExpense(id: 'b', amountCents: 700, date: DateTime(2026, 10, 10)),
      );
      expect(tracker.totalForMonth(2026, 9), 500);
    });
  });
}
