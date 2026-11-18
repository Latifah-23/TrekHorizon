import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _introData = [
    {
      "title": "Discover the Kingdom's Beauty",
      "text":
          "Explore diverse tourist destinations from the green Sarawat Mountains to the golden sands of the Empty Quarter. Experience an unforgettable journey in the heart of Arabia.",
      "image": "assets/images/Group 302.png"
    },
    {
      "title": "Endless Adventures",
      "text":
          "Plan your camping, climbing, and hiking trips in AlUla and NEOM. Enjoy breathtaking nature and recreational activities that suit all tastes.",
      "image": "assets/images/Group 301.png"
    },
    {
      "title": "Authentic Heritage & Hospitality",
      "text":
          "Discover the rich culture and historical sites in Jeddah Al-Balad and Diriyah. Enjoy Saudi hospitality and wonderful seasonal events.",
      "image": "assets/images/Group 300.png"
    }
  ];

  void _nextPage() {
    if (_currentPage < _introData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishIntro();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishIntro() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 1),

            // === منطقة المحتوى (PageView) ===
            Expanded(
              flex: 8,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _introData.length,
                itemBuilder: (context, index) {
                  // ✅ استخدام SingleChildScrollView لحل مشكلة Overflow
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // عرض الصورة
                          SizedBox(
                            height: 300,
                            child: Image.asset(
                              _introData[index]["image"]!,
                              fit: BoxFit.contain,
                              errorBuilder: (c, e, s) => const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.broken_image,
                                      size: 80, color: Color(0xFF9B5F3B)),
                                  Text("Image not found",
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // نقاط المؤشر
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                List.generate(_introData.length, (dotIndex) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == dotIndex
                                      ? const Color(0xFF40281E)
                                      : const Color(0xFFD9D9D9),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(height: 30),

                          // العنوان
                          Text(
                            _introData[index]["title"]!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF40281E),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 20),

                          // الوصف
                          Text(
                            _introData[index]["text"]!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xFF40281E),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const Spacer(flex: 1),

            // === منطقة الأزرار السفلية ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: _currentPage == _introData.length - 1
                  // الحالة 1: الصفحة الأخيرة (زر Get Started في المنتصف)
                  ? Center(
                      child: SizedBox(
                        width: 198,
                        height: 59.56,
                        child: ElevatedButton(
                          onPressed: _finishIntro,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9B5F3B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  // الحالة 2: الصفحات الأولى (أزرار تنقل يمين ويسار)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // زر Skip / Previous
                        InkWell(
                          onTap:
                              _currentPage == 0 ? _finishIntro : _previousPage,
                          child: Text(
                            _currentPage == 0 ? "Skip Tour" : "Previous",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF40281E),
                            ),
                          ),
                        ),

                        // زر Next
                        InkWell(
                          onTap: _nextPage,
                          child: const Row(
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF40281E),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward_ios,
                                  size: 16, color: Color(0xFF40281E)),
                            ],
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
