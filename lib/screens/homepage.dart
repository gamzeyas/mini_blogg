import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:mini_blog/models/blog.dart';
import 'package:mini_blog/screens/add_blog.dart';
import 'package:mini_blog/screens/blog_details.dart';
import 'dart:convert';

import 'package:mini_blog/widgets/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Blog> blogList = [];

  @override
  void initState() {
    super.initState();
 
    fetchBlogs();
  }

  fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);
    setState(() {
      blogList = jsonData.map((json) => Blog.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog Listesi"),
          actions: [
            IconButton(
                onPressed: () async {
                  bool? result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const AddBlog()));
                  if (result == true) {
                    fetchBlogs();
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: blogList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  fetchBlogs();
                },
                child: ListView.builder(
                  itemBuilder: (ctx, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              BlogDetails(blogId: blogList[index].id!)));
                    },
                    child: BlogItem(
                      blog: blogList[index],
                    ),
                  ),
                  itemCount: blogList.length,
                ),
              ));
  }
}