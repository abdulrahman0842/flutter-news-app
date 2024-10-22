import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:newsvibe/models/news_model.dart';

class ArticleLocalization {
  getKeys() {
    var box = Hive.box<Articles>('NewsArticles');
    log('Keys--');
    log(box.keys.toList().toString());
  }

  Future<void> toggleArticleHive(Articles article) async {
    var box = Hive.box<Articles>('NewsArticles');

    String key = article.title!.substring(0, 10);

    if (box.containsKey(key)) {
      box.delete(key);
      log('Removed:$key');
    } else {
      box.put(key, article);
      log('Added:$key');
    }
  }

  Future<List<Articles>>? fetchFromHive() async {
    var box = Hive.box<Articles>('NewsArticles');
    log("Box-Values:${box.values.toString()}");
    return box.values.toList();
  }

  bool isBookMarked(String key) {
    var box = Hive.box<Articles>('NewsArticles');
    if (box.containsKey(key)) {
      return true;
    } else {
      return false;
    }
  }

  clearBox() {
    var box = Hive.box<Articles>('NewsArticles');
    box.clear();
  }
}
