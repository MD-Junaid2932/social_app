import 'dart:math' as math;
import 'package:flutter/material.dart';

const kBlue = Color(0xFF1677F2);
const kNavy = Color(0xFF16254A);
const kMuted = Color(0xFF8C9BB5);
const kLine = Color(0xFFD6E6F8);

const kRing = [
  Color(0xFF1677F2),
  Color(0xFF8E5CF6),
  Color(0xFFFF5FA2),
  Color(0xFF22C1C3),
  Color(0xFF1677F2),
];
const kGoldRing = [
  Color(0xFFFFC53D),
  Color(0xFFFF5FA2),
  Color(0xFF8E5CF6),
  Color(0xFFFFC53D),
];

void main() => runApp(const SocialApp());

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kBlue,
        scaffoldBackgroundColor: const Color(0xFFEAF4FF),
      ),
      home: const MainShell(),
    );
  }
}

// ───────────────────────── Models ─────────────────────────

enum PostType { text, image, poll }

class PollOption {
  final String label;
  int votes;
  PollOption(this.label, this.votes);
}

class Person {
  final String name;
  final List<Color> bg;
  final IconData icon;
  const Person(this.name, this.bg, [this.icon = Icons.person_rounded]);
}

const rakib = Person('Rakib Hasan', [Color(0xFF1B2B3A), Color(0xFF47698C)]);
const sadia = Person('Sadia Islam', [Color(0xFF2A1F2E), Color(0xFF8A5468)]);
const tania = Person('Tania Akter', [Color(0xFF2A1F2E), Color(0xFF9A5A6E)]);
const rofiul = Person('Rofiul Islam', [Color(0xFF1B2B3A), Color(0xFF47698C)]);

class Post {
  final Person person;
  final bool verified;
  final String? tag;
  final String time;
  final String text;
  final PostType type;
  final String? image; // sunrise | books | hills
  final bool following;
  int likes, comments, shares;
  bool liked, saved;
  List<PollOption>? options;
  int? selected;
  String? pollLeft;

  Post({
    required this.person,
    this.verified = false,
    this.tag,
    required this.time,
    required this.text,
    required this.type,
    this.image,
    this.following = true,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.liked = false,
    this.saved = false,
    this.options,
    this.selected,
    this.pollLeft,
  });
}

List<Post> seedPosts() => [
      Post(
        person: rakib,
        verified: true,
        tag: 'My Post',
        time: '2 hours ago',
        text:
            'জীবনের প্রতিটি মুহূর্তউ একটা নতুন পর্ব\nসেই পর্বে দাঁড়ালে তহ হয় মুসাম, আর সেই না পারলে তা হয়\nশুধু তুমি হয়ে যাস! ✨',
        type: PostType.image,
        image: 'sunrise',
        following: false,
        likes: 342,
        comments: 48,
        shares: 22,
        liked: true,
      ),
      Post(
        person: sadia,
        time: '5 hours ago',
        text:
            'আজ একটা নতুন গল্প লিখতে শুরু করলাম।\nকি হবে সেটা জানি না, তবে একটা বেশ ভালো লাগছে! 😊',
        type: PostType.image,
        image: 'books',
        likes: 198,
        comments: 35,
        shares: 12,
      ),
      Post(
        person: tania,
        tag: 'Poll',
        time: '12 hours ago',
        text: 'তোমার সঙ্গে, জীবনের সবচেয়ে গুরুত্বপূর্ণ জিনিস কোনটি?',
        type: PostType.poll,
        likes: 134,
        comments: 46,
        shares: 18,
        liked: true,
        options: [
          PollOption('জ্ঞান / পরিশ্রম', 342),
          PollOption('ভালোবাসা', 298),
          PollOption('বন্ধু', 189),
          PollOption('টাকা / আর্থিক স্বাধীনতা', 142),
        ],
        selected: 1,
        pollLeft: '2 days left',
      ),
      Post(
        person: rofiul,
        time: '14 hours ago',
        text: '@Sabbir বন্ধুই অনেক শান্তি দেয় 😍',
        type: PostType.image,
        image: 'hills',
        likes: 87,
        comments: 12,
        shares: 5,
      ),
    ];

