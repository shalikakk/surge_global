import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../model/yu_gi_oh.dart';
import '../../../network/api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _count = 50;
  final List<TopRatedMovieModel> _listData = <TopRatedMovieModel>[];
  final ScrollController _controller = ScrollController();
  int _offset = 0;
  YuGiOh? _yuGiOh;
  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();
    _requestNewData();
    _controller.addListener(() {
      double _pixels = _controller.position.pixels;
      double _maxScroll = _controller.position.maxScrollExtent;
      if (_pixels == _maxScroll) _requestNewData();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PreferredSize customAppBar(String title) {
    double screenHeight = MediaQuery.of(context).size.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.13),
      child: AppBar(
        backgroundColor: Color(0xffb032541),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    if (currentOrientation == Orientation.portrait) {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    } else {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffb032541),
        toolbarHeight: MediaQuery.of(context).size.height * 0.13,
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text("Top Rated Movies"),
        )),
      ),
      body: ListView.builder(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (BuildContext context, int index) {
          TopRatedMovieModel topRatedMovieModel = _listData[index];
          if (index == _listData.length) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const CircularProgressIndicator(),
            );
          } else {
            return Card(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Row(
                  children: [
                    Stack(clipBehavior: Clip.none, children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 8, bottom: 8),
                        child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            width: width * 0.4,
                            height: height * 0.4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          imageUrl:
                              "https://www.themoviedb.org/t/p/w220_and_h330_face${topRatedMovieModel.posterPath ?? ""}",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        top: height * 0.4 - 22.5,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              height: 55,
                              width: 55,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.4 - 20,
                        left: 0,
                        right: 0,
                        child: CircularPercentIndicator(
                          backgroundColor: Colors.grey,
                          radius: 25.0,
                          lineWidth: 8.0,
                          percent:
                              ((topRatedMovieModel.popularity ?? 00) * 0.01) > 1
                                  ? 1
                                  : (topRatedMovieModel.popularity ?? 00) *
                                      0.01,
                          center: new Text(
                            ((topRatedMovieModel.popularity ?? 00) * 0.01) > 1
                                ? "100%"
                                : "${(topRatedMovieModel.popularity ?? 00)}",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          progressColor: Colors.green,
                        ),
                      )
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  topRatedMovieModel.originalTitle ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text("(${topRatedMovieModel.title ?? ""})",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey)),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Text(
                                      "${topRatedMovieModel.releaseDate ?? ""} (${topRatedMovieModel.originalLanguage ?? ""}) "),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3))),
                                    child: topRatedMovieModel.adult!
                                        ? Text(" ALL ")
                                        : Text(" R "))
                              ],
                            ),
                            Text(
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                              topRatedMovieModel.overview ?? "",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
        itemCount: _listData.length + 1,
      ),
    );
  }

  Future<void> _requestNewData() async {
    _yuGiOh = await ApiClient.getCardInfo(
      count: _count,
      offset: _offset,
    );
    if (_yuGiOh != null) {
      _offset = _yuGiOh!.meta?.nextPageOffset ?? _offset;
      _listData.addAll(_yuGiOh!.data);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Oops! Something went wrong...'),
        ),
      );
    }
  }
}
