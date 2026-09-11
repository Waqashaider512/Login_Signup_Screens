// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:first_screen_flutter/main.dart';

void main() {
  testWidgets('Home navigates forward to Login and Signup', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Malik Waqas Haider'), findsOneWidget);
    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Flutter Mobile Application Developer'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.view_list_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Projects'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(find.text('Contact me'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, 220));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Email'), findsNWidgets(2));
    expect(find.text('Password'), findsNWidgets(2));
    expect(find.text('Forgot Password?'), findsOneWidget);

    await tester.ensureVisible(find.text('Sign Up'));
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsNWidgets(2));
    expect(find.text('Phone Number'), findsNWidgets(2));

    await tester.tap(find.byTooltip('Back to Login'));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsNWidgets(2));

    await tester.tap(find.byTooltip('Back to Home'));
    await tester.pumpAndSettle();
    expect(find.text('Malik Waqas Haider'), findsOneWidget);
  });
}
