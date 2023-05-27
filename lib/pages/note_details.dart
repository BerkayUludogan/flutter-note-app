import 'package:flutter/material.dart';
import 'package:flutter_proje1/constant.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(Constant.detailTitle),
      ),
      body: Column(
        children: [
          TextField(
            maxLines: 20,
            controller: textEditingController,
          )
        ],
      ),
    );
  }
}
