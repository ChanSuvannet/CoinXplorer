class Video {
  final String id;
  final String username;
  final String title;
  final String thumbnailUrl;
  final int views;
  final int likes;
  final int comments;
  final Duration duration;

  Video({
    required this.id,
    required this.username,
    required this.title,
    required this.thumbnailUrl,
    required this.views,
    required this.likes,
    required this.comments,
    required this.duration,
  });
}