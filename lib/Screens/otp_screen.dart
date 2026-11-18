import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  // --- دالة الانتقال للخطوة التالية ---
  void _nextStep() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // --- تصميم الحقول ---
  InputDecoration _textFieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color(0xFF9E9E9E), fontSize: 14, fontFamily: 'Poppins'),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF40281E), width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF40281E), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF9B5F3B), width: 2),
      ),
    );
  }

  // --- تصميم الزر الموحد ---
  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9B5F3B), // بني غامق
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ================== الخطوة 1: إدخال البريد/الرقم ==================
  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // صورة تعبيرية (تم تحديثها لتكون صورة محلية)
          SizedBox(
            height: 200,
            child: Image.asset(
              'assets/images/image_e2dcd3.png', // استخدم الصورة المرفقة كصورة افتراضية
              fit: BoxFit.contain,
              errorBuilder: (c, e, s) => const Icon(Icons.security,
                  size: 100, color: Color(0xFF9B5F3B)),
            ),
          ),
          const SizedBox(height: 40),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("OTP Verification",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xFF40281E))),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
                "Enter email and phone number to send one time Password",
                style: TextStyle(
                    fontSize: 14, color: Colors.grey, fontFamily: 'Poppins')),
          ),
          const SizedBox(height: 30),

          // حقل الإدخال
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color(0xFFFFFAF4),
              child: const Text("Email or Phone",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF40281E),
                      fontWeight: FontWeight.bold)),
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: _textFieldDecoration(""),
          ),

          const Spacer(),
          _buildButton("Verify", () {
            // هنا منطق إرسال الرمز
            if (_emailController.text.isNotEmpty) {
              _nextStep();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter email or phone")));
            }
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ================== الخطوة 2: إدخال الرمز (Verification Code) ==================
  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // زر الرجوع الصغير
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF40281E)),
              onPressed: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut),
            ),
          ),
          SizedBox(
            height: 180,
            // يمكنك تغيير الصورة هنا لصورة أخرى إذا توفرت
            child: Image.asset(
              'assets/images/image_e2dcd3.png',
              fit: BoxFit.contain,
              errorBuilder: (c, e, s) => const Icon(Icons.phonelink_lock,
                  size: 100, color: Color(0xFF9B5F3B)),
            ),
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Verification Code",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xFF40281E))),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
                "We have sent the verification code to your email address",
                style: TextStyle(
                    fontSize: 14, color: Colors.grey, fontFamily: 'Poppins')),
          ),
          const SizedBox(height: 30),

          TextField(
            controller: _otpController,
            textAlign: TextAlign.center,
            style: const TextStyle(letterSpacing: 5, fontSize: 18),
            keyboardType: TextInputType.number,
            decoration: _textFieldDecoration("OTP"),
          ),

          const Spacer(),
          _buildButton("Verify OTP", () {
            // هنا التحقق من الرمز
            _nextStep();
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ================== الخطوة 3: النجاح (Success) ==================
  Widget _buildStep3() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFCEFDC),
              border: Border.all(color: const Color(0xFF40281E), width: 2),
            ),
            child: const Icon(Icons.check, size: 60, color: Color(0xFF40281E)),
          ),
          const SizedBox(height: 30),
          const Text("Success!",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF40281E))),
          const SizedBox(height: 15),
          const Text(
            "Congratulations! You have been successfully authenticated",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
          ),
          const Spacer(),
          _buildButton("Continue", () {
            // الانتقال للصفحة الرئيسية
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // منع السحب اليدوي
          children: [
            _buildStep1(),
            _buildStep2(),
            _buildStep3(),
          ],
        ),
      ),
    );
  }
}
