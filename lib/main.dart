import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/pagues/home_page.dart';
import 'package:qrreader/pagues/mapa_page.dart';
import 'package:qrreader/providers/iu_provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        
        ChangeNotifierProvider(create: (BuildContext context) { 
          return new ScanListProvider();
         },)
        
      ],

      child: MaterialApp(
        title: 'QrReader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(), 
          'mapa': (_) => MapaPage()
          },
        theme: ThemeData(
          primaryColor: Colors.teal,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.red
          )
        ),
      ),
    );
  }
}
