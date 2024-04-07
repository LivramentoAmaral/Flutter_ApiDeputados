import 'package:flutter/material.dart';
import 'package:flutter_deputyapp/src/screens/comissions_depurty.dart';
import 'package:flutter_deputyapp/src/screens/details_comissions_deputy.dart';
import 'package:flutter_deputyapp/src/screens/detailsdeputy_screem.dart';
import 'package:flutter_deputyapp/src/screens/home_page.dart';
import 'package:flutter_deputyapp/src/screens/list_deputy.dart';
import 'package:flutter_deputyapp/src/screens/listorsearch_screem.dart';
import 'package:flutter_deputyapp/src/screens/search_deputy.dart';
import 'package:flutter_deputyapp/src/screens/search_namedeputy.dart';
import 'package:flutter_deputyapp/src/screens/search_party.dart';
import 'package:flutter_deputyapp/src/screens/search_state.dart';

class RoutesApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RoutesApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deputy App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/comissions': (context) => ComissionsPage(),
        '/listorsearch':(context) => ListOrSearchPage(),
        '/listDeputy': (context) => const ListDeputy(),
        '/details': (context) => const DetailsDeputyPage(),
        '/detailscomissions': (context) =>
            const ComissionDetailsPage(), // Corrigindo a rota para ComissionDetailsPage
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
        } else if (settings.name == '/detailscomissions' &&
            settings.arguments is int) {
          // ignore: unused_local_variable
          final int comissionId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => const ComissionDetailsPage(),
          );
        }

        return null;
      },
    );
  }
}
