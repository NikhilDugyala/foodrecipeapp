import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'model.dart';
import 'web_page.dart';

class SearchPage extends StatefulWidget {
  String? search;
  SearchPage({super.key, this.search});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Model> list = <Model>[];
  String? text;

  getApiData(search) async {
    final url =
        'https://api.edamam.com/search?q=$search&app_id=dcb4e985&app_key=09182a47b1098fc7e2d6139ce860f97b&from=0&to=99&calories=591-722&health=alcohol-free';
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    print(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
          url: e['recipe']['url'],
          image: e['recipe']['image'],
          source: e['recipe']['source'],
          label: e['recipe']['label']);
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Receipes")),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (v) {
                  text = v;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage(
                                      search: text,
                                    )));
                      },
                      icon: const Icon(Icons.search),
                    ),
                    hintText: "Search for your Food Recipe",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.orange.withOpacity(0.1),
                    filled: true),
              ),

              const SizedBox(
                height: 15,
              ),

              GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebPage(
                                    url: x.url,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(x.image.toString()))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: 40,
                            color: Colors.white.withOpacity(0.5),
                            child:
                                Center(child: Text(x.label.toString())),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: 40,
                            color: Colors.white.withOpacity(0.5),
                            child: Center(
                                child: Text(
                                    "Source: ${x.source}")),
                          )
                        ]
                      ),
                    ),
                  );
                }
              )
            ],
          ),
        )
      ),
    );
  }
}
