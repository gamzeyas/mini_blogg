import 'package:flutter/material.dart';
import 'package:mini_blog/models/blog.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({required this.blog, Key? key}) : super(key: key);
  final Blog blog;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: Image.network(blog.thumbnail!))),
            ListTile(
              title: Text(blog.title!),
              subtitle: Text(blog.author!),
            )
          ],
        ),
      ),
    );
  }
}