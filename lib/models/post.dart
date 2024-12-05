class Post {
  int idPost;
  int idUser;
  String media;
  String caption;

  Post({
    required this.idPost,
    required this.idUser,
    required this.media,
    required this.caption,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      idPost: json['id_post'],
      idUser: json['id_user'],
      media: json['media'],
      caption: json['caption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_post': idPost,
      'id_user': idUser,
      'media': media,
      'caption': caption,
    };
  }
}
