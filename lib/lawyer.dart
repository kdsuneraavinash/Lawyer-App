import 'dart:math';

import 'package:lawyer_app/test_lawyers.dart' as test_list;

enum Sex { MALE, FEMALE }

enum Title { LLB_ATTORNY, ATTORNY }

class Lawyer {
  String _name, _id;
  List _titles;
  Sex _sex;
  String _address;
  String _telephone;
  String _email;

  String get name => mapIfNotNull(this._name, capitalize);
  String get title => mapIfNotNull(this._titles, (List x) => x.join(", "));
  Sex get sex => mapIfNotNull(this._sex);
  String get id => mapIfNotNull(this._id);
  String get address => mapIfNotNull(this._address, capitalize);
  String get telephone => mapIfNotNull(_telephone);
  String get email => mapIfNotNull(_email);

  Lawyer.fromName(String name) {
    Random random = new Random(name.codeUnitAt(0));
    this._name = name;
    this._id = name
        .toLowerCase()
        .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
        .replaceAll(new RegExp(r"\."), "");

    if (random.nextInt(10000) % 2 == 1) {
      this._titles = ["attorny-at-law"];
    } else {
      this._titles = ["LLB", "attorny-at-law"];
    }

    this._sex = (random.nextInt(100000) % 2) == 0 ? Sex.MALE : Sex.FEMALE;
  }

  Lawyer.fromList(List package) {
    String unpackedName = package[0];
    Sex unpackedSex = package[1];
    Title unpackedTitle = package[2];
    String unpackedAddress = package[3];
    String unpackedTelephone = package[4];
    String unpackedEmail = package[5];

    this._name = unpackedName;
    this._id = unpackedName
        .toLowerCase()
        .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
        .replaceAll(new RegExp(r"\."), "");

    if (unpackedTitle == Title.ATTORNY) {
      this._titles = ["attorny-at-law"];
    } else if (unpackedTitle == Title.LLB_ATTORNY) {
      this._titles = ["LLB", "attorny-at-law"];
    }

    this._sex = unpackedSex;

    this._address = unpackedAddress;
    this._telephone = unpackedTelephone;
    this._email = unpackedEmail;
  }

  static List createDatabase() {
    List _lawyers = test_list.lawyers;
    List _resultLawyers = [];
    for (List _eachLawyer in _lawyers) {
      Lawyer newLawyer = new Lawyer.fromList(_eachLawyer);
      _resultLawyers.add(newLawyer);
    }
    return _resultLawyers;
  }

  String capitalize(String words) {
    List wordsList = words.split(" ");
    for (int i = 0; i < wordsList.length; i++) {
      String word = wordsList[i];
      wordsList[i] = word[0] + word.substring(1).toLowerCase();
    }
    return wordsList.join(" ");
  }

  dynamic mapIfNotNull(dynamic value, [dynamic function]) {
    if (value == null) {
      return null;
    } else {
    if (function == null) function = (v) => v;
      return function(value);
    }
  }
}
