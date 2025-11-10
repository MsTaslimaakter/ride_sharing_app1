import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- (1)

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of widgets to be displayed in the navigation bar
  late final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    const PlaceholderPage(title: 'Products'),
    const CarePage(),
    const PlaceholderPage(title: 'Shop'),
    const PlaceholderPage(title: 'Community'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          // The App Bar title will change according to the selected page.
          _selectedIndex == 0 ? 'Home' : _widgetOptions[_selectedIndex] is CarePage ? 'Care' : (_widgetOptions[_selectedIndex] as PlaceholderPage).title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),


      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Care',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Community',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// --- (2)

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            NearbyUsersSection(),
            SizedBox(height: 24),
            // DealsSection এখন GridView ব্যবহার করবে
            DealsSection(),
            SizedBox(height: 24),
            EventsSection(),
            SizedBox(height: 24),
            ServicePackagesSection(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// --- (3)

// Reusable Section Header
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF222222),
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Text(
            "View all >",
            style: GoogleFonts.inter(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.blue.shade700,
            ),
          ),
        ),
      ],
    );
  }
}

class User {
  final String name;
  final String imagePath;
  const User({required this.name, required this.imagePath});
}

// Nearby Users section
class NearbyUsersSection extends StatelessWidget {
  const NearbyUsersSection({super.key});
  final List<User> users = const [
    User(name: 'Ankita', imagePath: 'assets/images/Nearby_Users/Ankita.png'),
    User(name: 'Pankaj', imagePath: 'assets/images/Nearby_Users/Pankaj.png'),
    User(name: 'Manish', imagePath: 'assets/images/Nearby_Users/Manish.png'),
    User(name: 'Suresh', imagePath: 'assets/images/Nearby_Users/Suresh.png'),
    User(name: 'Ankur', imagePath: 'assets/images/Nearby_Users/Ankur.png'),
    User(name: 'Deepesh', imagePath: 'assets/images/Nearby_Users/Pankaj.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "Nearby Users"),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final currentUser = users[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    CircleAvatar(radius: 30, backgroundImage: AssetImage(currentUser.imagePath)),
                    const SizedBox(height: 8),
                    Text(currentUser.name, style: GoogleFonts.inter(fontSize: 12,)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Product Deta Model
class Product {
  final String name;
  final String imagePath;
  final String currentPrice;
  final String oldPrice;
  final String discount;
  final String rating;
  final String reviews;

  const Product({
    required this.name,
    required this.imagePath,
    this.currentPrice = '',
    this.oldPrice = '',
    this.discount = '',
    this.rating = '',
    this.reviews = '',
  });
}


// Deals Section
class DealsSection extends StatelessWidget {
  const DealsSection({super.key});
  final List<Product> deals = const [
    Product(
      name: "Racing Dual Visor Helmet",
      imagePath: 'assets/images/Deals_of_the_Day/Racing_Dual_Visor_Helmet.png',
      currentPrice: "₹4,079",
      oldPrice: "₹5,000",
      discount: "20% Off",
      rating: "4.8",
      reviews: "212",
    ),
    Product(
      name: "Aerodynamic Helmet",
      imagePath: 'assets/images/Deals_of_the_Day/Aerodynamic_Helmet.png',
      currentPrice: "₹2,799",
      oldPrice: "₹3,499",
      discount: "20% Off",
      rating: "4.5",
      reviews: "154",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double cardAspectRatio = 0.8;
    final double crossAxisSpacing = 16.0;
    final double cardHeight = (MediaQuery.of(context).size.width - 32 - crossAxisSpacing) / 2 / cardAspectRatio;
    final double gridHeight = cardHeight + 8;

    return Column(
      children: [
        const SectionHeader(title: "Deals of the Day"),
        const SizedBox(height: 8),
        SizedBox(
          height: gridHeight,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: 16.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: cardAspectRatio,
            children: deals.map((product) {
              return _GridProductCard(product: product);
            }).toList(),
          ),
        ),
      ],
    );
  }
}


//Grid Product Card
class _GridProductCard extends StatelessWidget {
  final Product product;
  const _GridProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Image.asset(product.imagePath, height: 100)),
        ),
        const SizedBox(height: 8),
        Text(product.name, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(product.currentPrice, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(width: 4),
            Text(product.oldPrice, style: GoogleFonts.inter(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12)),
            const SizedBox(width: 4),
            Text(product.discount, style: GoogleFonts.inter(color: Colors.purple.shade700, fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.star, color: Colors.orange.shade700, size: 16),
            const SizedBox(width: 4),
            Text("${product.rating} (${product.reviews})", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700])),
          ],
        ),
      ],
    );
  }
}

