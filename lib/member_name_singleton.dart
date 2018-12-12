class MemberNameSingleton {
  static final MemberNameSingleton _memberNameSingleton =
      new MemberNameSingleton._internal();
  String _name;

  factory MemberNameSingleton() {
    return _memberNameSingleton;
  }

  MemberNameSingleton._internal();

  String setName(String _name) {
    this._name = _name;
  }

  String getName() {
    return _name;
  }
}
