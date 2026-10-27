
import 'package:flutter/material.dart';

void main() {
  runApp(const NatterApp());
}

const Color bg = Color(0xFF0D0D12);
const Color panel = Color(0xFF171720);
const Color purple = Color(0xFF8B5CF6);
const Color muted = Color(0xFF9292A5);

class NatterApp extends StatelessWidget {
  const NatterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Natter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      home: const NatterHome(),
    );
  }
}

class Chat {
  final String name;
  final String message;
  final String time;
  final String initials;
  final Color avatarColor;
  final int unread;
  final bool online;
  final bool verified;
  final bool read;

  const Chat({
    required this.name,
    required this.message,
    required this.time,
    required this.initials,
    required this.avatarColor,
    this.unread = 0,
    this.online = false,
    this.verified = false,
    this.read = false,
  });
}

const List<Chat> sampleChats = [
  Chat(
    name: 'Aarav Sharma',
    message: 'That sounds like a great idea!',
    time: 'Now',
    initials: 'AS',
    avatarColor: Color(0xFF7656D6),
    unread: 2,
    online: true,
    verified: true,
  ),
  Chat(
    name: 'Priya Verma',
    message: 'Did you check the latest design?',
    time: '2m',
    initials: 'PV',
    avatarColor: Color(0xFFCE668F),
    unread: 1,
    online: true,
  ),
  Chat(
    name: 'Dev Community',
    message: 'Rahul: The build is ready 🚀',
    time: '12m',
    initials: 'DC',
    avatarColor: Color(0xFF318A83),
    unread: 5,
    verified: true,
  ),
  Chat(
    name: 'Ananya Singh',
    message: 'Thank you so much!',
    time: '34m',
    initials: 'AS',
    avatarColor: Color(0xFFD18A45),
    read: true,
  ),
  Chat(
    name: 'Project Team',
    message: 'You: I will share the files shortly.',
    time: '1h',
    initials: 'PT',
    avatarColor: Color(0xFF527CBF),
    read: true,
  ),
  Chat(
    name: 'Kabir Khan',
    message: 'Voice message',
    time: '3h',
    initials: 'KK',
    avatarColor: Color(0xFF9465AE),
    online: true,
  ),
  Chat(
    name: 'Sneha Gupta',
    message: 'See you tomorrow 👋',
    time: 'Yesterday',
    initials: 'SG',
    avatarColor: Color(0xFF4D9A69),
  ),
];

class NatterHome extends StatefulWidget {
  const NatterHome({super.key});

  @override
  State<NatterHome> createState() => _NatterHomeState();
}

