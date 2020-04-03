import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsolid/cache/shared_preferences_helper.dart';
import 'package:testsolid/provider/theme_provider.dart';

class TestScreen extends StatefulWidget {
  final String title;

  const TestScreen({Key key, this.title}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Color _currentColor = Colors.teal;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferenceHelper _sharedPrefsHelper = SharedPreferenceHelper();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: _changeScreenColor,
        child: Consumer<ThemeProvider>(
          builder: (_, themeProvider, __) {
            return Scaffold(
              appBar: _buildAppBar(themeProvider),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.restore),
                onPressed: () {
                  _sharedPrefsHelper.clearPreferences().then(
                      (_) => _displaySnackbar('Cleared shared preferences'));
                },
              ),
              key: _scaffoldKey,
              backgroundColor: _currentColor,
              body: Center(
                child: Text(widget.title ?? ''),
              ),
            );
          },
        ),
      ),
      onWillPop: () async => Navigator.canPop(context)
          ? Navigator.pop(context)
          : _confirmAppExit(),
    );
  }

  Widget _buildAppBar(themeProvider) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Light'),
          Switch(
              activeColor: Colors.blueGrey,
              value: themeProvider.isDarkModeOn,
              onChanged: (booleanValue) {
                themeProvider.updateTheme(booleanValue);
              }),
          Text('Dark'),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.help_outline),
          onPressed: () {
            showModalBottomSheet(
                context: context, builder: (context) => _buildBottomSheet());
          },
        )
      ],
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'What\'s been done?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Text('1. Scaffold with random color generated on tap'),
              Text(
                  '2. Impletementation of dark mode, which uses Provider package for managing states and shared preference for persistence'),
              Text('3. Floating action button that clears shared preferences'),
              Text(
                  '4. Calling of the snackbar using the scaffold\'s global key'),
              Text(
                  '5. Implemention of WillPopScope to override back button and prevent navigation'),
              Text('6*. Clean code approach'),
              Text('7*. Understandable project structure'),

            ],
          ),
        ),
      ),
    );
  }

  _changeScreenColor() {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    int color = (math.Random().nextDouble() * 0xFFFFFF)
        .toInt(); // Or we can randomize by passing 4 random integers (256) in the fromARGB method
    setState(() {
      _currentColor = Color(color).withOpacity(1.0);
    });
    _displaySnackbar("Scaffold color changed to $color");
  }

  _displaySnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<bool> _confirmAppExit() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This will exit out of the app'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
