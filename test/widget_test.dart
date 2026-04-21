import 'package:flutter_test/flutter_test.dart';

import 'package:rapidpack/app/rapidpack_app.dart';

void main() {
  testWidgets('RapidPack smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RapidPackApp());
    expect(find.text('RapidPack'), findsOneWidget);
  });
}
