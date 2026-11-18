import 'package:flutter/material.dart';
import '../db/db_helper.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  // ✅ تم تعديل المسار ليتطابق مع اسم الملف في مجلد الصور
  final String _assetImagePath = "assets/images/rlogo-bg.png";

  bool _rememberMe = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  InputDecoration _textFieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color(0xFF9E9E9E), fontSize: 13, fontFamily: 'Poppins'),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF40281E), width: 0.5)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF40281E), width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF9B5F3B), width: 2)),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text,
          style: const TextStyle(
              color: Color(0xFF40281E),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700)),
    );
  }

  void _handleLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter email and password")));
      return;
    }

    bool exists = await DBHelper().loginUser(email, password);

    if (exists) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid Email or Password! Please sign up first.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= الجزء العلوي (Header + Logo) =================
            SizedBox(
              height: 290,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // الخلفية البنية
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 230,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF9B5F3B),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(500, 110)),
                      ),
                    ),
                  ),

                  // دائرة اللوقو (تم تطبيق التعديلات الجديدة هنا)
                  Positioned(
                    top: 150, // تم الرفع قليلاً (كان 155)
                    child: Container(
                      width: 150, // تم التكبير (كان 140)
                      height: 160, // تم التكبير (كان 150)
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFFAF4),
                        shape: OvalBorder(),
                      ),
                      child: Center(
                        child: Container(
                          width: 145, // تم التكبير ليناسب الدائرة الجديدة
                          height: 145,
                          decoration: BoxDecoration(
                            // تم إزالة BoxShape.circle للسماح بظهور النص المستطيل أو المربع
                            image: DecorationImage(
                              image: AssetImage(_assetImagePath),
                              fit: BoxFit
                                  .contain, // ✅ استخدام contain لإظهار الشعار والاسم بالكامل
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= النموذج =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Email or Phone number'),
                  TextField(
                      controller: _emailController,
                      decoration: _textFieldDecoration('Type here...')),
                  const SizedBox(height: 20),

                  _buildLabel('Password'),
                  TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: _textFieldDecoration('Type here...')),
                  const SizedBox(height: 10),

                  // تذكرني ونسيت كلمة المرور
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: const Color(0xFF9B5F3B),
                                  side: const BorderSide(
                                      color: Color(0xFF40281E), width: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  onChanged: (val) =>
                                      setState(() => _rememberMe = val!))),
                          const SizedBox(width: 8),
                          const Text('Remember me',
                              style: TextStyle(
                                  color: Color(0xFF40281E),
                                  fontSize: 12,
                                  fontFamily: 'Poppins')),
                        ],
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, '/forgot_password'),
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                color: Color(0xFF40281E),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // زر تسجيل الدخول
                  Center(
                    child: SizedBox(
                      width: 198,
                      height: 59.56,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9B5F3B),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 4),
                        child: const Text('Log in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // رابط إنشاء حساب
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                      child: RichText(
                        text: const TextSpan(
                          text: 'No account? ',
                          style: TextStyle(
                              color: Color(0xFF40281E),
                              fontSize: 13,
                              fontFamily: 'Poppins'),
                          children: [
                            TextSpan(
                                text: 'Create account',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
