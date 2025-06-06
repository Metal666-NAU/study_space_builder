part of 'home.dart';

class Bloc extends flutter_bloc.Bloc<Event, State> {
  Bloc() : super(State()) {
    on<Startup>((final event, final emit) {});
    on<NewProject>(
      (final event, final emit) => emit(
        state.copyWith(
          projectPath: () => null,
          projectModel: () => ProjectModel(),
        ),
      ),
    );
    on<LoadProject>((final event, final emit) async {
      final openFilePicker = OpenFilePicker()
        ..title = 'Open project...'
        ..filterSpecification = {'JSON Document (*.json)': '*.json'}
        ..defaultExtension = '.json';

      final file = openFilePicker.getFile();

      if (file == null) {
        return;
      }

      final projectModel =
          ProjectModelMapper.fromJson(await file.readAsString());

      emit(
        state.copyWith(
          projectPath: () => file.path,
          projectModel: () => projectModel,
        ),
      );
    });
    on<SaveProject>((final event, final emit) async {
      final projectPath = state.projectPath;
      final File projectFile;

      if (projectPath == null) {
        final saveFilePicker = SaveFilePicker()
          ..title = 'Save project...'
          ..filterSpecification = {
            'JSON Document (*.json)': '*.json',
            'All Files': '*.*',
          }
          ..fileName = '${state.projectModel.name}.json'
          ..defaultExtension = '.json';

        final file = saveFilePicker.getFile();

        if (file == null) {
          return;
        }

        projectFile = file;
      } else {
        projectFile = File(projectPath);
      }

      await projectFile.writeAsString(state.projectModel.toJson());

      emit(state.copyWith(projectPath: () => projectFile.path));
    });
    on<ToggleProjectLock>(
      (final event, final emit) => emit(
        state.copyWith(
          projectLocked: () => !state.projectLocked,
        ),
      ),
    );
    on<RenameProject>(
      (final event, final emit) => emit(
        state.copyWith(
          projectModel: () => state.projectModel.copyWith(name: event.newName),
        ),
      ),
    );
    on<RenameDataItem>(
      (final event, final emit) => emit(
        state.copyWith(
          projectModel: () => _updateDataItemCollection(
            event.dataItem.runtimeType,
            (final collection) => collection
                .map(
                  (final dataItem) => dataItem == event.dataItem
                      ? dataItem.copyWith(name: event.newName)
                      : dataItem,
                )
                .toList(),
          ),
        ),
      ),
    );
    on<InsertDataItem>(
      (final event, final emit) => emit(
        state.copyWith(
          projectModel: () => _updateDataItemCollection(
            event.dataItemToInsert.runtimeType,
            (final collection) => [
              ...collection.where(
                (final dataItem) => dataItem != event.dataItemToInsert,
              ),
              event.dataItemToInsert.copyWith(
                ownerId: event.targetDataItem?.id,
                isPrefixSlot: event.isPrefix,
              ),
            ],
          ),
        ),
      ),
    );
    on<UpdateTimestamp>(
      (final event, final emit) => emit(
        state.copyWith(
          projectModel: () => state.projectModel.copyWith(
            timestamps: state.projectModel.timestamps
                .map(
                  (final timestamp) => timestamp == event.timestamp
                      ? timestamp.copyWith(value: event.newValue)
                      : timestamp,
                )
                .toList(),
          ),
        ),
      ),
    );
    on<DeleteDataItem>((final event, final emit) {
      var projectModel = state.projectModel;

      final dataItemId = event.dataItem.id;

      projectModel = _updateDataItemCollection(
        event.dataItem.runtimeType,
        (final collection) => collection
            .where((final dataItem) => dataItem != event.dataItem)
            .toList(),
      );
      projectModel = projectModel.copyWith(
        courses: projectModel.courses
            .where((final course) => course.ownerId != dataItemId)
            .toList(),
        modules: projectModel.modules
            .where((final module) => module.ownerId != dataItemId)
            .toList(),
        studyMaterials: projectModel.studyMaterials
            .where((final studyMaterial) => studyMaterial.ownerId != dataItemId)
            .toList(),
        assignments: projectModel.assignments
            .where((final assignment) => assignment.ownerId != dataItemId)
            .toList(),
        timestamps: projectModel.timestamps
            .where((final timestamp) => timestamp.ownerId != dataItemId)
            .toList(),
      );

      emit(state.copyWith(projectModel: () => projectModel));
    });
    on<UpdateModuleItemContent>((final event, final emit) {
      var projectModel = state.projectModel;

      switch (event.moduleItem) {
        case StudyMaterial _:
          {
            projectModel = projectModel.copyWith(
              studyMaterials: projectModel.studyMaterials
                  .map(
                    (final studyMaterial) => studyMaterial == event.moduleItem
                        ? studyMaterial.copyWith(
                            content: event.content,
                          )
                        : studyMaterial,
                  )
                  .toList(),
            );

            break;
          }
        case Assignment _:
          {
            projectModel = projectModel.copyWith(
              assignments: projectModel.assignments
                  .map(
                    (final assignment) => assignment == event.moduleItem
                        ? assignment.copyWith(
                            content: event.content,
                          )
                        : assignment,
                  )
                  .toList(),
            );

            break;
          }
      }

      emit(state.copyWith(projectModel: () => projectModel));
    });
  }

  ProjectModel _updateDataItemCollection(
    final Type dataItemType,
    final List<DataItemBase> Function(List<DataItemBase> collection) updater,
  ) {
    final projectModel = state.projectModel;

    return switch (dataItemType) {
      const (Course) => projectModel.copyWith(
          courses: updater(projectModel.courses).cast<Course>(),
        ),
      const (Module) => projectModel.copyWith(
          modules: updater(projectModel.modules).cast<Module>(),
        ),
      const (StudyMaterial) => projectModel.copyWith(
          studyMaterials:
              updater(projectModel.studyMaterials).cast<StudyMaterial>(),
        ),
      const (Assignment) => projectModel.copyWith(
          assignments: updater(projectModel.assignments).cast<Assignment>(),
        ),
      const (Timestamp) => projectModel.copyWith(
          timestamps: updater(projectModel.timestamps).cast<Timestamp>(),
        ),
      _ => projectModel,
    };
  }
}
