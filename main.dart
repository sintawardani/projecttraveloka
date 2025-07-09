import 'package:flutter/material.dart';

void main() {
  runApp(const TravelokaApp());
}

// Model Data
class Hotel {
  final String id;
  final String name;
  final String location;
  final double rating;
  final int price;
  final String imageUrl;
  final List<String> facilities;

  const Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.facilities,
  });
}

class Flight {
  final String id;
  final String airline;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String departureAirport;
  final String arrivalAirport;
  final int price;
  final String imageUrl;

  const Flight({
    required this.id,
    required this.airline,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.price,
    required this.imageUrl,
  });
}

// Main App
class TravelokaApp extends StatelessWidget {
  const TravelokaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traveloka Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          secondary: Colors.orange,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Search Bar Widget
class TravelSearchBar extends StatelessWidget {
  const TravelSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Where do you want to go?',
                border: InputBorder.none,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// Hotel Card Widget
class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback onTap;

  const HotelCard({
    super.key,
    required this.hotel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                hotel.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Icon(Icons.hotel, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hotel.location,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        hotel.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      Text(
                        'Rp${hotel.price.toStringAsFixed(0)}/night',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
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

// Hotel Detail Screen
class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              hotel.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 250,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 250,
                color: Colors.grey[200],
                child: const Icon(Icons.hotel, size: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        hotel.location,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        hotel.rating.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        'Rp${hotel.price.toStringAsFixed(0)}/night',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Facilities',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: hotel.facilities
                        .map(
                          (facility) => Chip(
                        label: Text(facility),
                        backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      ),
                    )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Booking Confirmation'),
                            content: Text('Book ${hotel.name} for Rp${hotel.price.toStringAsFixed(0)}/night?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Successfully booked ${hotel.name}'),
                                    ),
                                  );
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Book Now'),
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

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Hotel> hotels = const [
    Hotel(
      id: '1',
      name: 'Grand Hyatt Jakarta',
      location: 'Jakarta, Indonesia',
      rating: 4.8,
      price: 1500000,
      imageUrl: 'https://via.placeholder.com/400x300?text=Hotel+1',
      facilities: ['Free WiFi', 'Swimming Pool', 'Restaurant', 'Spa'],
    ),
    Hotel(
      id: '2',
      name: 'The Ritz-Carlton Bali',
      location: 'Bali, Indonesia',
      rating: 4.9,
      price: 2500000,
      imageUrl: 'https://via.placeholder.com/400x300?text=Hotel+2',
      facilities: ['Free WiFi', 'Beach Access', 'Restaurant', 'Spa'],
    ),
    Hotel(
      id: '3',
      name: 'JW Marriott Hotel',
      location: 'Surabaya, Indonesia',
      rating: 4.7,
      price: 1200000,
      imageUrl: 'https://via.placeholder.com/400x300?text=Hotel+3',
      facilities: ['Free WiFi', 'Gym', 'Restaurant', 'Meeting Room'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traveloka Clone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile page coming soon!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TravelSearchBar(),
              const SizedBox(height: 24),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: [
                  _buildCategoryItem(
                    context,
                    Icons.hotel,
                    'Hotels',
                    Colors.blue,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelListScreen(hotels: hotels),
                        ),
                      );
                    },
                  ),
                  _buildCategoryItem(
                    context,
                    Icons.flight,
                    'Flights',
                    Colors.green,
                        () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Flight feature coming soon!')),
                      );
                    },
                  ),
                  _buildCategoryItem(
                    context,
                    Icons.attractions,
                    'Attractions',
                    Colors.orange,
                        () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Attractions feature coming soon!')),
                      );
                    },
                  ),
                  _buildCategoryItem(
                    context,
                    Icons.directions_car,
                    'Car Rental',
                    Colors.purple,
                        () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Car rental feature coming soon!')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Popular Hotels',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  return HotelCard(
                    hotel: hotels[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelDetailScreen(hotel: hotels[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context,
      IconData icon,
      String label,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

// Hotel List Screen
class HotelListScreen extends StatelessWidget {
  final List<Hotel> hotels;

  const HotelListScreen({super.key, required this.hotels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return HotelCard(
            hotel: hotels[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HotelDetailScreen(hotel: hotels[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}