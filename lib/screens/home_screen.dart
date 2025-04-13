import 'package:flutter/material.dart';
import '../widgets/category_selector.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/news_card.dart';
import '../services/news_service.dart';
import '../services/firebase_service.dart';
import 'bookmark_screen.dart';
import 'news_detail_screen.dart';

class NewsHomePage extends StatefulWidget {
  final Function(bool) onToggleTheme;
  const NewsHomePage({required this.onToggleTheme});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  int _selectedIndex = 0;
  String _currentCategory = 'general';
  List<dynamic> _articles = [];
  bool _isLoading = true;

  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _loadNews(_currentCategory);
  }

  // void _loadNews(String category) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     final articles = await NewsService.fetchNews(category);
  //     setState(() {
  //       _currentCategory = category;
  //       _articles = articles;
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Failed to load news")),
  //     );
  //   }
  // }
  Future<void> _loadNews(String category) async {
    print('📡 Start loading category: $category');
    setState(() {
      _isLoading = true;
    });

    final articles = await NewsService.fetchNews(category);

    print('📦 Articles fetched: ${articles.length}');

    setState(() {
      _articles = articles;
      _isLoading = false;
      print('✅ State updated: Articles assigned, loading false');
    });
  }



  void _bookmarkArticle(article) async {
    await _firebaseService.saveBookmark(article);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bookmarked")),
    );
  }

  Widget _buildHomeTab() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _articles.length,
      // itemBuilder: (context, index) {
      //   return NewsCard(
      //     article: _articles[index],
      //   );
      // },
        itemBuilder: (context, index) {
          final article = _articles[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(
                    title: article['title'] ?? '',
                    content: article['description'] ?? 'No description available.',
                    imageUrl: article['urlToImage'] ?? '',
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(article['title'] ?? 'No Title'),
              subtitle: Text(article['description'] ?? 'No Description'),
              trailing: IconButton(
                icon: Icon(Icons.bookmark_border),
                onPressed: () {
                  FirebaseService().saveBookmark(article);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('🔖 Article saved!')),
                  );
                },
              ),
            ),
          );
        }


    );
  }

  List<Widget> get _screens => [
    _buildHomeTab(),
    BookmarkScreen(),
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
        backgroundColor: Colors.lightBlue,
        title: const Text("Daily Youth"),
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          SizedBox(height: 10,),
          CategorySelector(onCategorySelected: _loadNews),
          Expanded(child: _buildHomeTab(),

          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookmarkScreen()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
        ],
      ),
    );
  }
}