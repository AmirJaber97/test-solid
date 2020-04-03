import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsolid/provider/theme_provider.dart';
import 'package:testsolid/ui/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Test App',
            theme: themeProvider.isDarkModeOn
                ? ThemeData.dark()
                : ThemeData.light(),
            home: TestScreen(title: 'Hello There'),
          );
        },
      ), create: (BuildContext context) => ThemeProvider(),
    );
  }
}
