import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_nextgen/app/app.dart'; // Import the correct app file

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      const ProviderScope(
        child: VoltRunningApp(), // Use the correct app class
      ),
    );

    // Rest of your test code...
  });
}
