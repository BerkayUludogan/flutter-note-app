
import 'dart:convert';

class MyNoteModel {
  String? note;
  int? colorId;
  MyNoteModel({this.note, this.colorId});
  MyNoteModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    colorId = json['colorId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    data['colorId'] = colorId;
    return data;
  }

  String encode(List<MyNoteModel> list) {
    return jsonEncode(list);
  }

  List<MyNoteModel> decode(String list) {

    var parsedListJson = jsonDecode(list.toString());
    List<MyNoteModel> itemsList = List<MyNoteModel>.from(parsedListJson
        .map<MyNoteModel>((dynamic i) => MyNoteModel.fromJson(i)));
    return itemsList;
  }

  @override
  String toString() => 'note: $note, colorId: $colorId';
}
