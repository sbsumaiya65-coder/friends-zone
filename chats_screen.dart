import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  const ChatScreen({super.key, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  
  // প্রিমিয়াম চ্যাট ডাটা (ইমোজি অবতার ও ভয়েস নোট সাপোর্টেড)
  final List<Map<String, dynamic>> _messages = [
    {"text": "Hello! Welcome to Friends Zone! 💖", "isMe": false, "time": "1:10 PM", "type": "text"},
    {"text": "语音 Voice Message (0:12s) 🎙️", "isMe": false, "time": "1:11 PM", "type": "voice"},
    {"text": "Hi! Loving this Chamet-style vibe. Let's chat!", "isMe": true, "time": "1:12 PM", "type": "text"},
  ];

  void _sendMessage({String type = "text"}) {
    if (type == "text" && _messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        "text": type == "voice" ? "Voice Message (0:08s) 🎙️" : type == "file" ? "Shared an Image/File 📁" : _messageController.text.trim(),
        "isMe": true,
        "time": "Just now",
        "type": type,
      });
      if (type == "text") _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F051D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F051D),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFFF2E93)),
        title: Row(
          children: [
            // ইউনিক ইমোজি অবতার (Chamet Style)
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFFF2E93),
              child: Text("👑", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "🟢 Online • Chamet VIP Room",
                  style: TextStyle(color: Colors.pinkAccent, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // চ্যাট ম্যাসেজ লিস্ট
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isMe = msg["isMe"] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFFFF2E93) : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 16),
                      ),
                      border: isMe ? null : Border.all(color: Colors.pink.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg["text"],
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg["time"],
                          style: TextStyle(
                            color: isMe ? Colors.white70 : Colors.white38,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // প্রিমিয়াম ইনপুট বার (ভয়েস, ফাইল, টেক্সট ও সেন্ড বাটন)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: Colors.black.withOpacity(0.4),
            child: Row(
              children: [
                // ফাইল বা ছবি পাঠানোর বাটন
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Color(0xFFFF2E93)),
                  onPressed: () => _sendMessage(type: "file"),
                  tooltip: "Share File/Image",
                ),
                // ভয়েস নোট পাঠানোর বাটন
                IconButton(
                  icon: const Icon(Icons.mic, color: Color(0xFFFF2E93)),
                  onPressed: () => _sendMessage(type: "voice"),
                  tooltip: "Send Voice Note",
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message... / মেসেজ...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                CircleAvatar(
                  backgroundColor: const Color(0xFFFF2E93),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () => _sendMessage(type: "text"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
