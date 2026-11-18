import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/discover_card.dart';
import 'map_screen.dart';
import 'services_screen.dart';
import 'reservations_screen.dart';
import 'destination_details_screen.dart';
import 'activity_details_screen.dart';

// --- Model for AI Recommendations ---
class AiRecommendation {
  final String title;
  final String description;
  final String imageUrl;
  final String targetDestination;

  AiRecommendation({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.targetDestination,
  });
}

// --- Model for Destinations ---
class Destination {
  final String name;
  final String imageUrl;

  Destination({required this.name, required this.imageUrl});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- State Variables ---
  int _selectedTab = 0; // 0: Destinations, 1: Activities
  bool _isDiscoverMode = true;
  int _selectedBottomNavIndex = 0;
  int _currentFlashDealIndex = 0;

  // Search variables
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // --- 1. Destinations Data ---
  final List<Destination> destinations = [
    Destination(name: 'AlUla', imageUrl: 'assets/images/AlUla.jpg'),
    // ✅ Updated Abha image path. Ensuring it uses the correct asset.
    // If you renamed the file to 'Abha.jpg', change it here.
    // Otherwise, 'abha.jpg' or 'Abha Aseer.jpg' are likely candidates.
    Destination(name: 'Abha / Aseer', imageUrl: 'assets/images/abha.jpg'),
    Destination(name: 'Umluj', imageUrl: 'assets/images/Umluj.jpg'),
    Destination(name: 'Wadi Lajab', imageUrl: 'assets/images/Wadi Lajab.jpg'),
    Destination(name: 'Jazan', imageUrl: 'assets/images/Jazan.jpg'),
    Destination(
        name: 'The Empty Quarter',
        imageUrl: 'assets/images/The Empty Quarter.jpg'),
    Destination(name: 'Al-Baha', imageUrl: 'assets/images/Al-Baha.jpg'),
    Destination(name: 'Tabuk', imageUrl: 'assets/images/Tabuk.jpg'),
    Destination(name: 'Tayma', imageUrl: 'assets/images/Tayma.jpg'),
    Destination(name: 'Jeddah', imageUrl: 'assets/images/Jeddah.jpg'),
    Destination(name: 'Yanbu', imageUrl: 'assets/images/Yanbu.jpg'),
    Destination(
        name: 'Farasan Islands', imageUrl: 'assets/images/Farasan Islands.jpg'),
    Destination(
        name: 'Al-Soudah Mountains',
        imageUrl: 'assets/images/Al-Soudah Mountains.jpg'),
  ];

  // --- Activities Data ---
  final List<Map<String, dynamic>> activities = const [
    {'title': 'Climbing', 'icon': Icons.terrain},
    {'title': 'Camping', 'icon': Icons.nights_stay},
    {'title': 'Hiking', 'icon': Icons.directions_walk},
    {'title': 'Sandboarding', 'icon': Icons.surfing},
    {'title': 'Mountain biking', 'icon': Icons.pedal_bike},
    {'title': 'Hotairballone', 'icon': Icons.air},
    {'title': 'Dune bashing', 'icon': Icons.directions_car_filled},
    {'title': 'Cave Exploration', 'icon': Icons.flashlight_on},
    {'title': 'Paragliding', 'icon': Icons.paragliding},
    {'title': 'Heritage', 'icon': Icons.account_balance},
  ];

  final List<Map<String, String>> flashDeals = [
    {
      'title': 'Flash Deals Alert!',
      'subtitle': 'Save 30% Now\non this week\'s top destinations',
      'type': 'fire'
    },
    {
      'title': 'Freshly Added Activities!',
      'subtitle': 'Discover newly curated activities for\nthe Fall season',
      'type': 'new'
    },
    {
      'title': 'Group Discount!',
      'subtitle': 'Get 20% off when booking\nfor 5+ people',
      'type': 'group'
    },
  ];

