import 'package:flutter/material.dart';
import 'reservation_data.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final String destination;
  final String dateRange;
  final List<Map<String, String>> guests;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    this.destination = "",
    this.dateRange = "",
    this.guests = const [],
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // متغير لتحديد رقم الخيار المختار (الافتراضي هو الأول = 0)
  int _selectedPaymentIndex = 0;

  // قائمة بيانات وسائل الدفع
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'icon': Icons.credit_card,
      'text': '.... .... .... 8950',
      'isMasterCard': true,
      'isVisa': false
    },
    {
      'icon': Icons.credit_card,
      'text': '88375855007-8777',
      'isMasterCard': false,
      'isVisa': true
    },
    {
      'icon': Icons.apple,
      'text': 'Apple Pay',
      'isMasterCard': false,
      'isVisa': false
    },
    {
      'icon': Icons.account_balance_wallet,
      'text': 'Wallet',
      'isMasterCard': false,
      'isVisa': false
    },
  ];

  // --- 1. نافذة إضافة البطاقة ---
  void _showAddCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFFDF4E7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial'),
                        children: [
                          TextSpan(
                              text: 'G', style: TextStyle(color: Colors.blue)),
                          TextSpan(
                              text: 'o', style: TextStyle(color: Colors.red)),
                          TextSpan(
                              text: 'o',
                              style: TextStyle(color: Colors.orange)),
                          TextSpan(
                              text: 'g', style: TextStyle(color: Colors.blue)),
                          TextSpan(
                              text: 'l', style: TextStyle(color: Colors.green)),
                          TextSpan(
                              text: 'e', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("Pay",
                        style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF5F6368),
                            fontWeight: FontWeight.w500)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 15),
                const Text("Card Number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF40281E))),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0000 0000 0000 0000",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    prefixIcon:
                        const Icon(Icons.credit_card, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 15),
                const Text("Account Holder Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF40281E))),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Name on card",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Expiration Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF40281E))),
                          const SizedBox(height: 8),
                          TextField(
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              hintText: "MM/YY",
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Cvv",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF40281E))),
                          const SizedBox(height: 8),
                          TextField(
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "123",
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Card Added Successfully")));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F1F1F),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text("Save Card",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- 2. نافذة النجاح (Success Dialog) ---
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFFFFAF4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF40281E), width: 2),
                    color: const Color(0xFFFCEFDC),
                  ),
                  child: const Icon(Icons.check,
                      size: 40, color: Color(0xFF40281E)),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Demo Payment successful!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF40281E)),
                ),
                const SizedBox(height: 10),
                const Text(
                  "This is a simulated payment. No actual charge was made.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ReservationData.reservations.add({
                        'destination': widget.destination,
                        'dateRange': widget.dateRange,
                        'totalAmount': widget.totalAmount,
                        'people': widget.guests.length + 1,
                      });

                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B5F3B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text("Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        title: const Text("Payment Method",
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تفاصيل الحجز (تظهر فقط إذا كانت البيانات موجودة)
            if (widget.destination.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5BE85))),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Destination:",
                              style: TextStyle(color: Colors.grey)),
                          Text(widget.destination,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        ]),
                    const SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Date:",
                              style: TextStyle(color: Colors.grey)),
                          Text(widget.dateRange,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        ]),
                    const SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Guests:",
                              style: TextStyle(color: Colors.grey)),
                          Text("${widget.guests.length + 1}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        ]),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            const Text("Select Payment Method",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF40281E))),
            const SizedBox(height: 15),

            // قائمة خيارات الدفع (ديناميكية)
            Expanded(
              child: ListView.builder(
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) {
                  return _buildPaymentOption(
                    index: index,
                    icon: _paymentMethods[index]['icon'],
                    text: _paymentMethods[index]['text'],
                    isSelected: _selectedPaymentIndex == index,
                    isMasterCard: _paymentMethods[index]['isMasterCard'],
                    isVisa: _paymentMethods[index]['isVisa'],
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // زر إضافة بطاقة جديدة
            InkWell(
              onTap: () => _showAddCardDialog(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF5D4037),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text("Add New Card",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // البار السفلي
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF9B5F3B),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Total",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      Text("\$${widget.totalAmount.toStringAsFixed(0)}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => _showSuccessDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Text("Checkout",
                        style: TextStyle(
                            color: Color(0xFF9B5F3B),
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت خيار الدفع المخصص (تم التعديل ليقبل النقر وتغيير الحالة)
  Widget _buildPaymentOption({
    required int index,
    required IconData icon,
    required String text,
    required bool isSelected,
    bool isVisa = false,
    bool isMasterCard = false,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFCEFDC) : const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFF9B5F3B), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            if (isVisa)
              const Icon(Icons.payment, color: Colors.blue, size: 28)
            else if (isMasterCard)
              const Icon(Icons.credit_card, color: Colors.red, size: 28)
            else
              Icon(icon, color: Colors.black87, size: 28),
            const SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF9B5F3B) : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF9B5F3B)),
          ],
        ),
      ),
    );
  }
}
