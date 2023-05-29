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
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          heroTag: 'create_btn',
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => const CreateNotes(note: '',),
              ),
            )
                .then(
              (value) {
                if (value ?? false) {
                  getNotes();
                }
              },
            );
          },
          child: const Icon(
            Icons.edit_note_outlined,
            color: Colors.indigo,
          ),
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

  Widget get noteListCard => CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 300, // İstediğiniz yüksekliği ayarlayabilirsiniz
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Notlarım',
                style: Constant.headerStyle,
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
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
                                  child: const Text('Sil'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('İptal'),
                                ),
                              ],
                            );
                          },
                        );
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
                    ),
                  ),
                );
              },
              childCount: myNoteList!.length,
            ),
          ),
        ],
      );
  Widget get _noNoteCard => Center(
        child: Text('Not yok', style: Constant.headerStyle),
      );
}
