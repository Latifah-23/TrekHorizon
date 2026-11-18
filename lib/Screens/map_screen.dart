import 'package:flutter/material.dart';

// --- نموذج بيانات المكان ---
class MapPlace {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double rating;
  final String distance;
  final Offset locationOnMap;

  MapPlace({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.locationOnMap,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // الفلتر المختار حالياً
  String _selectedMapFilter = 'Coffee';

  // --- بيانات الأماكن (تم توسيعها لتشمل الفئات الجديدة) ---
  final List<MapPlace> allMapPlaces = [
    // Coffee
    MapPlace(
        id: '1',
        name: 'Blackbird Coffee',
        category: 'Coffee',
        imageUrl:
            'https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=1000',
        rating: 4.5,
        distance: '2.5km',
        locationOnMap: const Offset(100, 250)),
    MapPlace(
        id: '2',
        name: 'All Day Coffee',
        category: 'Coffee',
        imageUrl:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=1000',
        rating: 4.8,
        distance: '1.2km',
        locationOnMap: const Offset(250, 350)),

    // Restaurant
    MapPlace(
        id: '4',
        name: 'Najd Village',
        category: 'Restaurant',
        imageUrl:
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=1000',
        rating: 4.7,
        distance: '5.0km',
        locationOnMap: const Offset(200, 300)),

    // Emergency
    MapPlace(
        id: '6',
        name: 'City Hospital',
        category: 'Emergency',
        imageUrl:
            'assets/images/hospital.png',
        rating: 5.0,
        distance: '10km',
        locationOnMap: const Offset(150, 450)),

    // Shopping
    MapPlace(
        id: '7',
        name: 'Riyadh Mall',
        category: 'Shopping',
        imageUrl:
            'assets/images/mall.png',
        rating: 4.6,
        distance: '8.0km',
        locationOnMap: const Offset(300, 200)),

    // Sights (Museum/Bank)
    MapPlace(
        id: '8',
        name: 'National Museum',
        category: 'Sights',
        imageUrl:
            'https://images.unsplash.com/photo-1566127444979-b3d2b654e3d7?q=80&w=1000',
        rating: 4.9,
        distance: '4.0km',
        locationOnMap: const Offset(120, 380)),

    // Fuel
    MapPlace(
        id: '9',
        name: 'Fuel Station 24',
        category: 'Fuel',
        imageUrl:
            'https://images.unsplash.com/photo-1527018263374-5adb6a54f01e?q=80&w=1000',
        rating: 4.0,
        distance: '15km',
        locationOnMap: const Offset(50, 100)),

    // Hotels
    MapPlace(
        id: '10',
        name: 'Luxury Stay',
        category: 'Hotels',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1000',
        rating: 4.8,
        distance: '1.0km',
        locationOnMap: const Offset(280, 150)),
  ];

  // ويدجت زر الفلتر (تم تعديله ليطابق الصورة: مستطيل بحواف دائرية وأيقونة كبيرة)
  Widget _buildMapFilterChip(String label, IconData icon) {
    bool isSelected = _selectedMapFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedMapFilter = label),
      child: Container(
        // العرض والارتفاع ليكون مربعاً مستطيلاً كما في الصورة
        width: 65,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE5BE85), // اللون البيج الموحد
          borderRadius: BorderRadius.circular(12),
          // إطار بني عند التحديد فقط
          border: isSelected
              ? Border.all(color: const Color(0xFF40281E), width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Icon(icon,
              color: const Color(0xFF40281E), // لون الأيقونة البني الداكن
              size: 30),
        ),
      ),
    );
  }

  // ويدجت بطاقة المكان السفلية
  Widget _buildMapPlaceCard(MapPlace place) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCEFDC),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image(
              image: place.imageUrl.startsWith('http')
                  ? NetworkImage(place.imageUrl)
                  : AssetImage(place.imageUrl) as ImageProvider,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => Container(
                  color: Colors.grey[300],
                  height: 100,
                  child: const Icon(Icons.error)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.category,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(place.name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF40281E)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.near_me, size: 12, color: Colors.grey),
                        const SizedBox(width: 2),
                        Text(place.distance,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          Text(place.rating.toString(),
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const Icon(Icons.star, size: 8, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لجلب أيقونة الدبوس حسب الفئة
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Emergency':
        return Icons.local_hospital;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Coffee':
        return Icons.coffee;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Sights':
        return Icons.account_balance;
      case 'Fuel':
        return Icons.local_gas_station;
      case 'Hotels':
        return Icons.apartment;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlaces =
        allMapPlaces.where((p) => p.category == _selectedMapFilter).toList();

    // ✅ استخدام Stack بدلاً من Scaffold لتظهر داخل الصفحة الرئيسية
    return Stack(
      children: [
        // 1. خلفية الخريطة
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'assets/images/map_background.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE0E0E0),
                child: const Center(
                    child: Icon(Icons.map, size: 50, color: Colors.grey)),
              );
            },
          ),
        ),

        // 2. الدبابيس (Markers)
        ...filteredPlaces.map((place) {
          return Positioned(
            left: place.locationOnMap.dx,
            top: place.locationOnMap.dy,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4, color: Colors.black.withOpacity(0.3))
                    ],
                    border:
                        Border.all(color: const Color(0xFF9B5F3B), width: 2),
                  ),
                  child: Icon(_getCategoryIcon(place.category),
                      color: const Color(0xFF9B5F3B), size: 20),
                ),
                const Icon(Icons.arrow_drop_down,
                    size: 24, color: Color(0xFF9B5F3B)),
              ],
            ),
          );
        }),

        // 3. شريط الفلاتر العلوي (المعدل)
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _buildMapFilterChip('Emergency', Icons.local_hospital),
                _buildMapFilterChip('Restaurant', Icons.restaurant),
                _buildMapFilterChip('Coffee', Icons.coffee),
                _buildMapFilterChip('Shopping', Icons.shopping_bag),
                _buildMapFilterChip('Sights', Icons.account_balance),
                _buildMapFilterChip('Fuel', Icons.local_gas_station),
                _buildMapFilterChip('Hotels', Icons.apartment),
              ],
            ),
          ),
        ),

        // 4. قائمة البطاقات السفلية
        Positioned(
          bottom: 20, // مسافة لرفعها عن البار السفلي
          left: 0,
          right: 0,
          child: SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: filteredPlaces.length,
              itemBuilder: (context, index) =>
                  _buildMapPlaceCard(filteredPlaces[index]),
            ),
          ),
        ),
      ],
    );
  }
}
