import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddNewBlogPage(),
              ),
            ),
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Blog page'),
        ),
      ),
    );
  }
}