// Event Data Model
class Event {
  final String title;
  final String imagePath;
  final List<String> userImages;
  final int additionalUsers;

  const Event({
    required this.title,
    required this.imagePath,
    this.userImages = const [],
    this.additionalUsers = 0,
  });
}

// Upcoming Events
class EventsSection extends StatelessWidget {
  const EventsSection({super.key});
  final List<Event> events = const [
    Event(title: "Shimla to Manali", imagePath: 'assets/images/Upcoming_Events/Shimla_to_Manali.png', userImages: ['assets/images/Upcoming_Events/upper_pictur/Man_1.png', 'assets/images/Upcoming_Events/upper_pictur/Woman_1.png', 'assets/images/Upcoming_Events/upper_pictur/Man_2.png',], additionalUsers: 12),
    Event(title: "Goa to Gujarat", imagePath: 'assets/images/Upcoming_Events/Goa_to_Gujarat.png', userImages: ['assets/images/Upcoming_Events/upper_pictur/Man_1.png', 'assets/images/Upcoming_Events/upper_pictur/Woman_1.png', 'assets/images/Upcoming_Events/upper_pictur/Man_2.png',], additionalUsers: 20),
    Event(title: "Kashmir Tour", imagePath: 'assets/images/Upcoming_Events/Kashmir_Tripe.png', userImages: ['assets/images/Upcoming_Events/upper_pictur/Man_1.png', 'assets/images/Upcoming_Events/upper_pictur/Woman_1.png', 'assets/images/Upcoming_Events/upper_pictur/Man_2.png',], additionalUsers: 6),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "Upcoming Events"),
        const SizedBox(height: 8),
        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return _EventCard(event: event);
            },
          ),
        ),
      ],
    );
  }
}


// Event Card
class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});
  final Event event;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(event.imagePath, fit: BoxFit.cover, width: 150, height: 150),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Row(
                    children: [
                      ...event.userImages.take(3).map((imagePath) {
                        return Align(
                          widthFactor: 0.6,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(radius: 11, backgroundImage: AssetImage(imagePath)),
                          ),
                        );
                      }).toList(),
                      if (event.additionalUsers > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 1),
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF584CF4).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Text(
                            "+${event.additionalUsers}",
                            style: GoogleFonts.roboto(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Center(child: Text(event.title, style: GoogleFonts.inter(color: const Color(0xFF666666), fontSize: 14, ))),
        ],
      ),
    );
  }
}

