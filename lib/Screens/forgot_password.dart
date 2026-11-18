import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // متحكمات النصوص
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isNewPassVisible = false;
  bool _isConfirmPassVisible = false;

  // تصميم الحقول
  InputDecoration _textFieldDecoration(
      String hintText, bool isVisible, VoidCallback toggleVisibility) {
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
      suffixIcon: IconButton(
        icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF9B5F3B)),
        onPressed: toggleVisibility,
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.play_arrow,
              size: 14, color: Color(0xFF9B5F3B)), // سهم صغير
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Color(0xFF40281E),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleResetPassword() {
    // هنا يتم وضع منطق تغيير كلمة المرور
    if (_newPassController.text.isEmpty ||
        _confirmPassController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all fields")));
      return;
    }
    if (_newPassController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    // نجاح العملية
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password Reset Successfully!")));
    Navigator.pop(context); // العودة لصفحة الدخول
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // --- صورة توضيحية (استبدل الرابط بصورتك المحلية إذا توفرت) ---
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                // صورة مؤقتة من النت تشبه الرسمة
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/6195/6195699.png',
                  fit: BoxFit.contain,
                  errorBuilder: (c, e, s) => const Icon(Icons.lock_reset,
                      size: 100, color: Color(0xFF9B5F3B)),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Forgot Password",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF40281E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Reset your Password and make strong.",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: const Color(0xFF40281E).withOpacity(0.6),
              ),
            ),

            const SizedBox(height: 25),

            // --- شروط كلمة المرور ---
            const Text(
              "Password Requirement:",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF40281E),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFFCEFDC)
                    .withOpacity(0.5), // خلفية بيج فاتحة للشروط
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildRequirementItem("At least 8 Characters"),
                  _buildRequirementItem("No Part Of your Username"),
                  _buildRequirementItem(
                      "Your Password Cannot Be any your last 4 Passwords."),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- حقول الإدخال ---
            TextField(
              controller: _newPassController,
              obscureText: !_isNewPassVisible,
              decoration:
                  _textFieldDecoration("New Password", _isNewPassVisible, () {
                setState(() => _isNewPassVisible = !_isNewPassVisible);
              }),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _confirmPassController,
              obscureText: !_isConfirmPassVisible,
              decoration: _textFieldDecoration(
                  "Re-enter Password", _isConfirmPassVisible, () {
                setState(() => _isConfirmPassVisible = !_isConfirmPassVisible);
              }),
            ),

            const SizedBox(height: 30),

            // --- زر إعادة التعيين ---
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _handleResetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9B5F3B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                ),
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- زر العودة ---
            Center(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_ios,
                        size: 14, color: Color(0xFF40281E)),
                    const SizedBox(width: 5),
                    RichText(
                      text: const TextSpan(
                        text: 'Back to ',
                        style: TextStyle(
                            color: Color(0xFF40281E),
                            fontSize: 14,
                            fontFamily: 'Poppins'),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9B5F3B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
