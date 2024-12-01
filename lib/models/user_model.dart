class User {
  final String id;
  final String username;
  final String fullName;
  final String profileImage;
  final int posts;
  final int followers;
  final int following;
  final List<String> images;

  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.profileImage,
    required this.posts,
    required this.followers,
    required this.following,
    required this.images,
  });
}