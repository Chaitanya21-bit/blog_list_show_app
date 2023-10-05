import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_space/screens/full_detail/full_detail_screen.dart';
import 'package:sub_space/services/blog_posts_controller.dart';

import '../../../dataclass/blog.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<BlogPostsController>(
      builder: (BuildContext context, BlogPostsController blogPostsController,
          Widget? child) {
        final blog = blogPostsController.posts[index];

        return GestureDetector(
          onTap: () => openFullScreen(context, blog),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: Hero(
                        tag: blog.title,
                        child: CachedNetworkImage(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: blog.imageUrl,
                        )),
                  ),
                  SizedBox(height: 2.0),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      blog.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () =>
                          blogPostsController.setBlogFavourite(index),
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                        color: blog.isFavourite ? Colors.red : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  openFullScreen(BuildContext context, Blog blog) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => FullDetails(
                  blog: blog,
                )));
  }
}
