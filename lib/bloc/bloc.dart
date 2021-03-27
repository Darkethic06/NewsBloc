import 'dart:async';
import 'dart:convert';
import 'package:news/models/news_info.dart';
import 'package:http/http.dart' as http;

enum ActionNews { Fetch }

class NewsBloc {
  final stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get newsSink => stateStreamController.sink;
  Stream get newsStream => stateStreamController.stream;

  final eventStreamController = StreamController<ActionNews>();
  StreamSink<ActionNews> get eventSink => eventStreamController.sink;
  Stream get eventStream => eventStreamController.stream;




  void dispose() {
    stateStreamController.close();
    eventStreamController.close();
  }

  NewsBloc() {
    eventStream.listen((event) async {
      if (event == ActionNews.Fetch) {
        var news = await getNews();
        newsSink.add(news.articles);
      }
    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;
    String url =
        "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=8c0af00b577a4735ac45318ac90c0137";

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
