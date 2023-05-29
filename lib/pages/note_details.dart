import 'package:flutter/material.dart';
import 'package:flutter_proje1/constant.dart';
import 'package:flutter_proje1/model/notes_model.dart';
import 'package:flutter_proje1/pages/create_notes.dart';

class NoteDetails extends StatefulWidget {
  final String note;
  const NoteDetails({super.key, required this.note});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController(text: widget.note);
  }

  List<MyNoteModel>? myNoteList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateNotes(
                  note: textEditingController.text,
                ),
              ));
            },
            icon: const Icon(Icons.edit),
          )
        ],
        title: Text(
          Constant.detailTitle,
          style: Constant.headerStyle,
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.indigo),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              maxLines: null,
              controller: textEditingController,
            ),
          )
        ],
      ),
    );
  }
}
