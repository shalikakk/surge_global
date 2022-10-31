import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:surge_global/list_provider.dart';
import '../../../model/yu_gi_oh.dart';
import '../../../network/api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _count = 50;
  final ScrollController _controller = ScrollController();
  int _page = 1;
  YuGiOh? _yuGiOh;
  double height = 0;
  double width = 0;
  var Items;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    Items = Provider.of<TopRatedMoviesProvider>(context, listen: false);
    _requestNewData();
    _controller.addListener(_onScroll);
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

  double percentage(double populate) {
    populate = populate * 0.01;
    if (populate > 1) return 1;
    return populate;
  }

  String centerText(double populate) {
    if (populate > 100) return "100%";
    return populate.toString().split('.').first + "%";
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return Consumer<TopRatedMoviesProvider>(
                builder: (context, value, child) {
              if (value.isLoading == true) {
                return Center(child: CircularProgressIndicator());
              }

              return SmartRefresher(
                controller: _refreshController,
                onRefresh: _requestNewData,
                child: ListView.builder(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(2.0),
                  itemBuilder: (BuildContext context, int index) {
                    TopRatedMovieModel topRatedMovieModel =
                        value.topRatedMovies[index];
                    if (index == value.topRatedMovies.length) {
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
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: width * 0.4,
                                      height: height * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
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
                                  top: height * 0.4 - 23,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                        height: 55,
                                        width: 55,
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.4 -
                                          20,
                                  left: 0,
                                  right: 0,
                                  child: CircularPercentIndicator(
                                    backgroundColor: Colors.grey,
                                    radius: 25.0,
                                    lineWidth: 8.0,
                                    percent: percentage(
                                        topRatedMovieModel.popularity ?? 00),
                                    center: new Text(
                                      centerText(
                                          topRatedMovieModel.popularity ?? 00),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Text(
                                            topRatedMovieModel.originalTitle ??
                                                "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                            "(${topRatedMovieModel.title ?? ""})",
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
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
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
                  itemCount: value.topRatedMovies.length,
                ),
              );
            }); //rest of your landscape code)
          } else {
            return Consumer<TopRatedMoviesProvider>(
                builder: (context, value, child) {
              if (value.isLoading == true) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(2.0),
                itemBuilder: (BuildContext context, int index) {
                  TopRatedMovieModel topRatedMovieModel =
                      value.topRatedMovies[index];
                  if (index == value.topRatedMovies.length) {
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
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: width * 0.2,
                                    height: height * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
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
                                top: height * 0.4 - 22,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      height: 45,
                                      width: 45,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.4 -
                                    20,
                                left: 0,
                                right: 0,
                                child: CircularPercentIndicator(
                                  backgroundColor: Colors.grey,
                                  radius: 20.0,
                                  lineWidth: 8.0,
                                  percent: percentage(
                                      topRatedMovieModel.popularity ?? 00),
                                  center: new Text(
                                    centerText(
                                        topRatedMovieModel.popularity ?? 00),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  progressColor: Colors.green,
                                ),
                              )
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          topRatedMovieModel.originalTitle ??
                                              "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                          "(${topRatedMovieModel.title ?? ""})",
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
                                                border: Border.all(
                                                    color: Colors.grey),
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
                itemCount: value.topRatedMovies.length,
              );
            });
          }
        },
      ),
    );
  }

  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _requestNewData();
    }
  }

  Future<void> _requestNewData() async {
    _yuGiOh = await ApiClient.getCardInfo(
      page: _page,
    );
    if (_yuGiOh != null) {
      int totol_page = _yuGiOh!.meta?.total_pages ?? 1;
      if (totol_page > _page) {
        _page++;
      }
      Items.getAllMovies(_yuGiOh!.data);
      _refreshController.refreshCompleted();

      /// Items._listData.addAll(_yuGiOh!.data);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Oops! Something went wrong...'),
        ),
      );
    }
  }
}
