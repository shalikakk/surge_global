import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../list_provider.dart';
import '../ui/home/home_page.dart';

class AppRoute {
  static const String homeRoute = "/";
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    homeRoute: (BuildContext context) {
      return ChangeNotifierProvider<TopRatedMoviesProvider>(
          create: (context) => TopRatedMoviesProvider(), child: HomePage());
    },
  };
}
