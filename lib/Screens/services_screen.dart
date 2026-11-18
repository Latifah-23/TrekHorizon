import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // للتحكم في حالة القوائم (مفتوحة أم مغلقة)
  final Map<String, bool> _expandedState = {
    'Discovery': false,
    'Information': false,
    'Booking': false,
    'Safety': false,
    'Logistics': false,
    // القوائم الفرعية داخل اللوجستيات
    'Transportation': false,
    'Equipment': false,
  };

  // دالة لتبديل حالة القائمة
  void _toggleExpand(String key) {
    setState(() {
      _expandedState[key] = !(_expandedState[key] ?? false);
    });
  }

  // --- 1. ويدجت الزر الرئيسي (المستوى الأول) ---
  Widget _buildMainExpansionTile({
    required String title,
    required String key,
    required List<Widget> children,
  }) {
    bool isExpanded = _expandedState[key] ?? false;
    return Column(
      children: [
        GestureDetector(
          onTap: () => _toggleExpand(key),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFF8EFE6), // لون بيج فاتح
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: const Color(0xFFE5BE85).withOpacity(0.8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF40281E),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF40281E),
                ),
              ],
            ),
          ),
        ),
        // المحتوى المخفي (يظهر بحركة ناعمة)
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(children: children),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  // --- 2. ويدجت العنصر الفرعي البسيط (نهاية القائمة) ---
  Widget _buildSubItem(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 35),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFCEFDC), // لون أغمق قليلاً للتمييز
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5BE85).withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: Color(0xFF40281E),
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // --- 3. ويدجت القائمة الفرعية المتداخلة (للخدمات اللوجستية) ---
  Widget _buildNestedExpansionTile({
    required String title,
    required String key,
    required List<String> items,
  }) {
    bool isExpanded = _expandedState[key] ?? false;
    return Column(
      children: [
        GestureDetector(
          onTap: () => _toggleExpand(key),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFE5BE85)
                  .withOpacity(0.4), // لون مميز للقوائم الفرعية
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color(0xFF9B5F3B).withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF40281E),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF40281E),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Column(
              children: items.map((item) => _buildSubItem(item)).toList(),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // مسافة في الأسفل لتجنب تغطية البار السفلي للمحتوى
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "Services",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF40281E),
              ),
            ),
          ),

          // 1. Discovery
          _buildMainExpansionTile(
            title: 'Discovery',
            key: 'Discovery',
            children: [
              _buildSubItem('Adventure Trails & Routes'),
              _buildSubItem('Emergency Services & Hospitals'),
              _buildSubItem('Restaurants, Cafes'),
              _buildSubItem('Fuel Stations'),
              _buildSubItem('Service Centers'),
              _buildSubItem('Equipment & Supply Stores'),
              _buildSubItem('Designated Camping Spots'),
              _buildSubItem('Water Refill Points'),
            ],
          ),

          // 2. Information
          _buildMainExpansionTile(
            title: 'Information',
            key: 'Information',
            children: [
              _buildSubItem('Real-Time Weather and Climate Reports'),
              _buildSubItem('Best Seasons for Visiting'),
              _buildSubItem('Expected Crowd Levels'),
              _buildSubItem('Local Camping Rules'),
            ],
          ),

          // 3. Booking
          _buildMainExpansionTile(
            title: 'Booking',
            key: 'Booking',
            children: [
              _buildSubItem('Trips'),
              _buildSubItem('Certified Camping Site Reservation'),
              _buildSubItem('All-Inclusive Adventure Packages'),
              _buildSubItem('Training and Qualification'),
            ],
          ),

          // 4. Safety
          _buildMainExpansionTile(
            title: 'Safety',
            key: 'Safety',
            children: [
              _buildSubItem('Safety and Risk Assessments'),
              _buildSubItem('Trip Tracking'),
              _buildSubItem('Emergency and Support Contact'),
              _buildSubItem('Guide Evaluation'),
              _buildSubItem('Safety instructions'),
            ],
          ),

          // 5. Logistics (النقطة المميزة بفرعين)
          _buildMainExpansionTile(
            title: 'Logistics',
            key: 'Logistics',
            children: [
              // الفرع الأول: النقل
              _buildNestedExpansionTile(
                title: 'Transportation and Transit',
                key: 'Transportation',
                items: [
                  'Shuttle Services',
                  'Private Drivers',
                  'Airport Transfers',
                ],
              ),
              // الفرع الثاني: تأجير المعدات
              _buildNestedExpansionTile(
                title: 'Equipment Rental',
                key: 'Equipment',
                items: [
                  '4x4 Vehicle Rental',
                  'Quad Bike',
                  'ATV Rental',
                  'Horse Rental',
                  'Camel Rental',
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
