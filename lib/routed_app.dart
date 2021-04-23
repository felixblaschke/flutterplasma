import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import 'demo/demo_screen.dart';
import 'showroom/show_room.dart';
import 'widget_warmup.dart';

class RoutedApp extends StatefulWidget {
  @override
  _RoutedAppState createState() => _RoutedAppState();
}

class _RoutedAppState extends State<RoutedApp> {
  final _routerDelegate = AppRouterDelegate();
  final _routeInformationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Plasma',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class AppRoutePath {
  final String _route;
  var showroomIndex = 0;
  var demoShowCredits = true;

  AppRoutePath.demo({bool credits = true})
      : _route = 'demo',
        demoShowCredits = credits;

  AppRoutePath.showroom(int index)
      : _route = 'showroom',
        showroomIndex = index;

  AppRoutePath.unknown() : _route = 'unknown';

  bool get isDemo => _route == 'demo';

  bool get isShowroom => _route == 'showroom';

  bool get isUnknown => _route == 'unknown';
}

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.demo();
    }

    if (uri.pathSegments[0] == 'nocredits') {
      return AppRoutePath.demo(credits: false);
    }

    if (uri.pathSegments[0] == 'showroom') {
      if (uri.pathSegments.length == 2) {
        var index = uri.pathSegments[1].toInt();
        if (index != null) {
          return AppRoutePath.showroom(index);
        }
      }

      return AppRoutePath.showroom(0);
    }

    return AppRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath path) {
    if (path.isDemo) {
      if (path.demoShowCredits) {
        return RouteInformation(location: '/');
      } else {
        return RouteInformation(location: '/nocredits');
      }
    }
    if (path.isShowroom) {
      if (path.showroomIndex > 0) {
        return RouteInformation(location: '/showroom/${path.showroomIndex}');
      }
      return RouteInformation(location: '/showroom');
    }
    return RouteInformation(location: '/unknown');
  }
}

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  var showDemo = true;
  var demoShowCredits = true;
  var showShowroom = false;
  var showroomIndex = 0;
  var showUnknown = false;

  @override
  AppRoutePath get currentConfiguration {
    if (showDemo) {
      return AppRoutePath.demo(credits: demoShowCredits);
    }
    if (showShowroom) {
      return AppRoutePath.showroom(showroomIndex);
    }
    return AppRoutePath.unknown();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetWarmup(
      child: Navigator(
        key: navigatorKey,
        pages: [
          if (showDemo)
            MaterialPage<DemoScreen>(
              key: ValueKey('Demo'),
              child: DemoScreen(
                showCredits: demoShowCredits,
                onComplete: _handleDemoCompleted,
              ),
            ),
          if (showShowroom)
            MaterialPage<Scaffold>(
              key: ValueKey('ShowRoom'),
              child: Scaffold(
                  body: ShowRoom(
                      index: showroomIndex,
                      onIndexChange: _handleShowroomIndexChange)),
            ),
          if (showUnknown)
            MaterialPage<Scaffold>(
              key: ValueKey('Unknown'),
              child: Scaffold(body: Center(child: Text('404'))),
            )
        ],
        onPopPage: (route, dynamic result) {
          if (!route.didPop(result)) {
            return false;
          }

          notifyListeners();
          return true;
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    showDemo = path.isDemo;
    demoShowCredits = path.demoShowCredits;
    showShowroom = path.isShowroom;
    showUnknown = path.isUnknown;
    showroomIndex = path.showroomIndex;
  }

  void _handleDemoCompleted() {
    showDemo = false;
    showShowroom = true;
    notifyListeners();
  }

  void _handleShowroomIndexChange(int newIndex) {
    showroomIndex = newIndex;
    notifyListeners();
  }
}
