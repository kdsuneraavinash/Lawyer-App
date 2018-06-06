import 'package:lawyer_app/values/test_lawyers.dart' show LAWYERS;

enum Sex { MALE, FEMALE }

enum Title { LLB_ATTORNY, ATTORNY }

class Lawyer {
  String _name, _id;
  List _titles;
  Sex _sex;
  String _address;
  String _telephone;
  String _email;

  // * Getters
  String get name => mapIfNotNull(this._name, capitalize);
  String get title => mapIfNotNull(this._titles, (List x) => x.join(", "));
  Sex get sex => mapIfNotNull(this._sex);
  String get id => mapIfNotNull(this._id);
  String get address => mapIfNotNull(this._address, capitalize);
  String get telephone => mapIfNotNull(_telephone);
  String get email => mapIfNotNull(_email);

  // * Load from a given List
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
        .replaceAll(RegExp(r"\s+\b|\b\s"), "")
        .replaceAll(RegExp(r"\."), "");

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

  /// * Test Method - Create set of Lawyers from a 2D list
  static List createDatabase() {
    List _resultLawyers = [];
    for (List _eachLawyer in LAWYERS) {
      Lawyer newLawyer = Lawyer.fromList(_eachLawyer);
      _resultLawyers.add(newLawyer);
    }
    return _resultLawyers;
  }

  /// * Capitalize Function
  String capitalize(String words, [String seperator = " "]) {
    List wordsList = words.split(seperator);
    for (int i = 0; i < wordsList.length; i++) {
      String word = wordsList[i];
      wordsList[i] = word[0] + word.substring(1).toLowerCase();
    }
    return wordsList.join(seperator);
  }

  /// * Map to a function if not null
  /// Created for use of getters
  dynamic mapIfNotNull(dynamic value, [dynamic function]) {
    if (value == null) {
      return null;
    } else {
      if (function == null) function = (v) => v;
      return function(value);
    }
  }
}
