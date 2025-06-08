part of 'home.dart';

class State {
  final String? projectPath;
  final ProjectModel projectModel;
  final bool projectLocked;

  const State({
    this.projectPath,
    final ProjectModel? projectModel,
    this.projectLocked = false,
  }) : projectModel = projectModel ?? const ProjectModel();

  State copyWith({
    final String? Function()? projectPath,
    final ProjectModel Function()? projectModel,
    final bool Function()? projectLocked,
  }) =>
      State(
        projectPath:
            projectPath == null ? this.projectPath : projectPath.call(),
        projectModel:
            projectModel == null ? this.projectModel : projectModel.call(),
        projectLocked:
            projectLocked == null ? this.projectLocked : projectLocked.call(),
      );
}
