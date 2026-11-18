import 'package:flutter/material.dart';
import '../db/db_helper.dart'; // استيراد قاعدة البيانات

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final String _assetImagePath = "assets/images/rlogo-bg.png";

  bool _agreedToTerms = false;

  // متحكمات النصوص
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // تصميم الحقول
  InputDecoration _textFieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 13,
        fontFamily: 'Poppins',
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF40281E), width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF40281E), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF9B5F3B), width: 2),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF40281E),
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: _textFieldDecoration('Type here...'),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // --- دالة التسجيل ---
  void _handleSignUp() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all fields")));
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please agree to Terms & Privacy")));
      return;
    }

    // حفظ المستخدم
    Map<String, dynamic> newUser = {
      'email': _emailController.text,
      'password': _passwordController.text,
      'name': _nameController.text,
      'phone': _phoneController.text,
    };

    bool success = await DBHelper().registerUser(newUser);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account Created! Welcome.")));

      // الانتقال للصفحة الرئيسية وحذف الصفحات السابقة من المكدس
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration Failed! Email might be taken.")));
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
                  // 1. الخلفية البنية
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 230,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF9B5F3B),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(500, 110),
                        ),
                      ),
                    ),
                  ),

                  // 2. اللوقو
                  Positioned(
                    top: 150,
                    child: Container(
                      width: 150,
                      height: 160,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFFAF4),
                        shape: OvalBorder(),
                      ),
                      child: Center(
                        child: Container(
                          width: 145,
                          height: 145,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_assetImagePath),
                              fit: BoxFit.contain,
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
                  _buildInputField('Email', _emailController),
                  _buildInputField('Phone number', _phoneController),
                  _buildInputField('Full Name', _nameController),
                  _buildInputField('Password', _passwordController,
                      isPassword: true),
                  _buildInputField(
                      'Confirm Password', _confirmPasswordController,
                      isPassword: true),

                  // --- الشروط والأحكام ---
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _agreedToTerms,
                          activeColor: const Color(0xFF9B5F3B),
                          side: const BorderSide(
                              color: Color(0xFF40281E), width: 1.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (val) {
                            setState(() {
                              _agreedToTerms = val!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Text(
                            'I agree to the ',
                            style: TextStyle(
                                color: Color(0xFF40281E),
                                fontSize: 12,
                                fontFamily: 'Poppins'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/privacy_policy');
                            },
                            child: const Text(
                              'Terms & Privacy',
                              style: TextStyle(
                                color: Color(0xFF9B5F3B),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // --- ✅ زر إنشاء الحساب (موجود هنا) ---
                  Center(
                    child: SizedBox(
                      width: 198,
                      height: 59.56,
                      child: ElevatedButton(
                        onPressed: _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9B5F3B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- زر العودة لتسجيل الدخول ---
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: Color(0xFF40281E),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
