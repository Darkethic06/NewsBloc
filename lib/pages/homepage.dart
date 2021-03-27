import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/bloc/bloc.dart';
import 'package:news/models/news_info.dart';
import 'package:news/pages/newsPage.dart';
import 'package:news/widgets/appBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: StreamBuilder<List<Article>>(
          stream: newsBloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("has data");
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var article = snapshot.data[index];
                  var timeFormat =
                      DateFormat('dd MMM - HH:mm').format(article.publishedAt);
                  return GestureDetector(
                    onTap: (){
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context) => 
                     NewsPage()));
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                article.urlToImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(timeFormat),
                                Text(
                                  article.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  article.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              print("no  data");
              return Center(
                
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
