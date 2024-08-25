import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier {
  String apiKey = '';

  NewsModel? _newsModel;
  NewsModel? get newsModel => _newsModel;
  Future<void> fetchNewsChanelHeadline(String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        _newsModel = NewsModel.fromJson(body);
        notifyListeners();
        // return NewsModel.fromJson(body);
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

  Future<NewsModel> fetchCategoryNews(String category) async {
    String url = 'https://newsapi.org/v2/everything?q=$category&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return NewsModel.fromJson(body);
      } else {
        throw Exception('Failed to load data');
      }
      
    } catch (error) {
      throw Exception(error);
    }
  }
}
