import 'package:flutter/material.dart';
import 'reservation_data.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  // التبويب المختار حالياً (0: All, 1: New, 2: Visited)
  int _selectedFilterIndex = 0;

  // قائمة الفلاتر العلوية
  final List<String> _filters = ["All", "New Reservations", "Visited Places"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- شريط الفلاتر العلوي (Tabs) ---
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _filters.length,
            itemBuilder: (context, index) {
              bool isSelected = _selectedFilterIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFilterIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFE5BE85)
                        : const Color(0xFFE5BE85).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    // إضافة ظل خفيف للزر المحدد ليطابق الصورة
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2))
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _filters[index],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF40281E),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // --- المحتوى (قائمة الحجوزات) ---
        Expanded(
          child: ReservationData.reservations.isNotEmpty &&
                  _selectedFilterIndex != 2
              ? ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: ReservationData.reservations.length,
                  itemBuilder: (context, index) {
                    final reservation = ReservationData.reservations[index];

                    return Card(
                      color: const Color(0xFFFCEFDC),
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: const Icon(
                          Icons.airplane_ticket_outlined,
                          color: Color(0xFF9B5F3B),
                        ),
                        title: Text(
                          reservation['destination'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF40281E),
                          ),
                        ),
                        subtitle: Text(
                          "${reservation['dateRange']}\n"
                          "Guests: ${reservation['people']}\n"
                          "Demo booking confirmed",
                        ),
                        trailing: Text(
                          "\$${reservation['totalAmount']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // أيقونة معبرة عن عدم وجود حجوزات
                      Icon(
                        Icons.airplane_ticket_outlined,
                        size: 80,
                        color: const Color(0xFF9B5F3B).withOpacity(0.3),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "No reservations yet",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF40281E),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Your booked trips will appear here.",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: const Color(0xFF40281E).withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
