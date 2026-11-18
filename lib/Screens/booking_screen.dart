import 'package:flutter/material.dart';
import 'payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final String destinationName;
  final String pricePerPerson;

  const BookingScreen({
    super.key,
    required this.destinationName,
    required this.pricePerPerson,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // متغيرات الحجز
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;

  final TextEditingController _peopleController =
      TextEditingController(text: "1");
  final List<Map<String, TextEditingController>> _guestsControllers = [];

  // تحديث قائمة المرافقين بناءً على العدد
  void _updateGuestFields(int count) {
    _guestsControllers.clear();
    // إذا كان العدد أكثر من 1، نضيف حقول للمرافقين (العدد - 1)
    // لأن الشخص الأساسي هو صاحب الحجز
    if (count > 1) {
      for (int i = 0; i < count - 1; i++) {
        _guestsControllers.add({
          'name': TextEditingController(),
          'age': TextEditingController(),
        });
      }
    }
    setState(() {});
  }

  // حساب السعر الإجمالي (تقريبي)
  double get _totalPrice {
    // استخراج الرقم من نص السعر (مثلاً $250 -> 250)
    String cleanPrice =
        widget.pricePerPerson.replaceAll(RegExp(r'[^0-9.]'), '');
    double price = double.tryParse(cleanPrice) ?? 0;
    int people = int.tryParse(_peopleController.text) ?? 1;
    int days = 1;
    if (_selectedStartDay != null && _selectedEndDay != null) {
      days = _selectedEndDay!.difference(_selectedStartDay!).inDays + 1;
    }
    return price * people * days;
  }

  // ويدجت التقويم البسيط (Custom Simple Calendar)
  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCEFDC).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5BE85)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Color(0xFF40281E)),
                onPressed: () => setState(() => _focusedDay =
                    DateTime(_focusedDay.year, _focusedDay.month - 1)),
              ),
              Text(
                "${_focusedDay.year} - ${_focusedDay.month}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF40281E)),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Color(0xFF40281E)),
                onPressed: () => setState(() => _focusedDay =
                    DateTime(_focusedDay.year, _focusedDay.month + 1)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7),
            itemCount: DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day,
            itemBuilder: (context, index) {
              final day =
                  DateTime(_focusedDay.year, _focusedDay.month, index + 1);
              bool isSelected = false;
              bool isRange = false;

              if (_selectedStartDay != null &&
                  isSameDay(day, _selectedStartDay)) {
                isSelected = true;
              }
              if (_selectedEndDay != null && isSameDay(day, _selectedEndDay)) {
                isSelected = true;
              }
              if (_selectedStartDay != null &&
                  _selectedEndDay != null &&
                  day.isAfter(_selectedStartDay!) &&
                  day.isBefore(_selectedEndDay!)) {
                isRange = true;
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selectedStartDay == null ||
                        (_selectedStartDay != null &&
                            _selectedEndDay != null)) {
                      _selectedStartDay = day;
                      _selectedEndDay = null;
                    } else if (day.isAfter(_selectedStartDay!)) {
                      _selectedEndDay = day;
                    } else {
                      _selectedStartDay = day;
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF9B5F3B)
                        : (isRange ? const Color(0xFFE5BE85) : null),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF40281E),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        title: const Text("Booking",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xFF40281E))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF40281E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. التقويم
            _buildCalendar(),
            const SizedBox(height: 20),

            // 2. التواريخ المختارة
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Start Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF40281E))),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(_selectedStartDay != null
                            ? "${_selectedStartDay!.day}/${_selectedStartDay!.month}/${_selectedStartDay!.year}"
                            : "Select Date"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("End Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF40281E))),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(_selectedEndDay != null
                            ? "${_selectedEndDay!.day}/${_selectedEndDay!.month}/${_selectedEndDay!.year}"
                            : "Select Date"),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 3. عدد الأشخاص
            const Text("Number of people",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF40281E))),
            const SizedBox(height: 5),
            TextField(
              controller: _peopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              onChanged: (val) {
                int count = int.tryParse(val) ?? 1;
                _updateGuestFields(count);
              },
            ),

            // 4. بيانات المرافقين (ديناميكي)
            if (_guestsControllers.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text("Guest Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF9B5F3B))),
              const SizedBox(height: 10),
              ...List.generate(_guestsControllers.length, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE5BE85)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Guest ${index + 1}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _guestsControllers[index]['name'],
                              decoration: const InputDecoration(
                                  hintText: "Name",
                                  isDense: true,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _guestsControllers[index]['age'],
                              decoration: const InputDecoration(
                                  hintText: "Age",
                                  isDense: true,
                                  border: OutlineInputBorder()),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],

            const SizedBox(height: 30),

            // 5. ملخص السعر وزر الدفع
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF8EFE6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: \$${_totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF40281E))),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedStartDay == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please select dates")));
                        return;
                      }
                      // الانتقال لصفحة الدفع مع تمرير البيانات
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            totalAmount: _totalPrice,
                            destination: widget.destinationName,
                            dateRange:
                                "${_selectedStartDay!.day}/${_selectedStartDay!.month}/${_selectedStartDay!.year} - "
                                "${(_selectedEndDay ?? _selectedStartDay!).day}/${(_selectedEndDay ?? _selectedStartDay!).month}/${(_selectedEndDay ?? _selectedStartDay!).year}",
                            guests: _guestsControllers
                                .map((guest) => {
                                      'name': guest['name']!.text,
                                      'age': guest['age']!.text,
                                    })
                                .toList(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B5F3B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Payment",
                        style: TextStyle(color: Colors.white)),
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
