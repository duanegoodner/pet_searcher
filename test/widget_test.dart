// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:pet_matcher/app.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
//import 'package:pet_matcher/screens/login_screen.dart';

//class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('Landing screen widget test: ', () {

    /*
    testWidgets(
        //REFERENCE: https://iiro.dev/writing-widget-tests-for-navigation-events/
        'ElevatedButton for login is present and triggers navigation after tapped',
        (WidgetTester tester) async {
      //PROBLEM--does not recognize the routes
      /*
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(
        MaterialApp(
          home: LandingScreen(),
          navigatorObservers: [mockObserver],
        ),
        */

      //PROBLEM: Tried going up to app.dart where routes are declared to get around routing issue
      //final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(PetMatcherApp());

      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      //PROBLEM: Error says Firebase is not initialized. That's in main.dart.
      //await tester.pumpAndSettle(); 

      /// Verify push event happened
      //verify(mockObserver.didPush(any, any));

      /// Verify new screen is present
      //expect(find.byType(LoginScreen), findsOneWidget);
    });
    */

    testWidgets('has title text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LandingScreen()));
      var title = find.text('Pet Matcher');
      expect(title, findsOneWidget);
    });

    testWidgets('has a login button', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LandingScreen()));
      var button = find.byType(ElevatedButton);
      expect(button, findsOneWidget);
    });

    testWidgets('has an account creation link', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LandingScreen()));
      var accountCreationLink = find.text('Create Account');
      expect(accountCreationLink, findsOneWidget);
    });
  });

  //NOTE: Sample widget tests for generic counter app. Leaving for reference.
  /*
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(PetMatcherApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  */
}
