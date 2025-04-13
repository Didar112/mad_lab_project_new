class NewsArticle {
  final String title;
  final String description;
  final String content;
  final String imageUrl;

  NewsArticle({
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'urlToImage': imageUrl,
    };
  }
}