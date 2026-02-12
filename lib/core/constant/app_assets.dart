class AppAssets {
  AppAssets._();
  static const  images = _Images();
  static const  icons = _Icons();
  static const  json = _Json();
}

class _Images {
  const _Images();

  static const String _base = 'assets/images/';

  String get object1 => '${_base}Object 1.png';
  String get object2 => '${_base}Object 2.png';
  String get object3 => '${_base}Object 3.png';
  String get shape => '${_base}shape.png';
  String get logo => '${_base}logo.png';
  String get drive => '${_base}drive.png';
  String get mobile => '${_base}mobile.png';

}

class _Icons {
  const _Icons();

  static const String _base = 'assets/icons/';

  String path(String filename) => '$_base$filename';
  String get basepath => _base;
}

class _Json {
  const _Json();

  static const String _base = 'assets/json/';

  String get currencies => '${_base}currencies.json';
}
