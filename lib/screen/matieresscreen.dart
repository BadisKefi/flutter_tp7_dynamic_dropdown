import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_7/service/matiereservice.dart';
import 'package:flutter_7/template/dialog/matieredialog.dart';
import 'package:flutter_7/template/navbar.dart';

import '../entities/matiere.dart';

class MatiereScreen extends StatefulWidget {
  @override
  _MatiereScreenState createState() => _MatiereScreenState();
}

class _MatiereScreenState extends State<MatiereScreen> {
  List<Map<String, dynamic>> allMatieres = [];
  Map<String, dynamic>? selectedMatiere;
  @override
  void initState() {
    super.initState();
    fetchAllMatieres();
  }

  Future<void> fetchAllMatieres() async {
    final matieres = await getAllMatieres();
    print(matieres);
    setState(() {
      allMatieres = List<Map<String, dynamic>>.from(matieres);
      if (allMatieres.isNotEmpty) {
        selectedMatiere = allMatieres.first;
      }
    });
  }

  refresh() {
    fetchAllMatieres();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar('matieres'),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getAllMatieres(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(index);
                      print(snapshot.data[index]);
                      return Slidable(
                        key: Key((snapshot.data[index]['codMat']).toString()),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return MatiereDialog(
                                        notifyParent: refresh,
                                        matiere: Matiere(
                                          snapshot.data[index]['description'],
                                          snapshot.data[index]['intMat'],
                                          snapshot.data[index]['codMat'],
                                        ),
                                      );
                                    });
                                //print("test");
                              },
                              backgroundColor: Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () async {
                            await deleteMatiere(snapshot.data[index]['codMat']);
                            setState(() {
                              snapshot.data.removeAt(index);
                            });
                          }),
                          children: [Container()],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Matiere : "),
                                      Text(
                                        snapshot.data[index]['intMat'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 2.0,
                                      ),
                                    ],
                                  ),
                                  Text(
                                      "desc : ${snapshot.data[index]['description']}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: const CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MatiereDialog(
                  notifyParent: refresh,
                );
              });
          //print("test");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
