import 'dart:developer';

import 'package:firetodo/pages/app.dart';
import 'package:flutter/material.dart';

class GNavigation {
  static final BuildContext _context = materialAppKey.currentState!.context;

  GNavigation._();

  static T getArg<T>() {
    final args = ModalRoute.of(_context)!.settings.arguments as Map;
    final T obj = args['arg'];
    return obj;
  }

  static Future<T?> push<T>(Widget widget,
      {T? arguments, String? routeName}) async {
    log('Push to Route $routeName', name: 'AppNavigation');
    return await Navigator.push<T>(
      _context,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(arguments: arguments, name: routeName),
      ),
    );
  }

  static Future<T?> pushReplacement<T, TO>(Widget widget,
      {T? arguments, String? routeName, TO? result}) async {
    log('Push Replace $routeName', name: 'AppNavigation');
    return await Navigator.pushReplacement<T, TO>(
      _context,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(arguments: arguments, name: routeName),
      ),
      result: result,
    );
  }

  static Future<T?> pushNamed<T>(String routeName, {T? arguments}) async {
    log('Push to Route $routeName', name: 'AppNavigation');
    return await Navigator.pushNamed<T>(
      _context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacementNamed<T>(String route, [arg]) {
    log('Push Replacing current route with $route ::::::::::',
        name: 'AppNavigation');
    return Navigator.pushReplacementNamed(_context, route, arguments: arg);
  }

  static Future pushNamedAndRemoveUntil(
    String route,
    String? predicate, {
    Object? arguments,
  }) {
    log('pushAndRemoveUntil to $route ::::::::::', name: 'AppNavigation');
    return Navigator.pushNamedAndRemoveUntil(
      _context,
      route,
      (route) => route.settings.name == predicate,
      arguments: arguments,
    );
  }

  static Future<bool> pop<T>({T? arg}) {
    var prevRoute = ModalRoute.of(_context)?.settings.name ?? '';
    log('Pop on $prevRoute', name: 'AppNavigation');
    return Navigator.of(_context).maybePop(arg);
  }

  static void popUntil(String route) {
    log('PopUntil ::::::::::', name: 'AppNavigation');
    Navigator.popUntil(_context, ModalRoute.withName(route));
  }

  static void forcedPop<T>({T? arg}) {
    var prevRoute = ModalRoute.of(_context)?.settings.name ?? '';
    log('Forcing Pop on $prevRoute ::::::::::', name: 'AppNavigation');
    Navigator.of(_context).pop(arg);
  }
}
