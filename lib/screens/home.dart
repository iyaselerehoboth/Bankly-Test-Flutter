import 'package:flutter/material.dart';
import 'package:bankly_challenge_flutter/transactions.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Transactions"),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Material(
              child: Container(
                height: 70,
                color: Colors.white,
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  unselectedLabelColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blueAccent),
                  tabs: const [
                    Tab(
                      child: Text("All"),
                    ),
                    Tab(
                      child: Text("Credit"),
                    ),
                    Tab(
                      child: Text("Debit"),
                    ),
                  ],
                ),
              ),
            ),
            TabBarView(
              children: [
                _buildListView(),
                _buildListView(),
                _buildListView(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List> _buildListView(){
    return FutureBuilder(
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
    );
  }

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
}
