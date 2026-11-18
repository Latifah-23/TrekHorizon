import 'package:flutter/material.dart';
import 'booking_screen.dart'; // لربط زر الحجز

class DiscoverDetailsScreen extends StatefulWidget {
  final String tripTitle;
  final String imageUrl;

  const DiscoverDetailsScreen({
    super.key,
    required this.tripTitle,
    required this.imageUrl,
  });

  @override
  State<DiscoverDetailsScreen> createState() => _DiscoverDetailsScreenState();
}

class _DiscoverDetailsScreenState extends State<DiscoverDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- بيانات الرحلات (Tours Data) ---
  // يتم تحديد البيانات بناءً على عنوان الرحلة
  Map<String, dynamic> get _tripData {
    if (widget.tripTitle.contains("AlUla")) {
      return {
        'price': '\$350',
        'duration': '3 Days / 2 Nights',
        'desc':
            'Experience the ancient history of AlUla. Visit Hegra, Dadan, and witness the Elephant Rock. A journey through time.',
        'highlights': [
          'Hegra Tour',
          'Hot Air Balloon',
          'Stargazing',
          'Luxury Camp'
        ],
        'itinerary': [
          {
            'day': 'Day 1',
            'title': 'Arrival & Elephant Rock',
            'desc':
                'Airport pickup, check-in at luxury camp, sunset at Elephant Rock.'
          },
          {
            'day': 'Day 2',
            'title': 'Hegra & Dadan',
            'desc':
                'Guided tour to the UNESCO site of Hegra and the ancient kingdom of Dadan.'
          },
          {
            'day': 'Day 3',
            'title': 'Old Town & Departure',
            'desc':
                'Walk through AlUla Old Town, shopping for crafts, and transfer to airport.'
          },
        ]
      };
    } else if (widget.tripTitle.contains("Abha")) {
      return {
        'price': '\$200',
        'duration': '2 Days / 1 Night',
        'desc':
            'Enjoy the cool breeze of the Sarawat Mountains. Explore Rijal Almaa and the misty parks of Abha.',
        'highlights': [
          'Rijal Almaa',
          'Cable Car',
          'Green Mountain',
          'Local Cuisine'
        ],
        'itinerary': [
          {
            'day': 'Day 1',
            'title': 'City Tour & Cable Car',
            'desc':
                'Visit the Green Mountain, ride the cable car, and enjoy a traditional dinner.'
          },
          {
            'day': 'Day 2',
            'title': 'Rijal Almaa Village',
            'desc':
                'Trip to the heritage village of Rijal Almaa, museum visit, and departure.'
          },
        ]
      };
    } else {
      // Red Sea / Umluj
      return {
        'price': '\$450',
        'duration': '3 Days / 2 Nights',
        'desc':
            'Relax in the Saudi Maldives. Crystal clear waters, white sands, and boat trips to pristine islands.',
        'highlights': [
          'Island Hopping',
          'Snorkeling',
          'Beach BBQ',
          'Sunset Cruise'
        ],
        'itinerary': [
          {
            'day': 'Day 1',
            'title': 'Welcome to Paradise',
            'desc':
                'Arrival, boat transfer to the island resort, and beach relaxation.'
          },
          {
            'day': 'Day 2',
            'title': 'Marine Adventure',
            'desc':
                'Full day boat trip, snorkeling in coral reefs, and island BBQ lunch.'
          },
          {
            'day': 'Day 3',
            'title': 'Morning Swim & Leave',
            'desc':
                'Sunrise swim, breakfast by the sea, and speed boat back to the coast.'
          },
        ]
      };
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- ويدجت لبناء عنصر الجدول الزمني (Timeline) ---
  Widget _buildTimelineItem(
      String day, String title, String desc, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العمود الأيسر (الخط والدائرة)
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF9B5F3B),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  day.replaceAll(RegExp(r'[^0-9]'), ''), // استخراج الرقم
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFFE5BE85),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),
          // المحتوى الأيمن
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color(0xFFE5BE85).withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.03), blurRadius: 5)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF40281E),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      desc,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = _tripData;

    ImageProvider imageProvider;
    if (widget.imageUrl.startsWith('http')) {
      imageProvider = NetworkImage(widget.imageUrl);
    } else {
      imageProvider = AssetImage(widget.imageUrl);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
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
                  widget.tripTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image(image: imageProvider, fit: BoxFit.cover),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xAA40281E)],
                          stops: [0.6, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF9B5F3B),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFF9B5F3B),
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "About"),
                    Tab(text: "Itinerary"),
                    Tab(text: "Map"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // --- Tab 1: About (نبذة) ---
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['desc'],
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: Color(0xFF5D4037),
                        height: 1.6),
                  ),
                  const SizedBox(height: 20),
                  // معلومات سريعة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoChip(Icons.timer, data['duration']),
                      _buildInfoChip(Icons.group, "Family Friendly"),
                      _buildInfoChip(Icons.star, "4.9 (20 Reviews)"),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Trip Highlights",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF40281E)),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(
                      data['highlights'].length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle,
                                    color: Color(0xFF9B5F3B), size: 20),
                                const SizedBox(width: 10),
                                Text(data['highlights'][index],
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        color: Color(0xFF40281E))),
                              ],
                            ),
                          )),
                  const SizedBox(height: 100), // مساحة للبار السفلي
                ],
              ),
            ),

            // --- Tab 2: Itinerary (الجدول الزمني) ---
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: List.generate(data['itinerary'].length, (index) {
                  final day = data['itinerary'][index];
                  return _buildTimelineItem(day['day'], day['title'],
                      day['desc'], index == data['itinerary'].length - 1);
                }),
              ),
            ),

            // --- Tab 3: Map (الخريطة) ---
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        // صورة خريطة وهمية
                        image: NetworkImage(
                            'https://static.vecteezy.com/system/resources/previews/000/355/927/original/vector-city-map.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 10)
                      ],
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.location_on,
                            color: Colors.red, size: 30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Meeting Point: Airport Arrival Hall",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF40281E)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // --- البار السفلي الثابت (السعر + زر الحجز) ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5))
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Price",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Poppins')),
                  Text(
                    "${data['price']}",
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF40281E)),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // الانتقال لصفحة الحجز
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(
                        destinationName: widget.tripTitle,
                        pricePerPerson: data['price'],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9B5F3B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  elevation: 5,
                ),
                child: const Text("Book Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFE5BE85), size: 24),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 12, color: Colors.grey, fontFamily: 'Poppins')),
      ],
    );
  }
}

// كلاس مساعد لتثبيت الهيدر (TabBar)
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFFFFAF4), // لون الخلفية خلف التبويبات
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
