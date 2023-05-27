import 'package:flutter/material.dart';
import 'package:flutter_proje1/constant.dart';
import 'package:flutter_proje1/pages/note_details.dart';
import 'package:flutter_proje1/pages/create_notes.dart';
import 'package:flutter_proje1/model/mainpage_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends MainPageModel {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
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

  Widget get noteListCard => ListView.builder(
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
                            onPressed: () async {
                              debugPrint('Silme Çalıştı');
                              myNoteList!.removeAt(index);
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
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          ),
        ),
      );
  Widget get _noNoteCard => const Center(
        child: Text('Not yok'),
      );
}
