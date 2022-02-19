import 'package:cpmd_assignment1/joke_serializer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api.dart';

class AdvancedPage extends StatefulWidget {
  const AdvancedPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AdvancedPage> createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<JokeQuery>> jokeQuery;
  String query = "virginity";
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jokeQuery = fetchJokeByQuery(query);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: myController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Enter some words (Ex: virginity)',
                    hintStyle: TextStyle(color: Colors.grey)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 3 || value.length > 120) {
                    return 'Length of the query should be in range [3, 120]';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          jokeQuery = fetchJokeByQuery(myController.text);
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text(
                                  "Length of the input should be in range [3, 120]"),
                            );
                          },
                        );
                      }
                    },
                    child: Row(
                      children: const [Icon(Icons.search), Text('Submit')],
                      mainAxisSize: MainAxisSize.min,
                    )),
              ),
            ],
          ),
        ),
        Expanded(
            child: FutureBuilder(
                future: jokeQuery,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        itemCount: (snapshot.data as List<JokeQuery>).length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            indent: 20,
                            endIndent: 20,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    (snapshot.data as List<JokeQuery>)[index]
                                        .value,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                OutlinedButton(
                                    onPressed: () => launchUrl((snapshot.data
                                            as List<JokeQuery>)[index]
                                        .url),
                                    child: const Text("Link"))
                              ]);
                        });
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Failed to load joke. Check Internet connection and Internet Permissions.',
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    semanticsLabel: "Joke query loading",
                  ));
                })),
      ],
    );
  }
}

launchUrl(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
