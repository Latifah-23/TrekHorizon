import 'package:flutter/material.dart';
import 'booking_screen.dart'; // ✅ استيراد صفحة الحجز

class DestinationDetailsScreen extends StatefulWidget {
  final String destinationName;

  const DestinationDetailsScreen({super.key, required this.destinationName});

  @override
  State<DestinationDetailsScreen> createState() =>
      _DestinationDetailsScreenState();
}

class _DestinationDetailsScreenState extends State<DestinationDetailsScreen> {
  String _currentActivityDescription =
      "Select an activity above to see details.";
  int _selectedActivityIndex = -1;

  // متغير لتخزين الصورة المعروضة حالياً (إما صورة المدينة أو صورة النشاط)
  String? _currentDisplayImage;

  // --- 1. بيانات الأنشطة (الأيقونات + الوصف + صور الفعاليات) ---
  Map<String, dynamic> _getActivityInfo(String type) {
    switch (type) {
      case 'Climbing':
        return {
          'icon': Icons.terrain,
          'desc':
              'Conquer steep cliffs and challenging rock faces amidst the diverse terrains.',
          'image':
              'assets/images/climbing.jpg'
        };
      case 'Camping':
        return {
          'icon': Icons.nights_stay,
          'desc':
              'Experience serenity under the starry skies in designated camping spots.',
          'image':
              'assets/images/camping.jpg'
        };
      case 'Hiking':
        return {
          'icon': Icons.directions_walk,
          'desc':
              'Trek through amazing trails, valleys, and slopes to reach breathtaking viewpoints.',
          'image':
              'assets/images/hiking.jpg'
        };
      case 'Sandboarding':
        return {
          'icon': Icons.surfing,
          'desc':
              'Slide down the golden dunes for a thrilling desert adventure.',
          'image':
              'assets/images/sandboarding.jpg'
        };
      case 'Mountain biking':
        return {
          'icon': Icons.pedal_bike,
          'desc':
              'Thrilling cycle rides on rough, mountainous, and forested terrains.',
          'image':
              'assets/images/mountain biking.jpg'
        };
      case 'Hotairballone':
        return {
          'icon': Icons.air,
          'desc':
              'Soar high above the landscape for an ultimate aerial view at sunrise.',
          'image':
              'assets/images/hotairballone.jpg'
        };
      case 'Dune bashing':
        return {
          'icon': Icons.directions_car_filled,
          'desc':
              'Adrenaline-pumping 4x4 drive across the challenging sand dunes.',
          'image':
              'assets/images/dune bashing.jpg'
        };
      case 'Cave Exploration':
        return {
          'icon': Icons.flashlight_on,
          'desc':
              'Discover the mysteries and geological wonders hidden underground.',
          'image':
              'assets/images/cave explration.jpg'
        };
      case 'Paragliding':
        return {
          'icon': Icons.paragliding,
          'desc':
              'Fly over the clouds and green valleys for an ultimate adrenaline rush.',
          'image':
              'assets/images/paragliding.jpg'
        };
      case 'Heritage':
        return {
          'icon': Icons.account_balance,
          'desc':
              'Explore ancient villages, historical sites, and rich cultural history.',
          'image':
              'assets/images/heritage.jpg'
        };
      default:
        return {
          'icon': Icons.help_outline,
          'desc': 'Enjoy this unique activity in this beautiful location.',
          'image': 'assets/images/camping.jpg'
        };
    }
  }

