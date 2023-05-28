import 'package:flutter/material.dart';
import 'package:flutter_proje1/constant.dart';
import 'package:flutter_proje1/model/notes_model.dart';
import 'package:flutter_proje1/pages/main_page_view.dart';
import 'package:flutter_proje1/product/locale_manager.dart';

class CreateNotes extends StatefulWidget {
  final String note;
  const CreateNotes({super.key, required this.note});
  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  late TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.note);
  }

  int colorId = 1;
  bool isNoteAdded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.indigo),
        elevation: 0,
        title: Text(
          'Not Oluştur',
          style: Constant.headerStyle,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: '    Notunuzu Giriniz',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Constant.defaultHeight,
                Center(
                    child: Text('Renk Seçimi Yapınız',
                        style: Constant.headerStyle)),
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
                    if (textEditingController.text.isEmpty ||
                        textEditingController.text.trim().isEmpty) return;
                    await saveData();
                    if (!mounted) return;
                    //Navigator.of(context).pop(isNoteAdded);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainPageView(),
                    ));
                  },
                  child: Text('KAYDET', style: Constant.buttonStyle),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isInputValid(String input) {
    // Girilen metni kontrol eder ve boşluk karakteri girilmediği durumlarda true döner
    return input.trim() != '';
  }

  Widget _createColor(Color color, int index) {
    return FloatingActionButton(
      heroTag: index,
      onPressed: () {
        colorId = index;
        setState(() {});
      },
      backgroundColor: color,
      child: colorId == index
          ? const Icon(Icons.check, color: Colors.black)
          : const SizedBox.shrink(),
    );
  }

  Future<void> saveData() async {
    String? myNotes = LocaleManager.instance.getString(PreferencesKey.note);
    List<MyNoteModel> noteList = [];

    if (myNotes != null) {
      noteList = MyNoteModel().decode(myNotes);

      // Güncellenmek istenen notu bul ve üzerine yaz
      for (int i = 0; i < noteList.length; i++) {
        if (noteList[i].note == widget.note) {
          noteList[i].note = textEditingController.text;
          noteList[i].colorId = colorId;
          break;
        }
      }
    }

    LocaleManager.instance.setString(
      PreferencesKey.note,
      MyNoteModel().encode(noteList),
    );

    isNoteAdded = true;
  }
  /* Future<void> saveData() async {
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
  } */
}
