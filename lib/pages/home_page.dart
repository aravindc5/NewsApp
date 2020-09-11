import 'package:flutter/material.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/services/api.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = ApiManager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('News App'),
        ),
        body: widgetSlider(_newsModel));
  }
}

Widget widgetSlider(Future<NewsModel> _newsModel) {
  return Column(
    children: [topSlider(_newsModel)],
  );
}

Widget topSlider(Future<NewsModel> _newsModel) {
  return Expanded(
    child: FutureBuilder<NewsModel>(
        future: _newsModel,
        builder: (context, snapshot) {
          if (snapshot.hasData == null) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.articles.length,
                itemBuilder: (context, index) {
                  var articles = snapshot.data.articles[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Image.network(
                            articles.urlToImage,
                            width: 300,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            child: Container(
                              height: 60,
                              color: Colors.black.withOpacity(0.5),
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                articles.title,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
        }),
  );
}
