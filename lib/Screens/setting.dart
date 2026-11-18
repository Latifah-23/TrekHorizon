import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // --- متغيرات الحالة ---
  bool _isDarkMode = false;
  bool _isLocationEnabled = true;
  String _selectedLanguage = "English";

  // نصوص التطبيق حسب اللغة (محاكاة للترجمة)
  final Map<String, Map<String, String>> _localizedStrings = {
    'English': {
      'Settings': 'Settings',
      'Language': 'Language',
      'Mode': 'Mode',
      'Location': 'Location',
      'Report a problem': 'Report a problem',
      'Log out': 'Log out',
      'Select Language': 'Select Language',
      'Dark Mode': 'Dark Mode',
      'Light Mode': 'Light Mode',
    },
    'العربية': {
      'Settings': 'الإعدادات',
      'Language': 'اللغة',
      'Mode': 'الوضع',
      'Location': 'الموقع',
      'Report a problem': 'الإبلاغ عن مشكلة',
      'Log out': 'تسجيل الخروج',
      'Select Language': 'اختر اللغة',
      'Dark Mode': 'الوضع الليلي',
      'Light Mode': 'الوضع النهاري',
    },
  };

  // دالة مساعدة لجلب النص المترجم
  String _tr(String key) {
    return _localizedStrings[_selectedLanguage]?[key] ?? key;
  }

  // --- نافذة اختيار اللغة ---
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
              _tr("Select Language"),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : const Color(0xFF40281E),
              ),
            ),
            const SizedBox(height: 20),
            _buildLanguageOption("English", "🇺🇸"),
            _buildLanguageOption("العربية", "🇸🇦"),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, String flag) {
    bool isSelected = _selectedLanguage == language;
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(
        language,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: _isDarkMode ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing:
          isSelected ? const Icon(Icons.check, color: Color(0xFF9B5F3B)) : null,
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
        Navigator.pop(context);
      },
    );
  }

  // --- عنصر القائمة ---
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    Color textColor = isDestructive
        ? Colors.red
        : (_isDarkMode ? Colors.white : const Color(0xFF40281E));

    Color iconColor =
        _isDarkMode ? const Color(0xFFE5BE85) : const Color(0xFF40281E);

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: Icon(icon, color: iconColor, size: 24),
          title: Text(
            _tr(title),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          trailing: trailing ??
              Icon(
                  // عكس اتجاه السهم في العربية
                  _selectedLanguage == "العربية"
                      ? Icons.arrow_back_ios_new
                      : Icons.arrow_forward_ios,
                  size: 16,
                  color: textColor.withOpacity(0.7)),
          onTap: onTap,
        ),
        Divider(
          color: (_isDarkMode ? Colors.white : const Color(0xFF40281E))
              .withOpacity(0.1),
          height: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // استخدام Directionality لقلب التطبيق عند اختيار العربية
    return Directionality(
      textDirection: _selectedLanguage == "العربية"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFAF4),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          // زر العودة
          leading: IconButton(
            icon: Icon(
                _selectedLanguage == "العربية"
                    ? Icons.arrow_forward_ios
                    : Icons.arrow_back_ios,
                color: _isDarkMode ? Colors.white : const Color(0xFF40281E)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.settings, color: Color(0xFFE5BE85), size: 24),
              const SizedBox(width: 8),
              Text(
                _tr("Settings"),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
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
              // الحاوية الرئيسية (Card)
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
                                      ? Colors.white54
                                      : Colors.grey[600],
                                  fontFamily: 'Poppins')),
                          const SizedBox(width: 8),
                          Icon(
                              _selectedLanguage == "العربية"
                                  ? Icons.arrow_back_ios_new
                                  : Icons.arrow_forward_ios,
                              size: 14,
                              color: _isDarkMode
                                  ? Colors.white54
                                  : const Color(0xFF40281E)),
                        ],
                      ),
                      onTap: _showLanguageBottomSheet,
                    ),

                    // 2. الوضع (Mode)
                    _buildSettingItem(
                      icon: _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      title: "Mode",
                      trailing: Switch(
                        value: _isDarkMode,
                        activeThumbColor: const Color(0xFF9B5F3B),
                        onChanged: (val) {
                          setState(() {
                            _isDarkMode = val;
                          });
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
                          setState(() {
                            _isLocationEnabled = val;
                          });
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
                                  ? "سيتم تفعيل هذه الميزة قريباً"
                                  : "Feature coming soon!")),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // 5. تسجيل الخروج
                    _buildSettingItem(
                      icon: Icons.logout,
                      title: "Log out",
                      isDestructive: true, // لون أحمر
                      trailing: Icon(Icons.exit_to_app,
                          color: _isDarkMode ? Colors.redAccent : Colors.red),
                      onTap: () {
                        // العودة لصفحة الدخول وحذف كل الصفحات السابقة من المكدس
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
