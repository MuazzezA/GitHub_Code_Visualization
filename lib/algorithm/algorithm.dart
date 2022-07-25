String findFileName(String fileFullPath) {
  String fileName = (fileFullPath
      .split('/')
      .last); // dosya adını ve uzantısını alır , main.dart şeklinde
  return fileName;
}

List<String?> findVariable(String code) {
  // kod içindeki değişkenleri bulup liste şeklinde döndüren fonksiyon
  // pointer değişkenleri de alabiliyor
  RegExp variablesName = RegExp(
      r'\b(?:(?:auto\s*|const\s*|unsigned\s*|signed\s*|register\s*|volatile\s*|static\s*|void\s*|short\s*|long\s*|char\s*|int\s*|float\s*|double\s*|_Bool\s*|complex\s*)+)(?:\s+\*?\*?\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*[\[;*,=)]');
  var matchList =
      variablesName.allMatches(code).map((e) => e.group(1)).toList();
  return matchList;
}

List<String?> findFunctions(String code) {
  // sahip olduğu fonskiyonlar listesi
  // fonksiyonları struct yapılarının fonksiyonlarını da bulur
  RegExp variablesName = RegExp(
      r'\b(?:(?:auto\s*|const\s*|unsigned\s*|signed\s*|register\s*|volatile\s*|static\s*|void\s*|short\s*|long\s*|char\s*|int\s*|float\s*|double\s*|_Bool\s*|complex\s*|\*s*)+)(?:\s+\*?\*?\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*[({]');
  var matchList =
      variablesName.allMatches(code).map((e) => e.group(1)).toList();
  return matchList;
}

List<String?> findOtherFunc(String code) {
  // sahip olmadığı sadece kullandığı fonskiyonlar listesi
  RegExp variablesName = RegExp(
      r'\b(?:!(?:auto\s*|const\s*|unsigned\s*|signed\s*|register\s*|volatile\s*|static\s*|void\s*|short\s*|long\s*|char\s*|int\s*|float\s*|double\s*|_Bool\s*|complex\s*)+)|(?<=\=)(?:\s+\*?\*?\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*[(]');
  var matchList =
      variablesName.allMatches(code).map((e) => e.group(1)).toList();
  return matchList;
}
