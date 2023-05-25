import 'package:bankly_challenge_flutter/screens/home.dart';
import 'package:bankly_challenge_flutter/transactions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bankly Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'TRANSACTIONS'),
      home: const Home(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<Transactions>> getTransactions() async {
    Uri uri = Uri.parse("https://646b7d727d3c1cae4ce3e29f.mockapi.io/api/vi/transactions");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      List<Transactions> transactions = [];

      for (var t in jsonData){
        transactions.add(Transactions.fromJson(t));
      }

      return transactions;
    } else {
      throw Exception("Failed to load transactions");
    }

  }

  String formatDate(String dateString){
    return DateFormat('dd, MMM yyyy, hh:mm:ss a').format(DateTime.parse(dateString));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: const Icon(Icons.arrow_back)
      ),
      body: FutureBuilder(
        future: getTransactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text('${snapshot.error}')
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder:(BuildContext context, int index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data[index].logourl),
                ),
                title: Text(snapshot.data[index].source),
                subtitle: Text(formatDate(snapshot.data[index].trnDate)),
              );
            });
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
