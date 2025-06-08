import 'dart:io';

import 'package:filepicker_windows/filepicker_windows.dart';

import '../model/project_model.dart';

import 'project_api.dart';

class LocalFilesystemProjectApi extends ProjectApi {
  const LocalFilesystemProjectApi();

  @override
  Future<(PackedProjectModel, String)> getModel() async {
    final openFilePicker = OpenFilePicker()
      ..title = 'Open project...'
      ..filterSpecification = {'JSON Document (*.json)': '*.json'}
      ..defaultExtension = '.json';

    final file = openFilePicker.getFile();

    if (file == null) {
      throw OperationCancelledException();
    }

    return (
      PackedProjectModelMapper.fromJson(await file.readAsString()),
      file.path,
    );
  }

  @override
  Future<String> saveModel(
    final String? path,
    final PackedProjectModel model,
  ) async {
    final File projectFile;

    if (path == null) {
      final saveFilePicker = SaveFilePicker()
        ..title = 'Save project...'
        ..filterSpecification = {
          'JSON Document (*.json)': '*.json',
          'All Files': '*.*',
        }
        ..fileName = '${model.name}.json'
        ..defaultExtension = '.json';

      final file = saveFilePicker.getFile();

      if (file == null) {
        throw OperationCancelledException();
      }

      projectFile = file;
    } else {
      projectFile = File(path);
    }

    await projectFile.writeAsString(model.toJson());

    return projectFile.path;
  }

  @override
  Future<void> close() async {}
}