  // --- 2. قاعدة بيانات الوجهات ---
  final Map<String, Map<String, dynamic>> _destinationsData = {
    'Al-Soudah Mountains': {
      'image':
          'assets/images/Al-Soudah Mountains.jpg',
      'desc':
          'Al-Soudah offers the ultimate mountain experience with cool weather and breathtaking views from the highest peaks in Saudi Arabia.',
      'activities': [
        'Hiking',
        'Paragliding',
        'Camping',
        'Mountain biking',
        'Climbing'
      ],
      'price': '\$250 per night / person',
      'safety':
          'High altitude area. Bring warm clothing even in summer. Check weather for fog before driving.',
    },
    'Abha / Aseer': {
      'image': 'assets/images/abha.jpg', // صورة محلية
      'desc':
          'Abha is the Mountain Bride. A cool, misty escape in Saudi Arabia\'s highest region. Enjoy dense juniper forests and dramatic peaks.',
      'activities': ['Heritage', 'Hiking', 'Camping', 'Mountain biking'],
      'price': '\$200 per night / person',
      'safety':
          'Roads can be foggy and slippery. Drive carefully. Respect local wildlife (monkeys).',
    },
    'AlUla': {
      'image':
          'assets/images/AlUla.jpg',
      'desc':
          'A living museum of preserved tombs and sandstone outcrops, offering a journey through time in a breathtaking desert landscape.',
      'activities': [
        'Heritage',
        'Hotairballone',
        'Hiking',
        'Camping',
        'Climbing'
      ],
      'price': '\$350 per night / person',
      'safety':
          'Desert climate; stay hydrated and wear sun protection. Do not touch or climb on ancient inscriptions.',
    },
    'Wadi Lajab': {
      'image':
          'assets/images/Wadi Lajab.jpg',
      'desc':
          'A stunning canyon paradise with hanging gardens and flowing water, perfect for hikers and nature lovers.',
      'activities': ['Hiking', 'Climbing', 'Camping'],
      'price': '\$150 per trip / person',
      'safety':
          'Flash flood risk area; avoid during rain. Wear non-slip water shoes. No mobile signal inside.',
    },
    'Jazan': {
      'image':
          'assets/images/Jazan.jpg',
      'desc':
          'The pearl of the south, offering beautiful coastlines, mountain terraces, and rich culture.',
      'activities': ['Heritage', 'Hiking', 'Camping'],
      'price': '\$180 per night / person',
      'safety':
          'Hot and humid weather; dress lightly. Be careful when swimming in open sea areas.',
    },
    'The Empty Quarter': {
      'image':
          'assets/images/The Empty Quarter.jpg',
      'desc':
          'Experience the silence and vastness of the largest continuous sand desert in the world. A true adventure into the unknown.',
      'activities': ['Dune bashing', 'Sandboarding', 'Camping'],
      'price': '\$400 per trip / person',
      'safety':
          'EXTREME ENVIRONMENT. Never enter without an experienced guide and convoy. Carry extra fuel and water.',
    },
    'Al-Baha': {
      'image':
          'assets/images/Al-Baha.jpg',
      'desc':
          'Known for its forests, valleys, and ancient towers (Qasaba). A refreshing retreat with rich heritage.',
      'activities': ['Hiking', 'Heritage', 'Camping', 'Mountain biking'],
      'price': '\$190 per night / person',
      'safety':
          'Winding mountain roads; drive slowly. Wear appropriate hiking gear.',
    },
    'Tabuk': {
      'image': 'assets/images/Tabuk.jpg', // صورة محلية
      'desc':
          'The northern gateway, featuring red sands, dramatic rock formations like Wadi Disah, and snowy winters.',
      'activities': ['Hiking', 'Camping', 'Heritage', 'Dune bashing'],
      'price': '\$220 per night / person',
      'safety':
          'Temperatures can drop below freezing in winter. Bring heavy winter gear. 4x4 vehicle required for off-road.',
    },
    'Tayma': {
      'image':
          'assets/images/Tayma.jpg',
      'desc':
          'An ancient oasis city with a rich history dating back thousands of years, famous for the Haddaj Well.',
      'activities': ['Heritage', 'Camping'],
      'price': '\$160 per night / person',
      'safety':
          'Protect yourself from the sun. Respect archaeological sites. Stay on designated paths.',
    },
    'Jeddah': {
      'image':
          'assets/images/Jeddah.jpg',
      'desc':
          'The Bride of the Red Sea. A vibrant blend of historical Al-Balad architecture and modern seaside luxury.',
      'activities': ['Heritage', 'Hiking'],
      'price': '\$300 per night / person',
      'safety':
          'Humidity can be high. Drink plenty of water. Follow safety rules when engaging in water sports.',
    },
    'Yanbu': {
      'image':
          'assets/images/Yanbu.jpg',
      'desc':
          'The Pearl of the Red Sea, offering some of the best diving spots and a serene coastal atmosphere.',
      'activities': ['Heritage', 'Camping'],
      'price': '\$280 per night / person',
      'safety':
          'Coral reefs are delicate; do not touch or stand on them while diving.',
    },
    'Umluj': {
      'image': 'assets/images/Umluj.jpg', // صورة محلية
      'desc':
          'Often called the Maldives of Saudi Arabia, known for its pristine turquoise waters and white sandy beaches.',
      'activities': ['Camping', 'Hiking'],
      'price': '\$450 per night / person',
      'safety':
          'Strong sun exposure; use high SPF sunscreen. Be aware of tides if camping near the shore.',
    },
    'Farasan Islands': {
      'image':
          'assets/images/Farasan Islands.jpg',
      'desc':
          'An archipelago of coral islands with rich marine life, mangroves, and historical Ottoman sites.',
      'activities': ['Heritage', 'Camping'],
      'price': '\$230 per night / person',
      'safety':
          'Ferry schedule is strict; plan ahead. Carry insect repellent for mangroves.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final String name = widget.destinationName;
    final Map<String, dynamic> currentData = _destinationsData[name] ??
        {
          'image': 'assets/images/camping.jpg',
          'desc': 'Explore the beauty of $name.',
          'activities': ['Hiking', 'Heritage'],
          'price': 'Price upon request',
          'safety': 'General safety: Stay hydrated.',
        };

    final List<String> activityKeys = currentData['activities'] as List<String>;
    final List<Map<String, dynamic>> locationActivities =
        activityKeys.map((key) {
      final info = _getActivityInfo(key);
      return {'key': key, ...info};
    }).toList();

    // تحديد الصورة للعرض (محلية أم شبكة)
    String imageToDisplay = _currentDisplayImage ?? currentData['image'];
    ImageProvider imageProvider;
    if (imageToDisplay.startsWith('http')) {
      imageProvider = NetworkImage(imageToDisplay);
    } else {
      imageProvider = AssetImage(imageToDisplay);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          name,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFF40281E),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF40281E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. صورة الوجهة (تتغير حسب النشاط)
            Container(
              margin: const EdgeInsets.all(20),
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 2. الوصف
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                currentData['desc'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Color(0xFF5D4037),
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 3. شريط أيقونات الأنشطة
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: locationActivities.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedActivityIndex == index;
                  final activity = locationActivities[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedActivityIndex = index;
                        _currentActivityDescription = activity['desc'];
                        // تغيير الصورة العلوية لصورة النشاط إذا توفرت
                        if (activity['image'] != null) {
                          _currentDisplayImage = activity['image'];
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF9B5F3B)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? null
                            : Border.all(
                                color: const Color(0xFF40281E), width: 1.5),
                      ),
                      child: Icon(
                        activity['icon'],
                        color:
                            isSelected ? Colors.white : const Color(0xFF40281E),
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // 4. عرض السعر
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: Text(
                  currentData['price'],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF40281E),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(color: Color(0x2240281E)),
            ),

            // 5. وصف النشاط المتغير
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8EFE6),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFE5BE85)),
              ),
              child: Center(
                child: Text(
                  _currentActivityDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF40281E),
                  ),
                ),
              ),
            ),

            // 6. إرشادات السلامة
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.red.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.health_and_safety, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text(
                        "Safety Guidelines",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentData['safety'] ??
                        'Always follow local safety regulations.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF40281E),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // 7. زر الحجز (ينقل لصفحة الحجز)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // ✅ الانتقال لصفحة الحجز مع تمرير البيانات
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(
                          destinationName: name,
                          pricePerPerson: currentData['price'],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B5F3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
