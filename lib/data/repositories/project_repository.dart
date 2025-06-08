import '../api/project_api.dart';
import '../model/project_model.dart';

class ProjectRepository {
  final ProjectApi _projectApi;

  const ProjectRepository({
    required final ProjectApi projectApi,
  }) : _projectApi = projectApi;

  Future<(ProjectModel, String)> get() async {
    final (packedProjectModel, path) = await _projectApi.getModel();

    return (
      ProjectModel.fromPacked(packedProjectModel),
      path,
    );
  }

  Future<String> save(
    final String? path,
    final ProjectModel model,
  ) =>
      _projectApi.saveModel(
        path,
        PackedProjectModel.fromModel(model),
      );

  void dispose() => _projectApi.close();
}
