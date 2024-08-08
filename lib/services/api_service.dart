import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing/models/news_model.dart';

class APIService {

  final String apiURL =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=626e0e40c01c4427b5b7a628762b6efa";

  Future<NewsModel> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiURL));
      if (response.statusCode == 200) {
        final Json = json.decode(response.body);
        return NewsModel.fromJson(Json);
      } else {
        throw Exception('unable to load data');
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
