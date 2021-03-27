import 'package:flutter/material.dart';
import 'package:news/bloc/bloc.dart';
import 'package:news/models/news_info.dart';
import 'package:news/widgets/appBar.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final newsBloc = NewsBloc();

  @override
  void initState() {
    newsBloc.eventSink.add(ActionNews.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        child: StreamBuilder<Article>(
            stream: newsBloc.newsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("has data");
                // var article = snapshot.data;
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      // child: Image.network(
                      //   snapshot.data.urlToImage,
                      //   fit: BoxFit.cover,
                      // ),
                      child: Text(
                        "hello data"
                      ),
                    ),
                  ],
                );
              } else {
                print("no data");
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
            }),
      ),
    );
  }
}
