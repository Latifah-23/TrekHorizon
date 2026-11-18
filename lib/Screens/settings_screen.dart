import 'package:flutter/material.dart';
// لاستيراد صفحة الدخول عند الخروج

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // --- متغيرات الحالة ---
  bool _isDarkMode = false;
  bool _isLocationEnabled = true;
  String _selectedLanguage = "English"; // اللغة الافتراضية

  // نصوص التطبيق حسب اللغة (مثال بسيط)
  final Map<String, Map<String, String>> _localizedStrings = {
    'English': {
      'Settings': 'Settings',
      'Language': 'Language',
      'Mode': 'Mode',
      'Location': 'Location',
      'Report a problem': 'Report a problem',
      'Log out': 'Log out',
      'Select Language': 'Select Language',
    },
    'العربية': {
      'Settings': 'الإعدادات',
      'Language': 'اللغة',
      'Mode': 'الوضع',
      'Location': 'الموقع',
      'Report a problem': 'الإبلاغ عن مشكلة',
      'Log out': 'تسجيل الخروج',
      'Select Language': 'اختر اللغة',
    },
  };

  // دالة للحصول على النص حسب اللغة الحالية
  String _getText(String key) {
    return _localizedStrings[_selectedLanguage]?[key] ?? key;
  }

  // --- دالة تغيير اللغة ---
  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          _isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFFFFAF4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getText("Select Language"),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : const Color(0xFF40281E),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Text("🇺🇸", style: TextStyle(fontSize: 24)),
              title: Text("English",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: _isDarkMode ? Colors.white : Colors.black)),
              trailing: _selectedLanguage == "English"
                  ? const Icon(Icons.check, color: Color(0xFF9B5F3B))
                  : null,
              onTap: () {
                setState(() => _selectedLanguage = "English");
                Navigator.pop(context);
                // ملاحظة: لتغيير لغة التطبيق بالكامل، يفضل استخدام مكتبة مثل easy_localization أو provider
              },
            ),
            ListTile(
              leading: const Text("🇸🇦", style: TextStyle(fontSize: 24)),
              title: Text("العربية",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: _isDarkMode ? Colors.white : Colors.black)),
              trailing: _selectedLanguage == "العربية"
                  ? const Icon(Icons.check, color: Color(0xFF9B5F3B))
                  : null,
              onTap: () {
                setState(() => _selectedLanguage = "العربية");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- ويدجت العنصر في القائمة ---
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          leading: Icon(icon,
              color: _isDarkMode
                  ? const Color(0xFFE5BE85)
                  : const Color(0xFF40281E),
              size: 26),
          title: Text(
            _getText(title),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDestructive
                  ? Colors.red
                  : (_isDarkMode ? Colors.white : const Color(0xFF40281E)),
            ),
          ),
          trailing: trailing ??
              Icon(
                  // تغيير اتجاه السهم حسب اللغة
                  _selectedLanguage == "العربية"
                      ? Icons.arrow_back_ios_new
                      : Icons.arrow_forward_ios,
                  size: 16,
                  color:
                      _isDarkMode ? Colors.white70 : const Color(0xFF40281E)),
          onTap: onTap,
        ),
        Divider(
            color: (_isDarkMode ? Colors.white : const Color(0xFF40281E))
                .withOpacity(0.1),
            height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // تحديد اتجاه الصفحة (RTL للعربية، LTR للإنجليزية)
    return Directionality(
      textDirection: _selectedLanguage == "العربية"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        // تغيير الخلفية حسب المود
        backgroundColor:
            _isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFAF4),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // زر العودة
          leading: IconButton(
            icon: Icon(
                _selectedLanguage == "العربية"
                    ? Icons.arrow_forward_ios
                    : Icons.arrow_back_ios,
                color: _isDarkMode ? Colors.white : const Color(0xFF40281E)),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.settings, color: Color(0xFFE5BE85), size: 24),
              const SizedBox(width: 8),
              Text(
                _getText("Settings"),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : const Color(0xFF40281E),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _isDarkMode
                      ? const Color(0xFF1E1E1E)
                      : const Color(0xFFF8EFE6),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                      color: const Color(0xFFE5BE85).withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    // 1. اللغة
                    _buildSettingItem(
                      icon: Icons.language,
                      title: "Language",
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_selectedLanguage,
                              style: TextStyle(
                                  color: _isDarkMode
                                      ? Colors.white70
                                      : Colors.grey,
                                  fontSize: 14)),
                          const SizedBox(width: 8),
                          Icon(
                              _selectedLanguage == "العربية"
                                  ? Icons.arrow_back_ios_new
                                  : Icons.arrow_forward_ios,
                              size: 16,
                              color: _isDarkMode
                                  ? Colors.white70
                                  : const Color(0xFF40281E)),
                        ],
                      ),
                      onTap: _showLanguageBottomSheet,
                    ),

                    // 2. الوضع (Dark/Light Mode)
                    _buildSettingItem(
                      icon: _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      title: "Mode",
                      trailing: Switch(
                        value: _isDarkMode,
                        activeThumbColor: const Color(0xFF9B5F3B),
                        onChanged: (val) {
                          setState(() => _isDarkMode = val);
                        },
                      ),
                    ),

                    // 3. الموقع (Location)
                    _buildSettingItem(
                      icon: Icons.location_on,
                      title: "Location",
                      trailing: Switch(
                        value: _isLocationEnabled,
                        activeThumbColor: const Color(0xFF9B5F3B),
                        onChanged: (val) {
                          setState(() => _isLocationEnabled = val);
                        },
                      ),
                    ),

                    // 4. الإبلاغ عن مشكلة
                    _buildSettingItem(
                      icon: Icons.flag_outlined,
                      title: "Report a problem",
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(_selectedLanguage == "العربية"
                                  ? "هذه الميزة قادمة قريباً!"
                                  : "Report feature coming soon!")),
                        );
                      },
                    ),

                    // 5. تسجيل الخروج
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.logout,
                          color: _isDarkMode
                              ? Colors.redAccent
                              : const Color(0xFF40281E),
                          size: 26),
                      title: Text(
                        _getText("Log out"),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _isDarkMode
                              ? Colors.redAccent
                              : const Color(0xFF40281E),
                        ),
                      ),
                      trailing: Icon(
                          _selectedLanguage == "العربية"
                              ? Icons.arrow_back
                              : Icons.arrow_forward,
                          color: _isDarkMode
                              ? Colors.redAccent
                              : const Color(0xFF40281E)),
                      onTap: () {
                        // العودة لصفحة الدخول
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
