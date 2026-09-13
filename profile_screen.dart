import 'package:flutter/material.dart';
import '../coin_referral_manager.dart'; // ম্যানেজার ফাইল ইম্পোর্ট

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _coins = 0;
  int _referrals = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // ডাটা লোড করার ফাংশন
  Future<void> _loadUserData() async {
    int coins = await CoinReferralManager.getCoins();
    int referrals = await CoinReferralManager.getReferrals();
    setState(() {
      _coins = coins;
      _referrals = referrals;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF0F051D);
    const Color cardColor = Color(0xFF1A0B2E);
    const Color neonPink = Color(0xFFFF2E93);
    const Color goldColor = Color(0xFFFFD700);

    // রেফারের ওপর ভিত্তি করে প্রোগ্রেস হিসাব (সর্বোচ্চ ১০০)
    double progressValue = (_referrals / 100).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text(
          'My Profile & Rewards',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ইউজারের বেসিক প্রোফাইল কার্ড
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: neonPink.withOpacity(0.5), width: 1.5),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: neonPink,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Biplob Hossain',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID: FZ-992026',
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        // কয়েন ব্যালেন্স সেকশন
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: goldColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: goldColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.monetization_on, color: goldColor, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                'Zone Coins: $_coins',
                                style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // রেফারেল ও মাইলস্টোন রিওয়ার্ড সেকশন
            const Text(
              'Refer & Unlock Rewards',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Invite friends to unlock legendary features!',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  
                  // প্রোগ্রেস বার
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Referrals: $_referrals / 100', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('${(progressValue * 100).toInt()}% Completed', style: const TextStyle(color: neonPink)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation<Color>(neonPink),
                  ),
                  
                  const SizedBox(height: 20),

                  // মাইলস্টোন লিস্ট
                  _buildMilestoneItem('5 Referrals', 'Animated Emojis & Bubble Text', _referrals >= 5),
                  _buildMilestoneItem('10 Referrals', 'Royal Gold VIP Badge', _referrals >= 10),
                  _buildMilestoneItem('15 Referrals', 'Radar Highlight & Custom Theme', _referrals >= 15),
                  _buildMilestoneItem('20 Referrals', 'Diamond Room Host Access', _referrals >= 20),
                  
                  // স্পেশাল ১০০ রেফার মেগাস্টার মাইলস্টোন
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF2E93), Color(0xFFFFD700)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _referrals >= 100 ? Icons.star : Icons.lock,
                          color: Colors.white,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '100 Referrals: God-Tier Entrance Animation',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(
                                'Unlock legendary fireworks & permanent crown border!',
                                style: TextStyle(color: Colors.white70, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildMilestoneItem(String title, String desc, bool isUnlocked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(
            isUnlocked ? Icons.check_circle : Icons.lock_outline,
            color: isUnlocked ? Colors.greenAccent : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: isUnlocked ? Colors.white : Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
