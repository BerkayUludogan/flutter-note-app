import 'package:flutter/material.dart';
import 'package:flutter_proje1/constant.dart';
import 'package:flutter_proje1/model/notes_model.dart';
import 'package:flutter_proje1/pages/note_details.dart';
import 'package:flutter_proje1/pages/create_notes.dart';
import 'package:flutter_proje1/model/mainpage_model.dart';

import '../product/locale_manager.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends MainPageModel {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(Constant.title)),
        floatingActionButton: FloatingActionButton(
          heroTag: 'notlarbuton',
          onPressed: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const CreateNotes()))
                .then(
              (value) {
                if (value ?? false) {
                  getNotes();
                }
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : (myNoteList != null && (myNoteList?.isNotEmpty ?? false))
                  ? noteListCard
                  : _noNoteCard,
        ));
  }

  String? limitedText;

  Widget get noteListCard => Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16), child: const Text('Notlarım')),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: myNoteList!.length,
              itemBuilder: (context, index) => Card(
                color: myColor[myNoteList![index].colorId],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Sil'),
                            content: const Text(
                                'Seçilen notu silmek istediğinize emin misiniz ?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (myNoteList != null) {
                                      myNoteList!.removeAt(index);
                                      LocaleManager.instance.setString(
                                          PreferencesKey.note,
                                          MyNoteModel().encode(myNoteList!));
                                    }
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  child: const Text('Sil')),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('İptal'))
                            ],
                          );
                        });
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteDetails(
                        note: myNoteList![index].note.toString(),
                      ),
                    ));
                  },
                  title: Text(
                    limitWordCount(myNoteList![index].note.toString(), 10),
                  ),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit)),
                ),
              ),
            ),
          ),
        ],
      );
  Widget get _noNoteCard => const Center(
        child: Text('Not yok'),
      );
}
