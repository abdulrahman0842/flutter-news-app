import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier {
  String apiKey = '626e0e40c01c4427b5b7a628762b6efa';
  Future<NewsModel> fetchNewsChanelHeadline(String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return NewsModel.fromJson(body);
      } else {
        throw Exception('Failed to Load data');
      }
    } catch (error) {
      throw Exception(error);
    }
    
  }
    Future<NewsModel> fetchCountryHeadline() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return NewsModel.fromJson(body);
      } else {
        throw Exception('Failed to Load data');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  
}
