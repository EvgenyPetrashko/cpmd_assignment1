import 'dart:async';
import 'package:cpmd_assignment1/advanced.dart';
import 'package:flutter/material.dart';
import 'joke_serializer.dart';
import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Joke> currentJoke;
  late Future<List<String>> categories;
  String currentCategory = "random";
  bool showList = false;


  @override
  void initState() {
    super.initState();
    currentJoke = fetchJoke(currentCategory);
    categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text('My Personal Info'),
                  content: SizedBox(
                    child: Text('Name: Evgeny\nSurname: Petrashko\nMail: e.petrashko@innopolis.university')
                  )
                )
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.person_pin_circle_outlined),
        ),
      backgroundColor: const Color.fromRGBO(47, 46, 46, 1.0),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: PageView(
                controller: controller,
                children: [
                  Column(
                    children: <Widget>[

                      Image.asset("assets/chucknorris_logo_coloured_small@2x.png", height: 200, width: 300,),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentJoke = fetchJoke(currentCategory);
                          });
                        },
                        child: const Text("Generate joke"),
                      ),
                      FutureBuilder(
                          future: currentJoke,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                (snapshot.data as Joke).value,
                                style: const TextStyle(
                                    color: Colors.white
                                ),

                              );
                            } else if (snapshot.hasError) {
                              return const Text('Failed to load joke. Check Internet connection and Internet Permissions.', style: TextStyle(color: Colors.red),);
                            }
                            return const CircularProgressIndicator(
                              semanticsLabel: "Joke loading",
                            );
                          }),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showList = !showList;
                            });
                          },
                          child: Text("Chosen category $currentCategory")),
                      Visibility(
                        child: Expanded(
                          child: FutureBuilder<List<String>>(
                            future: categories,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                      onPressed: () {
                                        setState(() {
                                          currentCategory = snapshot.data![index];
                                          showList = false;
                                        });
                                      },
                                      child: Text(snapshot.data![index]),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const Divider(
                                      indent: 20,
                                      endIndent: 20,
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return const Text('Failed to load categories. Check Internet connection and Internet Permissions.', style: TextStyle(color: Colors.red),);
                              }
                              return const Center(
                                  child: CircularProgressIndicator(
                                    semanticsLabel: "Joke categories loading",
                                  ));
                            },
                          ),
                        ),
                        visible: showList,
                      ),
                    ],
                  ),
                  const AdvancedPage(title: "2")
                ],
              )
            ),
          )
      ),
    );
  }
}
