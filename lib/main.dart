import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sub_space/screens/main_dashboard/main_dashboard.dart';
import 'package:sub_space/services/blog_posts_controller.dart';

import 'dataclass/blog.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BlogPostsController>(
          create: (_) => BlogPostsController(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const MainDashboard(),
      ),
    );
  }
}
