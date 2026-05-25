import 'package:flutter_test/flutter_test.dart';
import 'package:gym_workout_plan/main.dart';

void main() {
  testWidgets('Gym workout plan smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GymWorkoutApp());

    expect(find.text('Meu Treino'), findsOneWidget);
    expect(find.text('Nenhum exercício ainda'), findsOneWidget);
  });
}
