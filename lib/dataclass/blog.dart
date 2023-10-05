
import 'package:hive/hive.dart';
part 'blog.g.dart';
@HiveType(typeId: 1)
class Blog {

  @HiveField(0)
  String id;
  @HiveField(1)
  String imageUrl;
  @HiveField(2)
  String title;
  @HiveField(3)
  bool isFavourite;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.isFavourite
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    imageUrl: json["image_url"],
    title: json["title"],
    isFavourite: false
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "title": title,
    "isFavourite": isFavourite
  };
}
