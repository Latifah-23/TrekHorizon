import 'package:camping_app/main.dart'; // تم إصلاح مسار الاستيراد لاستخدام اسم المشروع الصحيح
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // تأكد من أن الفئة الرئيسية في main.dart اسمها 'MyApp'
    await tester.pumpWidget(const MyApp());

    // تحقق من أن العداد يبدأ بالصفر. (اختبار افتراضي)
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // اضغط على زر 'إضافة'.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // تحقق من أن العداد قد ازداد.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
