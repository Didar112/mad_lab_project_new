import 'package:flutter/material.dart';
import '../screens/news_detail_screen.dart';

class NewsCard extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(
              title: article['title'] ?? '',
              content: article['content'] ?? article['description'] ?? '',
              imageUrl: article['urlToImage'] ?? '',
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListTile(
          leading: article['urlToImage'] != null
              ? Image.network(article['urlToImage'], width: 100, fit: BoxFit.cover)
              : null,
          title: Text(article['title'] ?? ''),
          subtitle: Text(article['description'] ?? ''),
          trailing: Icon(Icons.arrow_forward_ios, size: 14),
        ),
      ),
    );
  }
}