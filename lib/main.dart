import 'package:flutter/material.dart';

// ********** استيراد جميع الصفحات **********
import 'Screens/intro_screen.dart'; // شاشة البداية
import 'Screens/login.dart'; // تسجيل الدخول
import 'Screens/signup.dart'; // إنشاء حساب
import 'Screens/forgot_password.dart'; // نسيان كلمة المرور
import 'Screens/otp_screen.dart'; // شاشة التحقق OTP
import 'Screens/home_screen.dart'; // الصفحة الرئيسية
import 'Screens/profile.dart'; // الملف الشخصي
import 'Screens/notifications.dart'; // الإشعارات
import 'Screens/wallet.dart'; // المحفظة
import 'Screens/customer_service.dart'; // خدمة العملاء
import 'Screens/privacy.dart'; // سياسة الخصوصية
import 'Screens/map_screen.dart'; // الخريطة
import 'Screens/services_screen.dart'; // الخدمات
import 'Screens/reservations_screen.dart'; // الحجوزات
import 'Screens/setting.dart'; // الإعدادات

import 'db/db_helper.dart'; // استيراد قاعدة البيانات

// ✅ هذه هي الدالة المفقودة التي يطلبها الخطأ
void main() async {
  // ضمان تهيئة بيئة العمل وقاعدة البيانات قبل تشغيل التطبيق
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شريط Debug
      title: 'Camping App',

      // --- إعدادات المظهر العام (Theme) ---
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Poppins', // الخط الموحد للتطبيق
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFAF4), // لون الخلفية الكريمي

        // تخصيص مظهر الـ AppBar ليكون موحداً وشفافاً
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF40281E)),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF40281E),
          ),
        ),
      ),

      // --- نقطة البداية (الجولة التعريفية) ---
      initialRoute: '/intro',

      // --- تعريف المسارات (Routes) لسهولة التنقل ---
      routes: {
        // 1. البداية والمصادقة
        '/intro': (context) => const IntroScreen(),
        '/login': (context) => const LoginFormScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/otp': (context) => const OtpScreen(),

        // 2. الصفحة الرئيسية
        '/home': (context) => const HomeScreen(),

        // 3. الصفحات الفرعية
        '/profile': (context) => const ProfileScreen(),
        '/notifications': (context) => const NotificationsPage(),
        '/wallet': (context) => const WalletScreen(),
        '/customer_service': (context) => const ContactCustomerServiceScreen(),
        '/privacy_policy': (context) => const PrivacyPolicyScreen(),
        '/map': (context) => const MapScreen(),
        '/services': (context) => const ServicesScreen(),
        '/reservations': (context) => const ReservationsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },

      // --- معالجة الأخطاء (عند الانتقال لصفحة غير موجودة) ---
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const Scaffold(
            body: Center(
              child: Text('Error: Page not found!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
    );
  }
}
