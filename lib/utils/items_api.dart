import 'dart:convert';
import 'package:artsionic_app/utils/itemsState.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Trend {
  final String trend;
  final String news;
  final List<String> relatedTopics;

  const Trend(
      {required this.news, required this.trend, required this.relatedTopics});

  factory Trend.fromJson(Map<String, dynamic> json) {
    return Trend(
      trend: json['trend'],
      news: json['news'],
      relatedTopics: json['relatedTopics'].cast<String>(),
    );
  }
}

Future<String> getTrends() async {
  Uri url = Uri.parse('http://127.0.0.1:7001/getTrends');
  final response = await http.get(url);
  print(response.body);
  return response.body;
}

class ImageGen {
  final String trend;
  final int id;
  final String date;
  final String prompt;
  final Uint8List imageBytes;
  final List<String> image_data;

  const ImageGen(
      {required this.trend,
      required this.date,
      required this.prompt,
      required this.image_data,
      required this.imageBytes,
      required this.id});

  factory ImageGen.fromJson(Map<String, dynamic> json, int idKey) {
    return ImageGen(
      trend: json['trend'],
      date: json['date'],
      prompt: json['prompt'],
      image_data: json['imagedata'].cast<String>(),
      imageBytes: base64.decode(json['b64_img']),
      id: idKey,
    );
  }
}

Future<String> getImages() async {
  Uri url = Uri.parse('http://127.0.0.1:7001/getImgList');
  final response = await http.get(url);
  print(response.body);
  return response.body;
}

Future<String> generateImg(trend) async {
  Uri url = Uri.parse('http://127.0.0.1:7001/generateImg');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'trend': trend,
    }),
  );
  print(response.body);
  return response.body;
}

Future<String> regenerateImg(id) async {
  Uri url = Uri.parse('http://127.0.0.1:7001/regenerateImg');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'id': id,
    }),
  );
  print(response.body);
  return response.body;
}

Future<String> removeImage(id) async {
  Uri url = Uri.parse('http://127.0.0.1:7001/removeImg');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'id': id,
    }),
  );
  print(response.body);
  return response.body;
}

Future<String> removePost(id) async {
  Uri url = Uri.parse('http://127.0.0.1:7001/removePost');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'id': id,
    }),
  );
  print(response.body);
  return response.body;
}

class PostGen {
  final String trend;
  final String date;
  final List<String> image_data;
  final Uint8List imageBytes;
  final String description;
  final List<String> hashtags;
  final int id;
  final String prompt;
  final String title;

  const PostGen(
      {required this.description,
      required this.imageBytes,
      required this.hashtags,
      required this.prompt,
      required this.title,
      required this.trend,
      required this.date,
      required this.image_data,
      required this.id});

  factory PostGen.fromJson(Map<String, dynamic> json, int idKey) {
    return PostGen(
      trend: json['trend'],
      date: json['date'],
      description: json['description'],
      prompt: json['prompt'],
      image_data: json['imagedata'].cast<String>(),
      imageBytes: base64.decode(json['b64_img']),
      title: json['title'],
      hashtags: json['hashtags'].split(" "),
      id: idKey,
    );
  }
}

Future<String> getPosts() async {
  Uri url = Uri.parse('http://127.0.0.1:7001/getPostList');
  final response = await http.get(url);
  print(response.body);
  return response.body;
}

Future<String> generatePost(image_id) async {
  Uri url = Uri.parse('http://127.0.0.1:7001/generatePost');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'image_id': image_id.toString(),
    }),
  );
  print(response.body);
  return response.body;
}

Future<String> uploadPost(post_id) async {
  Uri url = Uri.parse('http://127.0.0.1:7001/uploadPost');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'post_id': post_id.toString(),
    }),
  );
  print(response.body);
  return response.body;
}
// Future<Uint8List> downloadImage(String imageName) async {
//   final imageURI =
//       'https://dudoriostorage.blob.core.windows.net/moshe-container/$imageName';
//   var response = await http.get(Uri.parse(imageURI));
//   return response.bodyBytes;
// }
