import 'package:flutter/material.dart';
import 'booking_screen.dart';
import 'destination_details_screen.dart'; // للانتقال لتفاصيل المنطقة عند الضغط عليها

class ActivityDetailsScreen extends StatelessWidget {
  final String activityName;

  const ActivityDetailsScreen({super.key, required this.activityName});

  // --- بيانات الأنشطة (تم تحديث مسارات الصور لتطابق ملفاتك) ---
  static const Map<String, dynamic> _activitiesData = {
    'Hiking': {
      'image': 'assets/images/hiking.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Embark on an unforgettable hiking journey through the majestic trails of Saudi Arabia. From green mountains to desert canyons, discover nature on foot.',
      'places': [
        'Abha / Aseer',
        'Al-Soudah Mountains',
        'Wadi Lajab',
        'Al-Baha'
      ],
      'price': '\$120 per person',
    },
    'Camping': {
      'image': 'assets/images/camping.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Reconnect with nature by camping under the starlit skies. Whether in the golden sands or atop cool peaks, serenity awaits.',
      'places': ['The Empty Quarter', 'Tabuk', 'AlUla', 'Tayma'],
      'price': '\$200 per night',
    },
    'Sandboarding': {
      'image': 'assets/images/sandboarding.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Feel the thrill of gliding down the massive sand dunes of the Arabian desert. An exhilarating experience for adventure seekers.',
      'places': ['The Empty Quarter', 'Tabuk', 'Jazan'],
      'price': '\$150 per trip',
    },
    'Climbing': {
      'image': 'assets/images/climbing.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Challenge yourself with rock climbing adventures on the rugged cliffs and ancient formations of the Kingdom.',
      'places': ['Al-Soudah Mountains', 'AlUla', 'Wadi Lajab'],
      'price': '\$180 per person',
    },
    'Mountain biking': {
      'image': 'assets/images/mountain biking.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Ride through rough terrains and scenic trails. Mountain biking in Saudi Arabia offers a mix of challenge and beauty.',
      'places': ['Al-Soudah Mountains', 'Abha / Aseer', 'Al-Baha'],
      'price': '\$100 per trip',
    },
    'Hotairballone': {
      'image': 'assets/images/hotairballone.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Witness the history and beauty of AlUla from the sky. A magical hot air balloon ride at sunrise is a must-do.',
      'places': ['AlUla'],
      'price': '\$350 per person',
    },
    'Dune bashing': {
      'image': 'assets/images/dune bashing.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Buckle up for a wild 4x4 ride across the endless dunes. Dune bashing is the ultimate desert adrenaline rush.',
      'places': ['The Empty Quarter', 'Tabuk'],
      'price': '\$250 per car',
    },
    'Cave Exploration': {
      // ⚠️ انتبه: كتبت الاسم كما ظهر في الصورة (explration بدون o) لضمان العمل
      'image': 'assets/images/cave explration.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Delve deep into the earth to discover ancient caves, lava tubes, and geological wonders.',
      'places': ['Al-Baha', 'Wadi Lajab'],
      'price': '\$140 per person',
    },
    'Paragliding': {
      'image': 'assets/images/paragliding.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Soar like a bird over the green valleys and misty peaks. Paragliding offers an unmatched aerial perspective.',
      'places': ['Al-Soudah Mountains', 'Abha / Aseer'],
      'price': '\$300 per flight',
    },
    'Heritage': {
      'image': 'assets/images/heritage.jpg', // ✅ صورة من ملفاتك
      'desc':
          'Walk through history in ancient villages, old towns, and archaeological sites that tell the story of Arabia.',
      'places': ['Jeddah', 'AlUla', 'Tayma', 'Yanbu', 'Farasan Islands'],
      'price': '\$80 per tour',
    },
  };

  @override
  Widget build(BuildContext context) {
    // جلب البيانات أو استخدام قيم افتراضية
    final data = _activitiesData[activityName] ??
        {
          'image': 'assets/images/camping.jpg',
          'desc': 'Enjoy this amazing activity.',
          'places': [],
          'price': '\$0',
        };

    // معالجة نوع الصورة (Asset أو Network)
    ImageProvider imageProvider;
    if (data['image'].startsWith('http')) {
      imageProvider = NetworkImage(data['image']);
    } else {
      imageProvider = AssetImage(data['image']);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: CustomScrollView(
        slivers: [
          // 1. الهيدر (صورة النشاط)
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF9B5F3B),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Colors.white54, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Color(0xFF40281E), size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                activityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                ),
              ),
              background: Image(
                image: imageProvider,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: const Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.white, size: 50)),
                  );
                },
              ),
            ),
          ),

          // 2. المحتوى
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الوصف
                  const Text("About this Activity",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF40281E))),
                  const SizedBox(height: 10),
                  Text(data['desc'],
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color(0xFF5D4037),
                          height: 1.6)),

                  const SizedBox(height: 30),

                  // أفضل الأماكن (Best Places)
                  if (data['places'].isNotEmpty) ...[
                    Text("Best Places for $activityName",
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF40281E))),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data['places'].length,
                        itemBuilder: (context, index) {
                          String placeName = data['places'][index];
                          // صورة مصغرة للمكان (منطق تقريبي للصور المحلية)
                          ImageProvider placeImage;
                          if (placeName.contains('Abha')) {
                            placeImage = const AssetImage(
                                'assets/images/abha.jpg');
                          } else if (placeName.contains('Tabuk'))
                            placeImage =
                                const AssetImage('assets/images/Tabuk.jpg');
                          else if (placeName.contains('Umluj'))
                            placeImage =
                                const AssetImage('assets/images/Umluj.jpg');
                          else if (placeName.contains('AlUla'))
                            placeImage =
                                const AssetImage('assets/images/AlUla.jpg');
                          else if (placeName.contains('Jazan'))
                            placeImage =
                                const AssetImage('assets/images/Jazan.jpg');
                          else if (placeName.contains('Empty Quarter'))
                            placeImage = const AssetImage(
                                'assets/images/The Empty Quarter.jpg');
                          else if (placeName.contains('Al-Baha'))
                            placeImage =
                                const AssetImage('assets/images/Al-Baha.jpg');
                          else if (placeName.contains('Tayma'))
                            placeImage =
                                const AssetImage('assets/images/Tayma.jpg');
                          else if (placeName.contains('Jeddah'))
                            placeImage =
                                const AssetImage('assets/images/Jeddah.jpg');
                          else if (placeName.contains('Yanbu'))
                            placeImage =
                                const AssetImage('assets/images/Yanbu.jpg');
                          else if (placeName.contains('Farasan'))
                            placeImage = const AssetImage(
                                'assets/images/Farasan Islands.jpg');
                          else if (placeName.contains('Soudah'))
                            placeImage = const AssetImage(
                                'assets/images/Al-Soudah Mountains.jpg');
                          else
                            placeImage = const AssetImage(
                                'assets/images/camping.jpg');

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DestinationDetailsScreen(
                                          destinationName: placeName),
                                ),
                              );
                            },
                            child: Container(
                              width: 140,
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: placeImage,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.darken),
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                placeName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),

                  // السعر وزر الحجز
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -2))
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Starting from",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: 'Poppins')),
                            Text(
                              data['price'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF40281E),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 140,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // الانتقال لصفحة الحجز
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingScreen(
                                    destinationName: "$activityName Trip",
                                    pricePerPerson: data['price'],
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9B5F3B),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
