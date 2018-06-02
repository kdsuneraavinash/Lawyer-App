import 'dart:math';

enum Sex{
  MALE, FEMALE
}

class Lawyer {
  String _name, _id;
  List _titles;
  double _rating;
  Sex _sex;

  int get rating => (_rating == null) ? 0 : this._rating.round();
  String get name => (_name == null) ? "Annonymous" : this._name;
  String get title => (_titles == null) ? "-" : this._titles.join(', ');
  Sex get sex => (_sex == null) ? Sex.MALE : _sex;
  String get id => (_id == null) ? "null" : _id;

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
    this._rating = (random.nextInt(100000) % 31) / 10;
  }

  static List createDatabase() {
    List _lawyers = [
      'A. B. Fernando',
      'L. K. Lakmali',
      'N. B. Perera',
      'O. P. Harischandra',
      'U. D. Premathilaka',
      'M. O. Ranaweera',
      'J. G. Karunathilaka',
      'A. B. C. Halwathura',
      'P .P. Ranathilaka',
      'J. A. K. E. Paul',
      'S. M. Somaweera',
      'O. Weerasena',
      'Y. G. Gayantha',
      'H. T. T. Premaweera',
      'T. P. Fernando',
      'R. B. Y. Fernando',
      'L. R. Jayasekara',
    ];
    List _resultLawyers = [];
    for (String _eachLawyer in _lawyers) {
      Lawyer newLawyer = new Lawyer.fromName(_eachLawyer);
      _resultLawyers.add(newLawyer);
    }
    return _resultLawyers;
  }
}
