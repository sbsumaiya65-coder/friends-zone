import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> with SingleTickerProviderStateMixin {
  bool _isScanning = true;
  
  // রাডার অ্যানিমেশনের জন্য কন্ট্রোলার
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF0F051D);
    const Color neonPink = Color(0xFFFF2E93);
    const Color cardColor = Color(0xFF1A0B2E);
    const Color goldColor = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text(
          'Zone Radar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // রাডার স্ক্যানিং ভিজ্যুয়াল এরিয়া
            Expanded(
              flex: 3,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // আউটার রিং পালস অ্যানিমেশন
                    RotationTransition(
                      turns: _animationController,
                      child: Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: neonPink.withOpacity(0.3), width: 2),
                          gradient: SweepGradient(
                            colors: [
                              neonPink.withOpacity(0.0),
                              neonPink.withOpacity(0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ভেতরের সার্কেল
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cardColor,
                        border: Border.all(color: neonPink.withOpacity(0.6), width: 1.5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.radar,
                          color: neonPink,
                          size: 50,
                        ),
                      ),
                    ),
                    // ডামি নিয়ারবাই ফ্রেন্ড পিন ১
                    Positioned(
                      top: 40,
                      right: 50,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: goldColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person, color: Colors.black, size: 16),
                      ),
                    ),
                    // ডামি নিয়ারবাই ফ্রেন্ড পিন ২
                    Positioned(
                      bottom: 50,
                      left: 60,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: neonPink,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // স্ক্যান স্ট্যাটাস ও কন্ট্রোল বাটন
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isScanning ? 'Scanning nearby friends...' : 'Scan Complete!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Looking for fellow users around your location within 10 meters.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: neonPink,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isScanning = !_isScanning;
                      });
                    },
                    icon: Icon(_isScanning ? Icons.stop : Icons.refresh),
                    label: Text(
                      _isScanning ? 'Stop Radar' : 'Start Scanning',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