class _NatterHomeState extends State<NatterHome> {
  int selectedTab = 0;
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = sampleChats.where((chat) {
      return chat.name.toLowerCase().contains(query.toLowerCase()) ||
          chat.message.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedTab,
          children: [
            _buildChats(filtered),
            _buildSimplePage(
              Icons.people_outline_rounded,
              'Communities',
              'Your groups and communities will appear here.',
            ),
            _buildSimplePage(
              Icons.call_outlined,
              'Calls',
              'Your recent calls will appear here.',
            ),
            _buildProfile(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF111117),
          border: Border(
            top: BorderSide(color: Color(0xFF262631)),
          ),
        ),
        child: NavigationBar(
          backgroundColor: const Color(0xFF111117),
          indicatorColor: purple.withValues(alpha: 0.17),
          selectedIndex: selectedTab,
          onDestinationSelected: (index) {
            setState(() => selectedTab = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              selectedIcon: Icon(Icons.chat_bubble_rounded),
              label: 'Chats',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline_rounded),
              selectedIcon: Icon(Icons.people_rounded),
              label: 'Groups',
            ),
            NavigationDestination(
              icon: Icon(Icons.call_outlined),
              selectedIcon: Icon(Icons.call_rounded),
              label: 'Calls',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChats(List<Chat> chats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 12),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [purple, Color(0xFF5D38C9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.forum_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'natter',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.2,
                      ),
                    ),
                    Text(
                      'YOUR PEOPLE, YOUR SPACE',
                      style: TextStyle(
                        color: muted,
                        fontSize: 9,
                        letterSpacing: 1.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _showNotice('Notifications'),
                icon: const Icon(Icons.notifications_none_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: panel,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Container(
            height: 53,
            decoration: BoxDecoration(
              color: panel,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFF252531)),
            ),
            child: TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: const InputDecoration(
                hintText: 'Search conversations...',
                hintStyle: TextStyle(color: muted, fontSize: 14),
                prefixIcon: Icon(Icons.search_rounded, color: muted),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                  ),
                ),
              ),
              Text(
                '${chats.length} chats',
                style: const TextStyle(color: muted, fontSize: 12),
              ),
              const SizedBox(width: 10),
              IconButton(
                tooltip: 'New message',
                onPressed: () => _showNotice('New conversation'),
                icon: const Icon(Icons.edit_square, color: purple),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 94,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            scrollDirection: Axis.horizontal,
            children: [
              _story(
                'Your status',
                const Color(0xFF282536),
                '+',
                isAdd: true,
              ),
              ...sampleChats
                  .where((chat) => chat.online)
                  .map(
                    (chat) => _story(
                      chat.name.split(' ').first,
                      chat.avatarColor,
                      chat.initials,
                      online: true,
                    ),
                  ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
          child: Row(
            children: [
              Icon(Icons.circle, color: purple, size: 7),
              SizedBox(width: 7),
              Text(
                'ALL CONVERSATIONS',
                style: TextStyle(
                  color: muted,
                  fontSize: 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: chats.isEmpty
              ? const Center(
                  child: Text(
                    'No conversations found',
                    style: TextStyle(color: muted),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 12),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return _chatTile(chats[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _story(
    String name,
    Color color,
    String initials, {
    bool online = false,
    bool isAdd = false,
  }) {
    return SizedBox(
      width: 76,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 57,
                height: 57,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: online ? purple : const Color(0xFF343442),
                    width: online ? 2 : 1,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: color,
                  child: isAdd
                      ? const Icon(Icons.add, color: Colors.white, size: 25)
                      : Text(
                          initials,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              if (online)
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: const Color(0xFF37D99A),
                      shape: BoxShape.circle,
                      border: Border.all(color: bg, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, color: muted),
          ),
        ],
      ),
    );
  }

  Widget _chatTile(Chat chat) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(chat: chat),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: chat.avatarColor,
                  child: Text(
                    chat.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (chat.online)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: const Color(0xFF37D99A),
                        shape: BoxShape.circle,
                        border: Border.all(color: bg, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          chat.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (chat.verified) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified_rounded,
                          color: purple,
                          size: 14,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    chat.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: chat.unread > 0 ? Colors.white70 : muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.time,
                  style: TextStyle(
                    color: chat.unread > 0 ? purple : muted,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 8),
                if (chat.unread > 0)
                  Container(
                    constraints: const BoxConstraints(minWidth: 20),
                    height: 20,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${chat.unread}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                else if (chat.read)
                  const Icon(
                    Icons.done_all_rounded,
                    color: purple,
                    size: 16,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimplePage(IconData icon, String title, String description) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: purple, size: 58),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: muted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              color: purple.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 50,
              color: purple,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Your Natter profile',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your account details will appear here.',
            style: TextStyle(color: muted),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _showNotice('Settings'),
            icon: const Icon(Icons.settings_outlined),
            label: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _showNotice(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title will be implemented in a later step.'),
        backgroundColor: panel,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final messages = <String>[
    'Hey! How are you doing?',
    'Doing great! Working on something exciting.',
    'That sounds like a great idea!',
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111117),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.chat.avatarColor,
              child: Text(widget.chat.initials),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.chat.online ? 'Online' : 'Natter conversation',
                    style: const TextStyle(color: muted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              'TODAY',
              style: TextStyle(
                color: muted,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final mine = index == 1;
                return Align(
                  alignment:
                      mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 285),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: mine ? purple : panel,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(17),
                        topRight: const Radius.circular(17),
                        bottomLeft: Radius.circular(mine ? 17 : 4),
                        bottomRight: Radius.circular(mine ? 4 : 17),
                      ),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: muted,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Write a message...',
                        hintStyle: const TextStyle(color: muted),
                        filled: true,
                        fillColor: panel,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: sendMessage,
                    style: IconButton.styleFrom(
                      backgroundColor: purple,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.arrow_upward_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(text);
    });
    controller.clear();
  }
}
