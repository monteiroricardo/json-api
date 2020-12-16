import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'comment.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = "https://jsonplaceholder.typicode.com/comments";

  Future<List<Commnent>> _getComments() async {
    http.Response response = await http.get(url);
    var dadosJson = json.decode(response.body);

    List<Commnent> comentarios = List();
    for (var info in dadosJson) {
      Commnent c =
          Commnent(info['id'], info['name'], info['email'], info['body']);
      comentarios.add(c);
    }

    return comentarios;
  }

  @override
  Widget build(BuildContext context) {
    _getComments();
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(text: "{"),
                        TextSpan(
                            text: "JSON",
                            style: TextStyle(
                              color: Color(0xffFF5555),
                            )),
                        TextSpan(text: "} Placeholder"),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: FutureBuilder<List<Commnent>>(
                  future: _getComments(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          padding: EdgeInsets.only(top: 300),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        );
                        break;

                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          Container(
                              padding: EdgeInsets.only(top: 300),
                              child: Text(
                                "Erro ao carregar dados",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Quando'),
                              ));

                          break;
                        } else {
                          return SizedBox(
                            height: 3000,
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  List<Commnent> lista = snapshot.data;
                                  Commnent comentarios = lista[index];
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text(
                                            comentarios.name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Quando'),
                                          ),
                                          subtitle: Text(
                                            comentarios.email,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Quando'),
                                          ),
                                        ),
                                        Text(
                                          comentarios.bory,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Quando'),
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }
                    }
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
