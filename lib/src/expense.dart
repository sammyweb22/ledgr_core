import 'category.dart';

class Expense {
  final String id;
  final String title;
  final int amountCents;
  final Category category;
  final DateTime date;

  const Expense({
    required this.id,
    required this.title,
    required this.amountCents,
    required this.category,
    required this.date,
  });

  Expense copyWith({
    String? title,
    int? amountCents,
    Category? category,
    DateTime? date,
  }) => Expense(
    id: id,
    title: title ?? this.title,
    amountCents: amountCents ?? this.amountCents,
    category: category ?? this.category,
    date: date ?? this.date,
  );
  @override
  String toString() =>
      'Expense(id: $id, title: $title, amountCents: $amountCents, category: $category, date: $date)';
}
