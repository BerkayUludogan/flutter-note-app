import 'package:flutter/material.dart';
import 'package:flutter_proje1/constant.dart';
import 'package:flutter_proje1/model/create_notes_model.dart';
import 'package:flutter_proje1/model/notes_model.dart';
import 'package:flutter_proje1/pages/main_page_view.dart';
import 'package:flutter_proje1/product/locale_manager.dart';

class CreateNotes extends StatefulWidget {
  final String note;
  const CreateNotes({super.key, required this.note});
  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends CreateNotesModel {

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
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Notunuzu Giriniz',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              Constant.defaultHeight,
              Center(
                  child:
                      Text('Renk Seçimi Yapınız', style: Constant.headerStyle)),
              Constant.defaultHeight,
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      createColor(Constant.color1, 1),
                      createColor(Constant.color2, 2),
                      createColor(Constant.color3, 3),
                      createColor(Constant.color4, 4),
                      createColor(Constant.color5, 5),
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
                  debugPrint('Ulaşıldı');
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
    );
  }
}
