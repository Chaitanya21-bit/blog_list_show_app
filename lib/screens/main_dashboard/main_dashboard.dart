import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_space/screens/main_dashboard/components/posts_card.dart';

import '../../dataclass/blog.dart';
import '../../services/blog_posts_controller.dart';
import '../../widgets/navigation_drawer_widget.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BlogPostsController>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Subspace",
                style:
                    TextStyle(
                        fontSize: 30, color: Colors.white, fontWeight: FontWeight.w800),
              ),

            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 15.0,

          bottom: TabBar(
            onTap: controller.setFavourite,
            tabs: const [
              Tab(icon: Text("All")),
              Tab(icon: Text("Favourites")),
            ],
          ),

        ),
        body: Consumer<BlogPostsController>(
          builder: (BuildContext context, blogPostsController, Widget? child) {
            if (blogPostsController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: blogPostsController.posts.length,
                itemBuilder: (context, index) {
                  if (blogPostsController.showFav) {
                    if (blogPostsController.posts[index].isFavourite) {
                      return PostCard(index: index);
                    }
                    return const SizedBox();
                  }
                  return PostCard(index: index);
                });
          },
        ),
        drawer: const NavigationDrawerWidget(),
      ),
    );
  }
}
