class Commnent {
  int _id;
  String _name;
  String _email;
  String _bory;

  Commnent(this._id, this._name, this._email, this._bory);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get bory => _bory;

  set bory(String value) {
    _bory = value;
  }
}