// ───────────────────────── Shell ─────────────────────────

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _tab = 0;

  static const _items = [
    ['Social', Icons.groups_rounded],
    ['Economy', Icons.account_balance_wallet_rounded],
    ['Home', Icons.home_rounded],
    ['Library', Icons.menu_book_rounded],
    ['Profile', Icons.person_rounded],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F1FF), Color(0xFFF4F9FF)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _tab,
            children: [
              const SocialPage(),
              for (var i = 1; i < _items.length; i++)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_items[i][1] as IconData, size: 56, color: kBlue),
                      const SizedBox(height: 12),
                      Text(_items[i][0] as String,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: kNavy)),
                      const SizedBox(height: 4),
                      const Text('Coming soon',
                          style: TextStyle(color: kMuted)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: _tab == 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: kBlue,
                elevation: 6,
                shape: const CircleBorder(),
                child: const Icon(Icons.add_rounded,
                    color: Colors.white, size: 32),
              ),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.96),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: kBlue.withOpacity(0.10),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 66,
            child: Row(
              children: [
                for (var i = 0; i < _items.length; i++) ...[
                  if (i > 0)
                    Container(width: 1, height: 36, color: kLine),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _tab = i),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_items[i][1] as IconData,
                              size: 26,
                              color: _tab == i ? kBlue : kNavy),
                          const SizedBox(height: 2),
                          Text(
                            _items[i][0] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _tab == i ? kBlue : kNavy,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            width: 26,
                            height: 4,
                            decoration: BoxDecoration(
                              color: _tab == i
                                  ? kBlue
                                  : kLine.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Social page ─────────────────────────

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  final List<Post> _posts = seedPosts();
  final TextEditingController _ctrl = TextEditingController();
  int _filter = 0;

  static const _filters = [
    ['All', Icons.grid_view_rounded],
    ['Following', Icons.people_alt_outlined],
    ['Text', Icons.article_outlined],
    ['Image', Icons.image_outlined],
    ['Poll', Icons.bar_chart_rounded],
  ];

  List<Post> get _visible {
    switch (_filter) {
      case 1:
        return _posts.where((p) => p.following).toList();
      case 2:
        return _posts.where((p) => p.type == PostType.text).toList();
      case 3:
        return _posts.where((p) => p.type == PostType.image).toList();
      case 4:
        return _posts.where((p) => p.type == PostType.poll).toList();
      default:
        return _posts;
    }
  }

  void _publish() {
    final t = _ctrl.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _posts.insert(
        0,
        Post(
          person: rakib,
          verified: true,
          tag: 'My Post',
          time: 'Just now',
          text: t,
          type: PostType.text,
          following: false,
        ),
      );
      _ctrl.clear();
    });
    FocusScope.of(context).unfocus();
  }

  void _vote(Post p, int i) {
    if (p.selected == i) return;
    setState(() {
      if (p.selected != null) p.options![p.selected!].votes--;
      p.options![i].votes++;
      p.selected = i;
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = _visible;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 110),
      children: [
        _header(),
        const SizedBox(height: 14),
        _stories(),
        const SizedBox(height: 14),
        _filterRow(),
        const SizedBox(height: 14),
        _composer(),
        const SizedBox(height: 14),
        if (list.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Text('এই ফিল্টারে কোনো পোস্ট নেই',
                  style: TextStyle(color: kMuted, fontSize: 15)),
            ),
          ),
        for (final p in list)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: PostCard(
              post: p,
              onLike: () => setState(() {
                p.liked = !p.liked;
                p.likes += p.liked ? 1 : -1;
              }),
              onSave: () => setState(() => p.saved = !p.saved),
              onVote: (i) => _vote(p, i),
            ),
          ),
      ],
    );
  }

  Widget _header() {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (r) => const LinearGradient(
            colors: [Color(0xFF22C1C3), Color(0xFF1677F2), Color(0xFF6C4CF5)],
          ).createShader(r),
          child: const Icon(Icons.bubble_chart_rounded,
              size: 54, color: Colors.white),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Social',
                  style: TextStyle(
                      fontSize: 30,
                      height: 1.05,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1456B8))),
              Text('Connect  ·  Share  ·  Grow',
                  style: TextStyle(fontSize: 13.5, color: kMuted)),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded, size: 30, color: kBlue),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded,
                  size: 30, color: kBlue),
            ),
            Positioned(
              right: 11,
              top: 9,
              child: Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4D6D),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        Avatar(
          size: 54,
          person: rakib,
          ring: kGoldRing,
          badge: const _Badge(
            color: Color(0xFFFFB400),
            icon: Icons.workspace_premium_rounded,
          ),
        ),
      ],
    );
  }

  Widget _stories() {
    final stories = <List<dynamic>>[
      ['Md. Arif', rakib, const _Badge(color: kBlue, icon: Icons.add_rounded)],
      ['Nusrat', sadia, null],
      ['Jannat', const Person('Jannat', [Color(0xFFB23A1E), Color(0xFFFF8A3D)]), null],
      ['Mim', const Person('Mim', [Color(0xFF6E8F5B), Color(0xFFB9D39A)], Icons.pets), null],
      ['Rafi', const Person('Rafi', [Color(0xFF2E7BC4), Color(0xFF7BC8A0)], Icons.landscape_rounded), null],
    ];
    return SizedBox(
      height: 122,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: 82,
            child: Column(
              children: [
                Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(33),
                    border: Border.all(color: kLine, width: 1.5),
                  ),
                  child: const Icon(Icons.add_rounded, color: kBlue, size: 34),
                ),
                const SizedBox(height: 8),
                const Text('Create\nStory',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13.5,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                        color: kNavy)),
              ],
            ),
          ),
          for (final s in stories)
            SizedBox(
              width: 78,
              child: Column(
                children: [
                  Avatar(
                    size: 68,
                    person: s[1] as Person,
                    ring: kRing,
                    badge: s[2] as Widget?,
                  ),
                  const SizedBox(height: 8),
                  Text(s[0] as String,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kNavy)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _filterRow() {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < _filters.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => setState(() => _filter = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: _filter == i
                        ? kBlue
                        : Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: _filter == i ? kBlue : kLine, width: 1.2),
                    boxShadow: _filter == i
                        ? [
                            BoxShadow(
                              color: kBlue.withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(_filters[i][1] as IconData,
                          size: 22,
                          color: _filter == i ? Colors.white : kBlue),
                      const SizedBox(width: 8),
                      Text(
                        _filters[i][0] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _filter == i ? Colors.white : kNavy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Container(
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kLine, width: 1.2),
            ),
            child: const Icon(Icons.tune_rounded, color: kBlue, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _composer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 14, 10),
      decoration: _cardDeco(),
      child: Row(
        children: [
          Avatar(size: 48, person: rakib, ring: kRing),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF5FD),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _ctrl,
                onSubmitted: (_) => _publish(),
                style: const TextStyle(fontSize: 16, color: kNavy),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "What's on your mind?",
                  hintStyle: TextStyle(color: kMuted, fontSize: 17),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.image_outlined, color: kBlue, size: 28),
          const SizedBox(width: 14),
          const Icon(Icons.bar_chart_rounded, color: kBlue, size: 28),
          const SizedBox(width: 14),
          GestureDetector(
            onTap: _publish,
            child: const Icon(Icons.edit_outlined, color: kBlue, size: 27),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _cardDeco({bool highlight = false}) => BoxDecoration(
      color: Colors.white.withOpacity(0.82),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: highlight ? kBlue.withOpacity(0.85) : Colors.white,
        width: highlight ? 1.6 : 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: kBlue.withOpacity(0.08),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    );

// ───────────────────────── Post card ─────────────────────────

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onSave;
  final void Function(int) onVote;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onSave,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    final p = post;
    final mine = p.tag == 'My Post';
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: _cardDeco(highlight: mine),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(size: 54, person: p.person, ring: kRing),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(p.person.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: kNavy)),
                        ),
                        if (p.verified) ...[
                          const SizedBox(width: 5),
                          const Icon(Icons.verified, color: kBlue, size: 19),
                        ],
                        if (p.tag != null) ...[
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9ECFF),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(p.tag!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kBlue)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(p.time,
                            style: const TextStyle(
                                fontSize: 14, color: kMuted)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('•',
                              style: TextStyle(color: kMuted, fontSize: 14)),
                        ),
                        const Text('Public',
                            style: TextStyle(fontSize: 14, color: kMuted)),
                        const SizedBox(width: 5),
                        const Icon(Icons.public, size: 15, color: kMuted),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: kNavy, size: 26),
            ],
          ),
          const SizedBox(height: 10),
          Text(p.text,
              style: const TextStyle(
                  fontSize: 18.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: kNavy)),
          if (p.image != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _postImage(p.image!),
            ),
          ],
          if (p.type == PostType.poll) ...[
            const SizedBox(height: 12),
            _poll(p),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              _action(
                p.liked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                '${p.likes}',
                p.liked ? const Color(0xFFFF3B5C) : kBlue,
                onLike,
                size: 31,
              ),
              const SizedBox(width: 22),
              _action(Icons.chat_bubble_outline_rounded, '${p.comments}',
                  kBlue, () {}),
              const SizedBox(width: 22),
              _action(Icons.shortcut_rounded, '${p.shares}', kBlue, () {},
                  size: 30),
              const Spacer(),
              GestureDetector(
                onTap: onSave,
                child: Icon(
                  p.saved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: kNavy,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _action(IconData icon, String label, Color color, VoidCallback onTap,
      {double size = 28}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(icon, color: color, size: size),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: kNavy)),
        ],
      ),
    );
  }

  Widget _postImage(String kind) {
    switch (kind) {
      case 'books':
        return const BooksImage();
      case 'hills':
        return const SizedBox(
          height: 130,
          width: double.infinity,
          child: CustomPaint(painter: LandscapePainter(sunset: false)),
        );
      default:
        return const SizedBox(
          height: 215,
          width: double.infinity,
          child: CustomPaint(painter: LandscapePainter(sunset: true)),
        );
    }
  }

  Widget _poll(Post p) {
    final total = p.options!.fold<int>(0, (a, o) => a + o.votes);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < p.options!.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => onVote(i),
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FD),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kLine),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: p.selected == i ? kBlue : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: p.selected == i ? kBlue : kBlue.withOpacity(0.55),
                            width: 2),
                      ),
                      child: p.selected == i
                          ? const Icon(Icons.check_rounded,
                              color: Colors.white, size: 22)
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(p.options![i].label,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: kNavy)),
                              ),
                              Text('${p.options![i].votes} votes',
                                  style: const TextStyle(
                                      fontSize: 14, color: kMuted)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: total == 0 ? 0 : p.options![i].votes / total,
                              minHeight: 8,
                              backgroundColor: const Color(0xFFD3E3F5),
                              valueColor:
                                  const AlwaysStoppedAnimation(kBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 52,
                      child: Text(
                        '${total == 0 ? 0 : (p.options![i].votes * 100 / total).round()}%',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: kBlue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Row(
          children: [
            Text('$total votes',
                style: const TextStyle(fontSize: 14.5, color: kMuted)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('•', style: TextStyle(color: kMuted)),
            ),
            const Icon(Icons.schedule, size: 18, color: kMuted),
            const SizedBox(width: 5),
            Text(p.pollLeft ?? '',
                style: const TextStyle(fontSize: 14.5, color: kMuted)),
          ],
        ),
      ],
    );
  }
}

