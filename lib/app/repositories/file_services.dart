import 'mobile/files.dart' if (dart.library.html) 'web/files.dart' as files;

class FileServices {
  Future<String> saveFile(String name, String content) {
    return files.saveFile(name, content);
  }

  Future<String> selectFile([List<String> accepted]) {
    return files.selectFile(accepted);
  }
}
