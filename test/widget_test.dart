import 'package:flutter_test/flutter_test.dart';
import 'package:laffa_dashboard/main.dart';

void main() {
  testWidgets('Dashboard app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const LaffaDashboardApp());
    expect(find.text('Laffa'), findsOneWidget);
  });
}
