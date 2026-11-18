import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // متغير لتخزين الرصيد الحالي (قابل للتعديل)
  double _currentBalance = 250.00;

  // تحكم في حقل إدخال المبلغ
  final TextEditingController _amountController = TextEditingController();

  // قائمة المعاملات (أصبحت غير ثابتة const لنتمكن من الإضافة إليها)
  final List<Map<String, String>> _transactions = [
    {'desc': 'Payment to Digital Upgrade', 'type': 'out', 'amount': '120.00'},
    {'desc': 'Withdrawal from ATM', 'type': 'out', 'amount': '130.00'},
    {'desc': 'Cashback Reward', 'type': 'in', 'amount': '500.00'},
    {'desc': 'Order #DR12345', 'type': 'out', 'amount': '1000.00'},
    {'desc': 'Recharge (Mobile Credit)', 'type': 'in', 'amount': '1120.00'},
  ];

  // --- دالة لإظهار نافذة إضافة الأموال ---
  void _showAddFundsDialog() {
    _amountController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFFAF4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Funds',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF40281E),
                ),
              ),
              const SizedBox(height: 15),
              const Text('Select Payment Method:'),
              const SizedBox(height: 10),
              // خيارات الدفع الوهمية
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _paymentMethodIcon(Icons.credit_card, "Card"),
                  _paymentMethodIcon(Icons.apple, "Apple Pay"),
                  _paymentMethodIcon(Icons.account_balance, "Bank"),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B5F3B),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    if (_amountController.text.isNotEmpty) {
                      _processTransaction(
                          double.parse(_amountController.text), 'in');
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Confirm Deposit',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- دالة لإظهار نافذة سحب الأموال ---
  void _showWithdrawDialog() {
    _amountController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFFAF4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Withdraw Funds',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF40281E),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount to withdraw',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40281E),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    if (_amountController.text.isNotEmpty) {
                      double amount = double.parse(_amountController.text);
                      if (amount > _currentBalance) {
                        // تنبيه في حال عدم كفاية الرصيد
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Insufficient Balance!")),
                        );
                      } else {
                        _processTransaction(amount, 'out');
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Confirm Withdrawal',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- دالة معالجة العملية وتحديث الواجهة ---
  void _processTransaction(double amount, String type) {
    setState(() {
      if (type == 'in') {
        _currentBalance += amount;
        _transactions.insert(0, {
          'desc': 'Top Up Funds',
          'type': 'in',
          'amount': amount.toStringAsFixed(2)
        });
      } else {
        _currentBalance -= amount;
        _transactions.insert(0, {
          'desc': 'Withdrawal to Bank',
          'type': 'out',
          'amount': amount.toStringAsFixed(2)
        });
      }
    });
  }

  // أيقونة مساعدة للنافذة المنبثقة
  Widget _paymentMethodIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFFF8EAD8),
          child: Icon(icon, color: const Color(0xFF9B5F3B)),
        ),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF40281E))),
      ],
    );
  }

  // ويدجت مُساعد لإنشاء عنصر المعاملة
  Widget _buildTransactionItem(
      {required String desc, required String type, required String amount}) {
    final bool isCredit = type == 'in';
    final Color amountColor = isCredit ? Colors.green.shade700 : Colors.black;
    final String sign = isCredit ? '+' : '-';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      desc,
                      style: const TextStyle(
                        color: Color(0xE540281E),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isCredit ? 'Credit' : 'Debit',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$sign\$$amount',
                style: TextStyle(
                  color: amountColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0x7FA6A6A6), height: 1, thickness: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Wallet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF40281E),
            fontSize: 25,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF40281E)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),

          // 1. بطاقة الرصيد الحالي (تم ربطها بالمتغير _currentBalance)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0),
            child: Container(
              width: double.infinity,
              height: 184,
              decoration: BoxDecoration(
                color: const Color(0xFF9B5F3B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFFAF4), width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 16,
                    offset: Offset(8, 10),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(Icons.account_balance_wallet,
                        color: Colors.white.withOpacity(0.5), size: 24),
                  ),
                  const Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      'Current Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Center(
                    // تحديث الرصيد ليقرأ من المتغير
                    child: Text(
                      '\$${_currentBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 4.50,
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 20,
                    bottom: 20,
                    child: Text(
                      '06/24',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Padding(
            padding: EdgeInsets.only(left: 40.0, bottom: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Transactions :',
                style: TextStyle(
                  color: Color(0xFF40281E),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          // 3. قائمة المعاملات
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 27),
              decoration: BoxDecoration(
                color: const Color(0xFFF8EAD8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0x7FA6A6A6), width: 2),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10,
                      offset: Offset(0, 4)),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final tx = _transactions[index];
                  return _buildTransactionItem(
                    desc: tx['desc']!,
                    type: tx['type']!,
                    amount: tx['amount']!,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 4. أزرار إضافة/سحب الأموال المفعلة
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionTextButton(
                  title: 'Add funds',
                  onTap: _showAddFundsDialog, // استدعاء دالة الإضافة
                ),
                _buildActionTextButton(
                  title: 'Withdraw',
                  onTap: _showWithdrawDialog, // استدعاء دالة السحب
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildActionTextButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment.center,
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF40281E),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
