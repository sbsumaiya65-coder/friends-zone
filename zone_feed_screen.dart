import 'package:flutter/material.dart';
import '../coin_referral_manager.dart';

class ZoneFeedScreen extends StatefulWidget {
  const ZoneFeedScreen({super.key});

  @override
  State<ZoneFeedScreen> createState() => _ZoneFeedScreenState();
}

class _ZoneFeedScreenState extends State<ZoneFeedScreen> {
  int _currentCoins = 0;

  // ডামি পোস্ট ডাটা
  final List<Map<String, dynamic>> _posts = [
    {
      'username': 'Royal_Raihan',
      'caption': 'Enjoying the vibe at Friends Zone! 🚀 #ZoneVibes',
      'type': 'image',
      'mediaUrl': 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23',
      'likes': 124,
      'comments': 45,
      'shares': 12,
      'isLiked': false,
    },
    {
      'username': 'CyberQueen',
      'caption': 'Check out this epic gaming setup! Earning FZ Tokens daily 💎',
      'type': 'video',
      'mediaUrl': 'https://images.unsplash.com/photo-1550745165-9bc0b252726f',
      'likes': 350,
      'comments': 89,
      'shares': 28,
      'isLiked': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    int coins = await CoinReferralManager.getCoins();
    setState(() {
      _currentCoins = coins;
    });
  }

  // নির্দিষ্ট অ্যাকশনের জন্য টোকেন যোগ করার ফাংশন
  Future<void> _rewardUser(int amount, String actionType) async {
    int newCoins = await CoinReferralManager.addCoins(amount);
    setState(() {
      _currentCoins = newCoins;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('+$amount FZ Tokens earned for $actionType!'),
        backgroundColor: const Color(0xFFFF2E93),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF0F051D);
    const Color cardColor = Color(0xFF1A0B2E);
    const Color neonPink = Color(0xFFFF2E93);
    const Color goldColor = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text(
          'Zone Feed & Earn',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: goldColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: goldColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: goldColor, size: 16),
                const SizedBox(width: 4),
                Text(
                  '$_currentCoins',
                  style: const TextStyle(color: goldColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: neonPink.withOpacity(0.3), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: neonPink,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    post['username'],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Active now • Pro User', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  trailing: const Icon(Icons.more_vert, color: Colors.white54),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    post['caption'],
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 8),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      post['mediaUrl'],
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (post['type'] == 'video')
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                          border: Border.all(color: goldColor, width: 2),
                        ),
                        child: const Icon(Icons.play_arrow, color: goldColor, size: 30),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Like button (1 Token)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            post['isLiked'] = !post['isLiked'];
                            if (post['isLiked']) {
                              post['likes']++;
                              _rewardUser(1, 'Like'); // ১ টোকেন
                            } else {
                              post['likes']--;
                            }
                          });
                        },
                        icon: Icon(
                          post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                          color: post['isLiked'] ? neonPink : Colors.white,
                        ),
                        label: Text('${post['likes']}', style: const TextStyle(color: Colors.white)),
                      ),
                      // Comment button (1 Token)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            post['comments']++;
                          });
                          _rewardUser(1, 'Comment'); // ১ টোকেন
                        },
                        icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                        label: Text('${post['comments']}', style: const TextStyle(color: Colors.white)),
                      ),
                      // Share button (2 Tokens)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            post['shares']++;
                          });
                          _rewardUser(2, 'Share'); // ২ টোকেন
                        },
                        icon: const Icon(Icons.share, color: Colors.white),
                        label: Text('${post['shares']}', style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
