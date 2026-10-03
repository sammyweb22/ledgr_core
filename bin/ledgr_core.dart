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
}
