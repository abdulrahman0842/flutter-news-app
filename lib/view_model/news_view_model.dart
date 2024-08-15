import 'package:testing/models/news_model.dart';
import 'package:testing/models/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsModel> fetchNewsChannelHeadline(String channelName) async {
    final response = await _rep.fetchNewsChanelHeadline(channelName);
    return response;
  }

  Future<NewsModel> fetchCountryHeadline() async {
    final response = await _rep.fetchCountryHeadline();
    return response;
  }
}
