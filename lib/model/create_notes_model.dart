import 'package:flutter/material.dart';
import 'package:flutter_proje1/model/notes_model.dart';
import 'package:flutter_proje1/pages/create_notes.dart';
import 'package:flutter_proje1/product/locale_manager.dart';

abstract class CreateNotesModel extends State<CreateNotes> {
  late TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.note);
  }

  Future<void> saveData() async {
    String? myNotes = LocaleManager.instance.getString(PreferencesKey.note);
    List<MyNoteModel> noteList = [];

    if (myNotes != null) {
      noteList = MyNoteModel().decode(myNotes);

      // Güncellenmek istenen notu bul ve üzerine yaz
      bool noteUpdated = false; // Güncelleme yapıldı mı kontrolü için
      for (int i = 0; i < noteList.length; i++) {
        if (noteList[i].note == widget.note) {
          noteList[i].note = textEditingController.text;
          noteList[i].colorId = colorId;
          noteUpdated = true;
          break;
        }
      }

      // Eğer güncelleme yapılmadıysa yeni bir not ekle
      if (!noteUpdated) {
        noteList.add(
            MyNoteModel(note: textEditingController.text, colorId: colorId));
      }
    } else {
      // Eğer veri yoksa yeni bir not ekle
      noteList
          .add(MyNoteModel(note: textEditingController.text, colorId: colorId));
    }

    LocaleManager.instance.setString(
      PreferencesKey.note,
      MyNoteModel().encode(noteList),
    );

    isNoteAdded = true;
  }

  int colorId = 1;
  bool isNoteAdded = false;
  bool isInputValid(String input) {
    // Girilen metni kontrol eder ve boşluk karakteri girilmediği durumlarda true döner
    return input.trim() != '';
  }

  Widget createColor(Color color, int index) {
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
}
