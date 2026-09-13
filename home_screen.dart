import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'chat_screen.dart'; // চ্যাট স্ক্রিন ইম্পোর্ট করা হলো

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isScanning = false;
  
  // ডামি নিয়ারবাই ডাটা (রয়্যাল পিংক ও নিয়ন রোজ থিমযুক্ত)
  final List<Map<String, dynamic>> _nearbyUsers = [
    {"name": "Tanvir Ahmed", "distance": "120m away", "status": "Coding in Flutter 💻", "color": Colors.pinkAccent},
    {"name": "Nusrat Jahan", "distance": "350m away", "status": "Exploring Hardinge Bridge 🌉", "color": Colors.purpleAccent},
    {"name": "Rakibul Islam", "distance": "500m away", "status": "Coffee & Chill ☕", "color": Colors.deepOrangeAccent},
    {"name": "Sadia Mim", "distance": "850m away", "status": "Listening to Music 🎧", "color": Colors.pink},
  ];

  Future<void> _triggerRadarScan() async {
    setState(() {
      _isScanning = true;
    });

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F051D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F051D),
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.radar, color: Color(0xFFFF2E93)),
            SizedBox(width: 8),
            Text(
              'Friends Zone : Nearby',
              style: TextStyle(
                color: Color(0xFFFF2E93),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bolt, color: Color(0xFFFF2E93)),
            onPressed: _triggerRadarScan,
            tooltip: "Rescan Area",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // টপ রাডার স্ট্যাটাস কার্ড
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFFFF2E93).withOpacity(0.2), const Color(0xFF0F051D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFF2E93).withOpacity(0.4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Live Radar Active",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Showing friends within 1km radius",
                        style: TextStyle(color: Colors.white64, fontSize: 12),
                      ),
                    ],
                  ),
                  _isScanning
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Color(0xFFFF2E93), strokeWidth: 2),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF2E93),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: _triggerRadarScan,
                          child: const Text("Scan", style: TextStyle(color: Colors.white)),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "People Around You (আশেপাশের বন্ধুরা)",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            // নিয়ারবাই ইউজারদের প্রিমিয়াম লিস্ট গ্রিড
            Expanded(
              child: ListView.builder(
                itemCount: _nearbyUsers.length,
                itemBuilder: (context, index) {
                  final user = _nearbyUsers[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.pink.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: const Color(0xFFFF2E93),
                          child: Text(
                            user["name"][0],
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user["name"],
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                user["status"],
                                style: TextStyle(color: Colors.pink[200], fontSize: 12),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 12, color: Color(0xFFFF2E93)),
                                  const SizedBox(width: 4),
                                  Text(
                                    user["distance"],
                                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFFFF2E93)),
                          onPressed: () {
                            // চ্যাট স্ক্রিনে নেভিগেট করা
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(userName: user["name"]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
