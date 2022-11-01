import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surge_global/enums/connectivity_status.dart';
import 'package:surge_global/provider/connectivity_provider.dart';

import 'common/app_route.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) =>
          ConnectivityProvider().connectionStatusController.stream,
      initialData: null,
      child: MaterialApp(
        routes: AppRoute.routes,
      ),
    );
  }
}