// ───────────────────────── Avatar & badge ─────────────────────────

class _Badge extends StatelessWidget {
  final Color color;
  final IconData icon;
  const _Badge({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, color: Colors.white, size: 14),
    );
  }
}

class Avatar extends StatelessWidget {
  final double size;
  final Person person;
  final List<Color> ring;
  final Widget? badge;

  const Avatar({
    super.key,
    required this.size,
    required this.person,
    required this.ring,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(colors: ring),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: person.bg,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(person.icon,
                        size: size * 0.72,
                        color: Colors.white.withOpacity(0.92)),
                  ),
                ),
              ),
            ),
          ),
          if (badge != null) Positioned(right: -3, bottom: -3, child: badge!),
        ],
      ),
    );
  }
}

// ───────────────────────── Images ─────────────────────────

class BooksImage extends StatelessWidget {
  const BooksImage({super.key});

  @override
  Widget build(BuildContext context) {
    const words = ['Dream', 'Learn', 'Grow', 'Repeat'];
    const shades = [
      Color(0xFF1B3550),
      Color(0xFF16304A),
      Color(0xFF1F3A58),
      Color(0xFF142B43),
    ];
    return Container(
      height: 176,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7DB85A), Color(0xFF2E6B2B), Color(0xFF8A5A2B)],
          stops: [0, 0.65, 1],
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 4; i++)
                  Container(
                    height: 36,
                    margin: EdgeInsets.only(
                        bottom: 2, left: i.isOdd ? 6 : 0, right: i.isEven ? 6 : 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: shades[i],
                      borderRadius: BorderRadius.circular(3),
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.white.withOpacity(0.35), width: 3),
                      ),
                    ),
                    child: Text(words[i],
                        style: const TextStyle(
                            fontFamily: 'serif',
                            fontSize: 21,
                            color: Color(0xFFEAD9B0))),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            flex: 4,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6EEDD),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Text('Good\nBooks ♥\nBetter\nDays',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 19,
                        height: 1.15,
                        color: Color(0xFF3A2A1A))),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class LandscapePainter extends CustomPainter {
  final bool sunset;
  const LandscapePainter({required this.sunset});

  void _ridge(Canvas c, Size s, double base, double amp, double freq,
      double phase, Color color) {
    final path = Path()..moveTo(0, s.height);
    for (double x = 0; x <= s.width + 6; x += 6) {
      final y = s.height * base +
          math.sin(x / s.width * math.pi * freq + phase) * s.height * amp +
          math.sin(x / s.width * math.pi * freq * 2.3 + phase) *
              s.height *
              amp *
              0.4;
      path.lineTo(x, y);
    }
    path
      ..lineTo(s.width, s.height)
      ..close();
    c.drawPath(path, Paint()..color = color);
  }

  @override
  void paint(Canvas c, Size s) {
    final rect = Offset.zero & s;
    final sky = sunset
        ? const [Color(0xFF2B4C8C), Color(0xFFE98A4B), Color(0xFFFFD98A)]
        : const [Color(0xFF4FA6F0), Color(0xFF9ED3F7), Color(0xFFE6F4FF)];
    c.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: sky,
          stops: const [0, 0.55, 0.85],
        ).createShader(rect),
    );

    if (sunset) {
      final sun = Offset(s.width * 0.62, s.height * 0.46);
      c.drawCircle(
        sun,
        s.height * 0.55,
        Paint()
          ..shader = RadialGradient(colors: [
            const Color(0xFFFFF3C4).withOpacity(0.9),
            const Color(0xFFFFB45A).withOpacity(0.0),
          ]).createShader(Rect.fromCircle(center: sun, radius: s.height * 0.55)),
      );
      c.drawCircle(sun, s.height * 0.07, Paint()..color = const Color(0xFFFFFBE6));
    } else {
      c.drawCircle(Offset(s.width * 0.8, s.height * 0.25), s.height * 0.09,
          Paint()..color = Colors.white.withOpacity(0.85));
    }

    _ridge(c, s, 0.52, 0.05, 3.2, 0.4,
        sunset ? const Color(0xFF5A7FB0) : const Color(0xFF7FB6D8));
    _ridge(c, s, 0.64, 0.06, 2.6, 1.7,
        sunset ? const Color(0xFF3F7A74) : const Color(0xFF5DAE8B));
    _ridge(c, s, 0.78, 0.05, 2.0, 3.0,
        sunset ? const Color(0xFF2D5A3A) : const Color(0xFF3E9A57));

    if (sunset) {
      final river = Path()
        ..moveTo(s.width * 0.55, s.height * 0.66)
        ..quadraticBezierTo(s.width * 0.75, s.height * 0.72, s.width * 0.68,
            s.height * 0.82)
        ..quadraticBezierTo(s.width * 0.62, s.height * 0.92, s.width * 0.9,
            s.height * 1.0);
      c.drawPath(
        river,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xFFFFC27A).withOpacity(0.85),
      );

      // foreground rock
      final rock = Path()
        ..moveTo(0, s.height)
        ..lineTo(0, s.height * 0.78)
        ..quadraticBezierTo(s.width * 0.12, s.height * 0.68, s.width * 0.3,
            s.height * 0.74)
        ..quadraticBezierTo(s.width * 0.42, s.height * 0.8, s.width * 0.5,
            s.height)
        ..close();
      c.drawPath(rock, Paint()..color = const Color(0xFF2A2623));

      // sitting person (silhouette)
      final dark = Paint()..color = const Color(0xFF1B2230);
      c.drawCircle(Offset(s.width * 0.27, s.height * 0.5), s.height * 0.05, dark);
      final body = Path()
        ..moveTo(s.width * 0.23, s.height * 0.56)
        ..quadraticBezierTo(s.width * 0.2, s.height * 0.72, s.width * 0.18,
            s.height * 0.78)
        ..lineTo(s.width * 0.34, s.height * 0.78)
        ..quadraticBezierTo(s.width * 0.36, s.height * 0.66, s.width * 0.32,
            s.height * 0.56)
        ..close();
      c.drawPath(body, dark);
    }
  }

  @override
  bool shouldRepaint(covariant LandscapePainter old) => old.sunset != sunset;
}
