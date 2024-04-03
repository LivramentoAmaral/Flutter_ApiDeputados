import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/screens/detailsdeputy_screem.dart';
import 'package:flutter_deputyapp/src/screens/home_page.dart';
import 'package:flutter_deputyapp/src/screens/list_deputy.dart';
import 'package:flutter_deputyapp/src/screens/search_deputy.dart';
import 'package:flutter_deputyapp/src/screens/search_namedeputy.dart';
import 'package:flutter_deputyapp/src/screens/search_party.dart';
import 'package:flutter_deputyapp/src/screens/search_state.dart';

class RoutesApp extends StatelessWidget {
  const RoutesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deputy App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/listDeputy': (context) => const ListDeputy(),
        '/details': (context) =>
            const DetailsDeputyPage(), // Corrigindo a rota para DetailsDeputyPage
        '/search': (context) => const SearchPage(),
        '/partySearch': (context) => const PartySearchPage(),
        '/stateSearch': (context) => const StateSearchPage(),
        '/nameSearch': (context) => const NameSearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details' && settings.arguments is int) {
          // ignore: unused_local_variable
          final int deputyId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => const DetailsDeputyPage(),
          );
        }
        return null;
      },
    );
  }
}
