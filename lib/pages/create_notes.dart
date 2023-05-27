import 'package:flutter/material.dart';
import 'package:flutter_proje1/constant.dart';
import 'package:flutter_proje1/model/notes_model.dart';
import 'package:flutter_proje1/product/locale_manager.dart';

class CreateNotes extends StatefulWidget {
  const CreateNotes({super.key});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  final TextEditingController textEditingController = TextEditingController();
  int colorId = 1;
  bool isNoteAdded = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(isNoteAdded);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Not Oluştur'),
        ),
        body: Center(
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Constant.defaultHeight,
                Center(
                    child:
                        Text('Renk Seçimi Yapınız', style: Constant.textStyle)),
                Constant.defaultHeight,
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _createColor(Constant.color1, 1),
                        _createColor(Constant.color2, 2),
                        _createColor(Constant.color3, 3),
                        _createColor(Constant.color4, 4),
                        _createColor(Constant.color5, 5),
                      ]),
                ),
                Constant.defaultHeight,
                Center(
                    child: ElevatedButton(
                  onPressed: () async {
                    if (textEditingController.text.isEmpty) return;
                    await saveData();
                    if (!mounted) return;
                    Navigator.of(context).pop(isNoteAdded);
                  },
                  child: const Text('KAYDET'),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createColor(Color color, int index) {
    return FloatingActionButton(
      heroTag: index,
      onPressed: () {
        colorId = index;
      },
      backgroundColor: color,
    );
  }

  Future<void> saveData() async {
    String? myNotes = LocaleManager.instance.getString(PreferencesKey.note);
    if (myNotes == null) {
      List<MyNoteModel> noteList = [
        MyNoteModel(note: textEditingController.text, colorId: colorId)
      ];
      LocaleManager.instance
          .setString(PreferencesKey.note, MyNoteModel().encode(noteList));
    } else {
      List<MyNoteModel> noteList = MyNoteModel().decode(myNotes);
      noteList
          .add(MyNoteModel(note: textEditingController.text, colorId: colorId));
      LocaleManager.instance
          .setString(PreferencesKey.note, MyNoteModel().encode(noteList));
    }
    isNoteAdded = true;
  }
}
