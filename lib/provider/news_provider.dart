import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newsvibe/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier {
  String apiKey = '626e0e40c01c4427b5b7a628762b6efa';

  NewsModel? _newsChannelHeadline;
  NewsModel? get newsChannelHeadline => _newsChannelHeadline;
  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  Future<NewsModel> fetchNewsChannelHeadline(String channelName) async {
    _isLoading = true;
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        _newsChannelHeadline = NewsModel.fromJson(body);
        log('request sent channel $channelName');
      } else {
        throw Exception('Failed to Load data');
      }
    } catch (error) {
      throw Exception(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return newsChannelHeadline!;
  }

  Future<NewsModel> fetchCountryHeadline() async {
    String url = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        log('request sent country');
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
        log('request sent category:$category');

        return NewsModel.fromJson(body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
