import 'package:flutter/material.dart';

// استيراد صفحات التطبيق للربط
// ✅ استيراد صفحة الإعدادات

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // ويدجت مخصص لتصميم عناصر القائمة
  Widget _buildCustomDrawerItem(
      {required BuildContext context,
      required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFB98D63), // لون الخلفية (بني فاتح)
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon,
            color: const Color(0xFF40281E), size: 22), // لون الأيقونة
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Color(0xFF40281E), // لون النص
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          Navigator.pop(context); // إغلاق القائمة أولاً
          onTap(); // تنفيذ الانتقال
        },
        dense: true,
        visualDensity: const VisualDensity(vertical: -1),
      ),
    );
  }

  // دالة مساعدة للتحقق والانتقال (لمنع فتح نفس الصفحة مرتين)
  void _navigate(BuildContext context, String routeName) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != routeName) {
      if (routeName == '/home') {
        Navigator.pushReplacementNamed(context, routeName);
      } else {
        Navigator.pushNamed(context, routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // لون الخلفية الرئيسي للقائمة (بني غامق)
    return Drawer(
      backgroundColor: const Color(0xFF9B5F3B),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- زر الإغلاق (X) ---
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 24, bottom: 30),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCFAC87), // لون الدائرة
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Color(0xFF40281E)),
                ),
              ),
            ),

            // --- قائمة العناصر ---
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildCustomDrawerItem(
                    context: context,
                    title: 'List of Trip places',
                    icon: Icons.luggage,
                    onTap: () => _navigate(context, '/home'),
                  ),
                  _buildCustomDrawerItem(
                    context: context,
                    title: 'Notifications',
                    icon: Icons.notifications_outlined,
                    onTap: () => _navigate(context, '/notifications'),
                  ),
                  _buildCustomDrawerItem(
                    context: context,
                    title: 'Wallet',
                    icon: Icons.account_balance_wallet_outlined,
                    onTap: () => _navigate(context, '/wallet'),
                  ),
                  _buildCustomDrawerItem(
                    context: context,
                    title: 'Customer Support',
                    icon: Icons.support_agent,
                    onTap: () => _navigate(context, '/customer_service'),
                  ),
                  _buildCustomDrawerItem(
                    context: context,
                    title: 'Privacy and Policy',
                    icon: Icons.lock_outline,
                    onTap: () => _navigate(context, '/privacy_policy'),
                  ),
                  _buildCustomDrawerItem(
                    context: context,
                    title: 'Terms and Conditions',
                    icon: Icons.description_outlined,
                    onTap: () =>
                        _navigate(context, '/privacy_policy'), // رابط مؤقت
                  ),

                  // --- زر الإعدادات (تم ربطه بصفحة Setting) ---
                  _buildCustomDrawerItem(
                    context: context,
                    title: 'Setting',
                    icon: Icons.settings_outlined,
                    onTap: () => _navigate(
                        context, '/settings'), // ✅ الانتقال لصفحة الإعدادات
                  ),
                ],
              ),
            ),

            // --- زر المساعدة في الأسفل ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: InkWell(
                onTap: () {
                  // كود زر المساعدة مستقبلاً
                },
                child: const Row(
                  children: [
                    Icon(Icons.help_outline, color: Color(0xFFCFAC87)),
                    SizedBox(width: 8),
                    Text(
                      'Help',
                      style: TextStyle(
                        color: Color(0xFFCFAC87),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
