import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  // محتوى سياسة خصوصية وهمية (يجب استبداله بالنص الحقيقي)
  final String _policyText = """
**1. Introduction**
By using the Camping App service, you consent to the data practices described in this policy. Our goal is to ensure full transparency regarding the collection, use, and sharing of your personal data.

**2. Data Collection**
We collect various types of information for several purposes to provide and improve our service to you. This includes:
  - Personal identification data (Name, Email, Phone Number).
  - Location data for trip planning and nearby recommendations (collected only with explicit consent).
  - Usage data (IP address, browser type, pages visited).

**3. Use of Data**
The Camping App uses the collected data for:
  - Providing and maintaining the Service.
  - Notifying you about changes to our Service.
  - Providing customer support and responding to inquiries (via AI or human agent).
  - Monitoring the usage of the Service for performance analysis.
  - To prevent and address technical issues and security breaches.

**4. Data Security**
The security of your data is important to us, but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security. We implement strong encryption and access controls.

**5. Sharing Your Data**
We do not sell your personal data. We may share information with third-party service providers (such as payment processors or map services) only to the extent necessary to perform tasks on our behalf.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Privacy and Policy',
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. بطاقة الملخص (Summary Card)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8EAD8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBDC3C7), width: 1),
                boxShadow: const [
                  BoxShadow(color: Color(0x3F000000), blurRadius: 10, offset: Offset(0, 2)),
                ],
              ),
              child: const Text(
                'By using the Camping App service, you consent to the data practices described.',
                style: TextStyle(
                  color: Color(0xFF40281E),
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // 2. محتوى السياسة المفصل
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF8EAD8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBDC3C7), width: 1),
                boxShadow: const [
                  BoxShadow(color: Color(0x3F000000), blurRadius: 10, offset: Offset(0, 2)),
                ],
              ),
              child: Text(
                _policyText,
                style: const TextStyle(
                  color: Color(0xFF40281E),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}