// Buy Service Packages
class ServicePackagesSection extends StatelessWidget {
  const ServicePackagesSection({super.key});
  final List<Map<String, String>> servicePackages = const [
    {'name': 'Annual Maintenance', 'currentPrice': '₹ 900', 'oldPrice': '₹ 1,000', 'discount': '10% Off', 'imagePath': 'assets/images/Buy_Service_Packages/Annual_Maintenance.png'},
    {'name': 'Teflon Coating', 'currentPrice': '₹ 1350', 'oldPrice': '₹ 1500', 'discount': '10% Off', 'imagePath': 'assets/images/Buy_Service_Packages/Teflon_Coating.png'},
    {'name': 'Annual Maintenance', 'currentPrice': '₹ 900', 'oldPrice': '₹ 1,000', 'discount': '10% Off', 'imagePath': 'assets/images/Care_Page_Picture/Buy_Service_Packages/Annual_Maintenance1.png'},
    {'name': 'Teflon Coating', 'currentPrice': '₹ 1350', 'oldPrice': '₹ 1500', 'discount': '10% Off', 'imagePath': 'assets/images/Care_Page_Picture/Buy_Service_Packages/Teflon_Coating1.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final double cardAspectRatio = 0.8;
    final double crossAxisSpacing = 16.0;
    final double mainAxisSpacing = 16.0;
    final double cardHeight = (MediaQuery.of(context).size.width - 32 - crossAxisSpacing) / 2 / cardAspectRatio;
    final double gridHeight = (cardHeight * 2) + mainAxisSpacing + 8;

    return Column(
      children: [
        const SectionHeader(title: "Buy Service Packages"),
        const SizedBox(height: 8),
        SizedBox(
          height: gridHeight,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: cardAspectRatio,
            children: servicePackages.map((data) {
              return _ServicePackageCard(
                name: data['name']!,
                currentPrice: data['currentPrice']!,
                oldPrice: data['oldPrice']!,
                discount: data['discount']!,
                imagePath: data['imagePath']!,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}






// --- (৪) Care Page  ---

class CarePage extends StatelessWidget {
  const CarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bike Name', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[500])),
                TextButton(onPressed: () {}, child: Text('Change', style: GoogleFonts.inter(fontSize: 14, color: Colors.purple[500]))),
              ],
            ),
            const SizedBox(height: 16),

            // Care Recommendations Section
            const SectionHeader(title: "Care Recommendations"),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _CareRecommendationCard(name: 'Spark Plug', imagePath: 'assets/images/Care_Page_Picture/Care_Recommendations/Spark_Plug.png'),
                  _CareRecommendationCard(name: 'Clutch Shoe', imagePath: 'assets/images/Care_Page_Picture/Care_Recommendations/Clutch_Shoe.png'),
                  _CareRecommendationCard(name: 'Hose Fuel', imagePath: 'assets/images/Care_Page_Picture/Care_Recommendations/Hose_Fuel.png'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Buy Service Packages Section (For Care Page )
            const SectionHeader(title: "Buy Service Packages"),
            const SizedBox(height: 8),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.8, // কার্ডের অনুপাত
              children: const [
                _ServicePackageCard(name: 'Annual Maintenance', currentPrice: '₹ 900', oldPrice: '₹ 1,000', discount: '10% Off', imagePath: 'assets/images/Buy_Service_Packages/Annual_Maintenance.png'),
                _ServicePackageCard(name: 'Teflon Coating', currentPrice: '₹ 1350', oldPrice: '₹ 1500', discount: '10% Off', imagePath: 'assets/images/Buy_Service_Packages/Teflon_Coating.png'),
                _ServicePackageCard(name: 'Annual Maintenance', currentPrice: '₹ 900', oldPrice: '₹ 1,000', discount: '10% Off', imagePath: 'assets/images/Care_Page_Picture/Buy_Service_Packages/Annual_Maintenance1.png'),
                _ServicePackageCard(name: 'Teflon Coating', currentPrice: '₹ 1350', oldPrice: '₹ 1500', discount: '10% Off', imagePath: 'assets/images/Care_Page_Picture/Buy_Service_Packages/Teflon_Coating1.png'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Care Recommendation Card
class _CareRecommendationCard extends StatelessWidget {
  final String name;
  final String imagePath;
  const _CareRecommendationCard({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(imagePath, height: 70),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: GoogleFonts.inter(color: const Color(0xFF666666), fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// Service Package Card
class _ServicePackageCard extends StatelessWidget {
  final String name;
  final String currentPrice;
  final String oldPrice;
  final String discount;
  final String imagePath;

  const _ServicePackageCard({required this.name, required this.currentPrice, required this.oldPrice, required this.discount, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(currentPrice, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(width: 8),
            Text(oldPrice, style: GoogleFonts.inter(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12)),
            const SizedBox(width: 8),
            Text(discount, style: GoogleFonts.inter(color: Colors.purple.shade700, fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}


// --- (৫) Placeholder Page ---

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title Page Content',
        style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
    );
  }
}