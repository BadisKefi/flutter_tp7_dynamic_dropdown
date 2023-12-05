import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_7/entities/matiere.dart';
import 'package:flutter_7/entities/student.dart';
import 'package:flutter_7/service/matiereservice.dart';
import 'package:flutter_7/service/studentservice.dart';

class MatiereDialog extends StatefulWidget {
  final Function()? notifyParent;
  Matiere? matiere;

  MatiereDialog({super.key, @required this.notifyParent, this.matiere});
  @override
  State<MatiereDialog> createState() => _MatiereDialogState();
}

class _MatiereDialogState extends State<MatiereDialog> {
  TextEditingController intMatCtrl = TextEditingController();

  TextEditingController descriptionCtrl = TextEditingController();

  String title = "Ajouter Matiere";
  bool modif = false;

  late int codeMat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.matiere != null) {
      modif = true;
      title = "Modifier Matiere";
      intMatCtrl.text = widget.matiere!.intMat;
      descriptionCtrl.text = widget.matiere!.description;
      codeMat = widget.matiere!.codMat!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(title),
            TextFormField(
              controller: intMatCtrl,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Champs est obligatoire";
                }
                return null;
              },
              decoration: const InputDecoration(labelText: "intMat"),
            ),
            TextFormField(
              controller: descriptionCtrl,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Champs est obligatoire";
                }
                return null;
              },
              decoration: const InputDecoration(labelText: "Durée"),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (modif == false) {
                    await addMatiere(
                        Matiere(descriptionCtrl.text, intMatCtrl.text));
                  } else {
                    await updateMatiere(Matiere(
                        descriptionCtrl.text, intMatCtrl.text, codeMat));
                  }
                  widget.notifyParent!();
                },
                child: const Text("Ajouter"))
          ],
        ),
      ),
    );
  }
}
