import 'category.dart';

class Expense {
  final String id;
  final String title;
  final int amountCents;
  final DateTime date;

  const Expense({
    required this.id,
    required this.title,
    required this.amountCents,
    required this.date,
  });

  Expense copyWith({String? title, int? amountCents}) => Expense(
    id: id,
    title: title ?? this.title,
    amountCents: amountCents ?? this.amountCents,
    date: date,
  );
  @override
  String toString() => 'Expense($title, $amountCents)';
}
