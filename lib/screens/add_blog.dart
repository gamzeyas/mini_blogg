import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  XFile? selectedImage;
  String title = "";
  String content = "";
  String author = "";
  submit() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    var request = http.MultipartRequest("POST", url);

    request.fields["title"] = title;
    request.fields["content"] = content;
    request.fields["author"] = author;
    if (selectedImage != null) {
      http.MultipartFile file =
          await http.MultipartFile.fromPath("File", selectedImage!.path);
      request.files.add(file);
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
    }
  }

  pickImage() async {
    XFile? selectedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = selectedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni blog ekle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                if (selectedImage != null)
                  Image.file(File(selectedImage!.path)),
                ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: Text("Fotoğraf seç")),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen bir blog başlığı giriniz";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    title = newValue!;
                  },
                  decoration:
                      const InputDecoration(label: Text("Blog başlığı")),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen bir blog içeriği giriniz";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    content = newValue!;
                  },
                  maxLines: 5,
                  decoration:
                      const InputDecoration(label: Text("Blog İçeriği")),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen bir ad soyad giriniz";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    author = newValue!;
                  },
                  decoration: const InputDecoration(label: Text("Ad Soyad")),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // forumun valid olduğu durum
                        _formKey.currentState!.save();
                        submit();
                      }
                    },
                    child: const Text("Blog Ekle"))
              ],
            )),
      ),
    );
  }
}