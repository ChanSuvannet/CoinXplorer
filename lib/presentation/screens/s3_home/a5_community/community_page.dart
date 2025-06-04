import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class Post {
  final String id;
  final String avatar;
  final String name;
  final String time;
  final String content;
  final List<String>? imagePaths;
  final int replies;
  final int likes;
  final bool isVerified;

  Post({
    required this.id,
    required this.avatar,
    required this.name,
    required this.time,
    required this.content,
    this.imagePaths,
    required this.replies,
    required this.likes,
    this.isVerified = false,
  });
}

class _CommunityPageState extends State<CommunityPage> {
  String activeTab = 'for-you';

  final posts = [
    Post(
      id: '1',
      avatar: 'assets/images/chihay.png',
      name: 'Chihay',
      time: '33m',
      content: 'I will buy 10 million of btc.',
      replies: 26,
      likes: 112,
      isVerified: true,
    ),
    Post(
      id: '2',
      avatar: 'assets/images/chan.png',
      name: 'Chan Suvannet',
      time: '53m',
      content: '👍',
      replies: 5,
      likes: 23,
      isVerified: true,
    ),
    Post(
      id: '3',
      avatar: 'assets/images/enxxx.png',
      name: 'Enxxx',
      time: '33m',
      content: 'hey, boy 👀',
      imagePaths: ['assets/images/post.png', 'assets/images/post2.png'],
      replies: 12,
      likes: 45,
      isVerified: true,
    ),
  ];

  Widget buildPost(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(post.avatar),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      post.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (post.isVerified)
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ),
                    const Spacer(),
                    Text(post.time, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(width: 5),
                    const Icon(Icons.more_horiz),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(post.content),
          if (post.imagePaths != null && post.imagePaths!.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: post.imagePaths!.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder:
                    (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        post.imagePaths![index],
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
              ),
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.favorite_border),
              Icon(Icons.chat_bubble_outline),
              Icon(Icons.repeat),
              Icon(Icons.send),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${post.replies} replies • ${post.likes} likes',
            style: const TextStyle(color: Colors.grey),
          ),
          const Divider(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Community',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.diamond_outlined, color: Colors.blue),
          SizedBox(width: 20),
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 16),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/senghak.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Row(
            children:
                ['for-you', 'following'].map((tab) {
                  final isActive = tab == activeTab;
                  return Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => activeTab = tab),
                      child: Column(
                        children: [
                          Text(
                            tab == 'for-you' ? 'For you' : 'Following',
                            style: TextStyle(
                              color: isActive ? Colors.black : Colors.grey,
                            ),
                          ),
                          if (isActive)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 2,
                              width: 20,
                              color: Colors.black,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
          const Divider(height: 1),
          Expanded(
            child:
                activeTab == 'for-you'
                    ? ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) => buildPost(posts[index]),
                    )
                    : const Center(
                      child: Text(
                        'Following feed content',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
