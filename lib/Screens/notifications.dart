import 'package:flutter/material.dart';
import '../db/db_helper.dart'; // استيراد قاعدة البيانات لجلب الإشعارات

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // حالة أزرار التبديل
  bool _emailEnabled = true;
  bool _smsEnabled = true;
  bool _whatsappEnabled = true;

  // قائمة لتخزين الإشعارات القادمة من قاعدة البيانات
  List<Map<String, String>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  // دالة لجلب الإشعارات
  void _loadNotifications() async {
    final data = await DBHelper().getNotifications();
    setState(() {
      _notifications = data;
    });
  }

  // ويدجت لبناء صف التفضيلات
  Widget _buildPreferenceRow(
      String title, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF40281E), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF40281E),
              ),
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: const Color(0xFFFCEFDC),
              activeTrackColor: const Color(0xFFE5BE85),
              inactiveThumbColor: const Color(0xFF9B5F3B),
              inactiveTrackColor: const Color(0xFFFCEFDC),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFF40281E),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ✅ التعديل هنا: إضافة زر العودة بدلاً من زر القائمة
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF40281E)),
          onPressed: () {
            Navigator.pop(context); // العودة للصفحة السابقة
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF40281E)),
            onPressed: () {},
          ),
        ],
      ),
      // drawer: const AppDrawer(), // تم إخفاء القائمة الجانبية لأننا وضعنا زر العودة
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= قسم الإشعارات الجديدة =================
            if (_notifications.isNotEmpty) ...[
              const Text(
                "Recent Activity",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF40281E),
                ),
              ),
              const SizedBox(height: 10),
              // عرض قائمة الإشعارات
              ..._notifications.map((notif) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color(0xFFE5BE85).withOpacity(0.5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.notifications_active,
                          color: Color(0xFF9B5F3B), size: 28),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notif['title']!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF40281E),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              notif['body']!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: Color(0xFF5D4037),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${notif['date']} • ${notif['time']}",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 30),
            ] else ...[
              // حالة عدم وجود إشعارات
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.notifications_off_outlined,
                        size: 40, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("No new notifications",
                        style: TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins')),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],

            // ================= قسم الإعدادات =================
            const Text(
              "Settings",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF40281E),
              ),
            ),
            const SizedBox(height: 10),

            // البطاقة الكبيرة للإعدادات
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8EFE6),
                borderRadius: BorderRadius.circular(15),
                border:
                    Border.all(color: const Color(0xFFE5BE85).withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Application Notifications",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF40281E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Opening System Settings...")),
                      );
                    },
                    child: const Text(
                      "Open notification Settings",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xFF1C5D99),
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Never miss a message, click the link below to easily enable notifications from us",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF40281E),
                      height: 1.4,
                    ),
                  ),
                  const Divider(height: 30, color: Color(0x4440281E)),
                  const Text(
                    "Marketing Preferences",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF40281E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPreferenceRow("Email", Icons.email, _emailEnabled,
                      (val) {
                    setState(() => _emailEnabled = val);
                  }),
                  _buildPreferenceRow("SMS", Icons.sms, _smsEnabled, (val) {
                    setState(() => _smsEnabled = val);
                  }),
                  _buildPreferenceRow("WhatsApp", Icons.chat, _whatsappEnabled,
                      (val) {
                    setState(() => _whatsappEnabled = val);
                  }),
                  const SizedBox(height: 15),
                  const Text(
                    "Opting out halts promotional messages, but you'll still receive important service updates.",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
