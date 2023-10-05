import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:sub_space/dataclass/blog.dart';

import '../constants.dart';
import 'api_service.dart';

class BlogPostsController extends ChangeNotifier {
  final List<Blog> _postsList = [];
  List<Blog> get posts => _postsList;



  bool _isLoading = true;
  bool get isLoading => _isLoading;


  bool _showFav = false;
  bool get showFav => _showFav;

  BlogPostsController(){
    initialFetch();
  }


  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setFavourite(int value){
    if(value == 0) {
      _showFav = false;
    } else {
      _showFav = true;
    }

    notifyListeners();
  }



  Future<List<Blog>> fetchPosts() async {
    setLoading(true);
    final response =
        await ApiService.get(baseUrl);
    if (response == null) {
      return [];
    }
    final responseList = response['blogs'] as List;
    final newPostsList = List<Blog>.generate(
        responseList.length, (index) => Blog.fromJson(responseList[index]));
    _postsList.addAll(newPostsList);
    final blogBox = await Hive.openBox<Blog>("blogBox");
    await blogBox.addAll(_postsList);
    setLoading(false);
    return newPostsList;
  }

  Future<void> setBlogFavourite(int index) async {
    posts[index].isFavourite = !posts[index].isFavourite;
    final blogBox = await Hive.openBox<Blog>("blogBox");
    await blogBox.putAt(index, posts[index]);
    notifyListeners();

  }
  initialFetch() async {
    await fetchBlogPostListFromCache();
    if (_postsList.isEmpty) {
      fetchPosts();
    }

  }

  Future<void> fetchBlogPostListFromCache() async {
    setLoading(true);
    final blogBox = await Hive.openBox<Blog>("blogBox");
    _postsList.addAll(blogBox.values);

    setLoading(false);
  }



}
