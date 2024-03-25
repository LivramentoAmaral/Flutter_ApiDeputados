import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/screens/detailsdeputy_screem.dart';
import 'package:flutter_deputyapp/src/screens/home_screem.dart';
import 'package:flutter_deputyapp/src/screens/search_deputy.dart';
import 'package:flutter_deputyapp/src/screens/search_namedeputy.dart';
import 'package:flutter_deputyapp/src/screens/search_party.dart';
import 'package:flutter_deputyapp/src/screens/search_state.dart';

class RoutesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deputy App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) =>
            DetailsDeputyPage(), // Corrigindo a rota para DetailsDeputyPage
        '/search': (context) => SearchPage(),
        '/partySearch': (context) => PartySearchPage(),
        '/stateSearch': (context) => StateSearchPage(),
        '/nameSearch': (context) => NameSearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details' && settings.arguments is int) {
          final int deputyId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => DetailsDeputyPage(),
          );
        }
        return null;
      },
    );
  }
}
