import 'package:flutter/material.dart';
import 'package:flutter_proje1/constant.dart';
import 'package:flutter_proje1/model/notes_model.dart';
import 'package:flutter_proje1/pages/main_page_view.dart';
import 'package:flutter_proje1/product/locale_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MainPageModel extends State<MainPageView> {
  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future<SharedPreferences> getSharedPreferenceInstance() async {
    return await SharedPreferences.getInstance();
  }

  List<MyNoteModel>? myNoteList;
  bool isLoading = false;
  Future<void> getNotes() async {
    try {
      changeLoading();
      String? myStringNotes =
          LocaleManager.instance.getString(PreferencesKey.note);
      if (myStringNotes == null) return;
      myNoteList = MyNoteModel().decode(myStringNotes);
      if (myNoteList == null) return;
    } finally {
      changeLoading();
      setState(() {});
    }
  }

  String limitWordCount(String text, int wordLimit) {
    List<String> words = text.split('');
    if (words.length <= wordLimit) {
      return text;
    } else {
      List<String> limitedWords = words.sublist(0, wordLimit);
      return '${limitedWords.join('')}...';
    }
  }

  void changeLoading() {
    isLoading = !isLoading;
  }

  var myColor = {
    1: Constant.color1,
    2: Constant.color2,
    3: Constant.color3,
    4: Constant.color4,
    5: Constant.color5
  };
}
