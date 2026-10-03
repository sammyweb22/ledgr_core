enum Category {
  food('Food', '🍔'),
  transport('Transport', '🚌'),
  bills('Bills', '🧾'),
  fun('Fun', '🎉'),
  other('Other', '📦');

  const Category(this.label, this.emoji);
  final String label;
  final String emoji;
}
