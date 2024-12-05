class Profile {
  final int id;
  final int userId;
  final String name;
  final String bio;
  final String profileImage;

  Profile({
    required this.id,
    required this.userId,
    required this.name,
    required this.bio,
    required this.profileImage,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id_profil'],
      userId: json['id_user'],
      name: json['nama'],
      bio: json['bio'],
      profileImage: json['foto_profil'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_profil': id,
      'id_user': userId,
      'nama': name,
      'bio': bio,
      'foto_profil': profileImage,
    };
  }
}
