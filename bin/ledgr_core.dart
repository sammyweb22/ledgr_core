import 'package:ledgr_core/ledgr_core.dart';

void main() {
  for (final c in Category.values) {
    print('${c.emoji} ${c.label}');
  }
}
