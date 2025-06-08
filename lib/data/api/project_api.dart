import '../model/project_model.dart';

abstract class ProjectApi {
  const ProjectApi();

  Future<(PackedProjectModel, String)> getModel();

  Future<String> saveModel(
    final String? path,
    final PackedProjectModel model,
  );

  Future<void> close();
}

class OperationCancelledException implements Exception {}
