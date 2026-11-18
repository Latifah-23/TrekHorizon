import 'package:flutter/material.dart';
// استيراد الصفحات للتنقل
import 'reservations_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // بيانات المستخدم
  String _name = "TrekHorizon User";
  String _email = "user@example.com";
  String _phone = "+966 50 000 0000";
  String _location = "Riyadh, Saudi Arabia";

  ImageProvider _profileImage = const NetworkImage(
      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1000&auto=format&fit=crop");

  // مؤشر البار السفلي (4 لأننا في صفحة البروفايل)
  final int _selectedBottomNavIndex = 4;

  Future<void> _pickImage(bool fromCamera) async {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(fromCamera ? "Opening Camera..." : "Opening Gallery...")),
    );
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _profileImage = const NetworkImage(
          "https://images.unsplash.com/photo-1527980965255-d3b416303d12?q=80&w=1000&auto=format&fit=crop");
    });
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFFFAF4),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Change Profile Picture",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF40281E))),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF9B5F3B)),
              title: const Text("Take a photo",
                  style: TextStyle(
                      fontFamily: 'Poppins', color: Color(0xFF40281E))),
              onTap: () => _pickImage(true),
            ),
            ListTile(
              leading:
                  const Icon(Icons.photo_library, color: Color(0xFF9B5F3B)),
              title: const Text("Choose from gallery",
                  style: TextStyle(
                      fontFamily: 'Poppins', color: Color(0xFF40281E))),
              onTap: () => _pickImage(false),
            ),
          ],
        ),
      ),
    );
  }

  void _editField(
      String title, String currentValue, ValueChanged<String> onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFAF4),
        title: Text("Edit $title",
            style: const TextStyle(
                fontFamily: 'Poppins', color: Color(0xFF40281E))),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF9B5F3B))),
              hintText: "Enter new $title"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9B5F3B)),
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      String label, String value, IconData icon, Function(String) onSave) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE5BE85).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9B5F3B), size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'Poppins')),
                Text(value,
                    style: const TextStyle(
                        color: Color(0xFF40281E),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF1C5D99)),
            onPressed: () => _editField(label, value, onSave),
          ),
        ],
      ),
    );
  }

  // ================== البار السفلي (نفس التصميم في الهوم) ==================
  Widget _buildBottomNavigationBar() {
    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;
      final double itemWidth = width / 5;

      return SizedBox(
        height: 85,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // 1. الخلفية البنية
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF9B5F3B),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2))
                ],
              ),
            ),

            // 2. الدائرة المتحركة (ثابتة عند البروفايل index 4)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              top: -15,
              left: _selectedBottomNavIndex * itemWidth + (itemWidth - 70) / 2,
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5BE85),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4))
                  ],
                ),
              ),
            ),

            // 3. الأيقونات مع التنقل
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  // 0: الرئيسية
                  _buildNavItem(0, Icons.home_rounded,
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false)),

                  // 1: الخدمات
                  _buildNavItem(1, Icons.design_services_rounded,
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/services')),

                  // 2: الحجوزات (تنقل مباشر للصفحة لأننا لسنا في الهوم)
                  _buildNavItem(2, Icons.airplane_ticket_rounded,
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Scaffold(
                                  body:
                                      ReservationsScreen())))), // ملاحظة: في الهوم الحجوزات جزء من الهيكل، هنا نفتحها كصفحة

                  // 3: الخريطة
                  _buildNavItem(3, Icons.map_rounded,
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/map')),

                  // 4: البروفايل (نحن هنا)
                  _buildNavItem(4, Icons.person_rounded, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildNavItem(int index, IconData icon,
      {required VoidCallback onTap}) {
    final bool isSelected = _selectedBottomNavIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 70,
          child: Center(
            child: Icon(
              icon,
              size: isSelected ? 38 : 32,
              color: isSelected
                  ? const Color(0xFF40281E)
                  : Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        title: const Text("My Profile",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFF40281E))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Color(0xFF40281E), size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // صورة البروفايل
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFF9B5F3B), width: 3),
                      image: DecorationImage(
                          image: _profileImage, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _showImagePickerOptions,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Color(0xFF9B5F3B), shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // حقول البيانات
            _buildInfoRow("Full Name", _name, Icons.person,
                (val) => setState(() => _name = val)),
            _buildInfoRow("Email", _email, Icons.email,
                (val) => setState(() => _email = val)),
            _buildInfoRow("Phone", _phone, Icons.phone,
                (val) => setState(() => _phone = val)),
            _buildInfoRow("Location", _location, Icons.location_on,
                (val) => setState(() => _location = val)),
            const SizedBox(height: 30),
            // زر الحفظ
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Profile Updated Successfully!")));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B5F3B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text("Save Changes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // إضافة البار السفلي
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