  final List<AiRecommendation> aiRecommendations = [
    AiRecommendation(
      title: 'Majestic AlUla',
      description:
          'Witness stunning rock formations and ancient sites from a hot air balloon.',
      imageUrl: 'assets/images/AlUla.jpg',
      targetDestination: 'AlUla',
    ),
    AiRecommendation(
      title: 'Abha\'s Peaks',
      description:
          'Experience the cool climate and breathtaking views of the Sarawat Mountains.',
      imageUrl: 'assets/images/abha.jpg',
      targetDestination: 'Abha / Aseer',
    ),
    AiRecommendation(
      title: 'Red Sea Wonders',
      description:
          'Dive into vibrant coral reefs and discover diverse marine life in Umluj.',
      imageUrl: 'assets/images/Umluj.jpg',
      targetDestination: 'Umluj',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ================== Widgets ==================

  Widget _buildFlashDealsCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _currentFlashDealIndex = index;
              });
            },
            itemCount: flashDeals.length,
            itemBuilder: (context, index) {
              final deal = flashDeals[index];
              IconData iconData = Icons.local_fire_department;
              if (deal['type'] == 'new') iconData = Icons.new_releases;
              if (deal['type'] == 'group') iconData = Icons.group;

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCEFDC).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5BE85)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(deal['title']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF40281E),
                                fontSize: 16)),
                        Icon(iconData, color: Colors.orange),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      deal['subtitle']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xFF9B5F3B),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(flashDeals.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentFlashDealIndex == index
                    ? const Color(0xFF40281E)
                    : const Color(0xFF40281E).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDestinationListItem(Destination destination) {
    ImageProvider imageProvider;
    if (destination.imageUrl.startsWith('http')) {
      imageProvider = NetworkImage(destination.imageUrl);
    } else {
      imageProvider = AssetImage(destination.imageUrl);
    }

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DestinationDetailsScreen(destinationName: destination.name))),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {},
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(20),
          child: Text(
            destination.name,
            style: const TextStyle(
                fontSize: 22,
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityDetailsScreen(activityName: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFF8EFE6),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE5BE85)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF9B5F3B), size: 28),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                color: Color(0xFF40281E),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Color(0xFF9B5F3B)),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeBody() {
    // 1. Filter Lists based on search query
    List<Destination> filteredDestinations = destinations;
    List<Map<String, dynamic>> filteredActivities = activities;

    if (_searchQuery.isNotEmpty) {
      filteredDestinations = destinations
          .where(
              (d) => d.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
      filteredActivities = activities
          .where((a) => a['title']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return Column(
      children: [
        // Search Bar (Active)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5))
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  // Auto-exit discover mode when searching
                  if (_searchQuery.isNotEmpty) {
                    _isDiscoverMode = false;
                  }
                });
              },
              decoration: InputDecoration(
                hintText: 'Search destinations or activities...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF9E9E9E)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Color(0xFF9E9E9E)),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = "";
                            _isDiscoverMode = true; // Return to discover mode
                          });
                        },
                      )
                    : const Icon(Icons.mic, color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),
          ),
        ),

        // Tab Buttons
        if (_searchQuery
            .isEmpty) // Hide tabs during active search for cleaner look
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isDiscoverMode = false;
                        _selectedTab = 0;
                      });
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (_selectedTab == 0 && !_isDiscoverMode)
                            ? const Color(0xFF9B5F3B)
                            : const Color(0xFFE5BE85),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('Destinations',
                          style: TextStyle(
                              color: (_selectedTab == 0 && !_isDiscoverMode)
                                  ? Colors.white
                                  : const Color(0xFF40281E),
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isDiscoverMode = false;
                        _selectedTab = 1;
                      });
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (_selectedTab == 1 && !_isDiscoverMode)
                            ? const Color(0xFF9B5F3B)
                            : const Color(0xFFE5BE85),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('Activities',
                          style: TextStyle(
                              color: (_selectedTab == 1 && !_isDiscoverMode)
                                  ? Colors.white
                                  : const Color(0xFF40281E),
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),

        Expanded(
          child: Builder(builder: (context) {
            // Case: Discover Mode (No Search)
            if (_isDiscoverMode && _searchQuery.isEmpty) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        child: Text("Discover",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF40281E)))),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _buildFlashDealsCarousel()),
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.9),
                        itemCount: aiRecommendations.length,
                        itemBuilder: (context, index) {
                          final item = aiRecommendations[index];
                          return DiscoverCard(
                            title: item.title,
                            description: item.description,
                            imageUrl: item.imageUrl,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DestinationDetailsScreen(
                                              destinationName:
                                                  item.targetDestination)));
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }

            // Case: Search Results or Specific Tab
            if (_searchQuery.isNotEmpty) {
              // Show combined results or switch based on tab? Let's show both if searching.
              // Actually, user is likely looking for one or the other.
              // If results exist in Destinations, show them. If not, check Activities.
              if (filteredDestinations.isNotEmpty) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  itemCount: filteredDestinations.length,
                  itemBuilder: (context, index) =>
                      _buildDestinationListItem(filteredDestinations[index]),
                );
              } else if (filteredActivities.isNotEmpty) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  itemCount: filteredActivities.length,
                  itemBuilder: (context, index) => _buildActivityItem(
                      filteredActivities[index]['title'],
                      filteredActivities[index]['icon']),
                );
              } else {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 60, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("No results found",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                );
              }
            }

            if (_selectedTab == 0) {
              return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  itemCount: destinations.length,
                  itemBuilder: (context, index) =>
                      _buildDestinationListItem(destinations[index]));
            }
            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                itemCount: activities.length,
                itemBuilder: (context, index) => _buildActivityItem(
                    activities[index]['title'], activities[index]['icon']));
          }),
        ),
      ],
    );
  }

  // ================== Custom Bottom Bar ==================
  Widget _buildBottomNavigationBar() {
    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;
      final double itemWidth = width / 5;

      return SizedBox(
        height: 85,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF9B5F3B),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2))
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              top: -15,
              left: _selectedBottomNavIndex * itemWidth + (itemWidth - 70) / 2,
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5BE85),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  _buildNavItem(0, Icons.home_rounded, onTap: () {
                    setState(() {
                      _selectedBottomNavIndex = 0;
                      _isDiscoverMode = true;
                      _searchQuery = "";
                      _searchController.clear();
                    });
                  }),
                  _buildNavItem(1, Icons.design_services_rounded, onTap: () {
                    setState(() {
                      _selectedBottomNavIndex = 1;
                    });
                  }),
                  _buildNavItem(2, Icons.airplane_ticket_rounded, onTap: () {
                    setState(() {
                      _selectedBottomNavIndex = 2;
                    });
                  }),
                  _buildNavItem(3, Icons.map_rounded, onTap: () {
                    setState(() {
                      _selectedBottomNavIndex = 3;
                    });
                  }),
                  _buildNavItem(4, Icons.person_rounded, onTap: () {
                    setState(() {
                      _selectedBottomNavIndex = 4;
                    });
                    Navigator.pushNamed(context, '/profile');
                  }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildNavItem(int index, IconData icon,
      {required VoidCallback onTap}) {
    final bool isSelected = _selectedBottomNavIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 70,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            transform: Matrix4.translationValues(0, isSelected ? -15 : 0, 0),
            child: Center(
              child: Icon(
                icon,
                size: isSelected ? 38 : 30,
                color: isSelected
                    ? const Color(0xFF40281E)
                    : Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentBody;
    String appBarTitle = 'Riyadh';

    if (_selectedBottomNavIndex == 3) {
      currentBody = const MapScreen();
      appBarTitle = 'Map View';
    } else if (_selectedBottomNavIndex == 2) {
      currentBody = const ReservationsScreen();
      appBarTitle = 'Reservations';
    } else if (_selectedBottomNavIndex == 1) {
      currentBody = const ServicesScreen();
      appBarTitle = 'Services';
    } else {
      currentBody = _buildHomeBody();
      appBarTitle = 'Riyadh';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),

      // ========== AppBar ==========
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                _selectedBottomNavIndex == 3
                    ? Icons.map
                    : (_selectedBottomNavIndex == 2
                        ? Icons.airplane_ticket
                        : (_selectedBottomNavIndex == 1
                            ? Icons.design_services
                            : Icons.location_on)),
                color: const Color(0xFF40281E),
                size: 20),
            const SizedBox(width: 5),
            Text(appBarTitle,
                style: const TextStyle(
                    color: Color(0xFF40281E),
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          ],
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF40281E), size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          if (_selectedBottomNavIndex == 0)
            IconButton(
                icon: const Icon(Icons.filter_list, color: Color(0xFF40281E)),
                onPressed: () {}),
          if (_selectedBottomNavIndex == 3)
            IconButton(
                icon: const Icon(Icons.add_location_alt,
                    color: Color(0xFF40281E)),
                onPressed: () {}),
          if (_selectedBottomNavIndex != 4)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/profile'),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFF9B5F3B),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
            ),
        ],
      ),
      drawer: const AppDrawer(),
      body: currentBody,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
