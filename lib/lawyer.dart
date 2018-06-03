import 'dart:math';

enum Sex { MALE, FEMALE }

class Lawyer {
  String _name, _id;
  List _titles;
  Sex _sex;
  String _address;
  String _telephone;
  String _email;

  String get name => (_name == null) ? "Unnamed" : this._name;
  String get title => (_titles == null) ? "-" : this._titles.join(', ');
  Sex get sex => (_sex == null) ? Sex.MALE : _sex;
  String get id => (_id == null) ? "null" : _id;
  String get address => (_address = null) ? "Address not available." : _address;
  String get telephone =>
      (_telephone = null) ? "Phone Number not available." : _telephone;
  String get email => (_email = null) ? "nomail@null.com" : _email;

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
    String unpackedAddress = package[1];
    String unpackedTelephone = package[2];
    String unpackedEmail = package[3];

    Random random = new Random(name.codeUnitAt(0));
    this._name = unpackedName;
    this._id = unpackedName
        .toLowerCase()
        .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
        .replaceAll(new RegExp(r"\."), "");

    if (random.nextInt(10000) % 2 == 1) {
      this._titles = ["attorny-at-law"];
    } else {
      this._titles = ["LLB", "attorny-at-law"];
    }

    this._sex = (random.nextInt(100000) % 2) == 0 ? Sex.MALE : Sex.FEMALE;

    this._address = unpackedAddress;
    this._telephone = unpackedTelephone;
    this._email = unpackedEmail;
  }

  static List createDatabase() {
    List _lawyers = [
      [
        'MR. A. ABERATHNA AMUNUGAMA',
        'NO. 23, MIDDLE LEVEL HOUSING SCHEME,SAMARAPURA, ANURADHAPURA',
        '0710232244',
        null
      ],
    ];
    List _resultLawyers = [];
    for (List _eachLawyer in _lawyers) {
      Lawyer newLawyer = new Lawyer.fromList(_eachLawyer);
      _resultLawyers.add(newLawyer);
    }
    return _resultLawyers;
  }
}
