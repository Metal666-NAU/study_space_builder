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
    on<RenameDataItem>((final event, final emit) {
      var projectModel = state.projectModel;

      switch (event.dataItem) {
        case ProjectModel _:
          {
            projectModel = projectModel.copyWith(name: event.newName);

            break;
          }
        case Course _:
          {
            projectModel = projectModel.copyWith(
              courses: projectModel.courses
                  .map(
                    (final course) => course == event.dataItem
                        ? course.copyWith(name: event.newName)
                        : course,
                  )
                  .toList(),
            );

            break;
          }
        case Module _:
          {
            projectModel = projectModel.copyWith(
              modules: projectModel.modules
                  .map(
                    (final module) => module == event.dataItem
                        ? module.copyWith(name: event.newName)
                        : module,
                  )
                  .toList(),
            );

            break;
          }
        case StudyMaterial _:
          {
            projectModel = projectModel.copyWith(
              studyMaterials: projectModel.studyMaterials
                  .map(
                    (final studyMaterial) => studyMaterial == event.dataItem
                        ? studyMaterial.copyWith(name: event.newName)
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
                    (final assignment) => assignment == event.dataItem
                        ? assignment.copyWith(name: event.newName)
                        : assignment,
                  )
                  .toList(),
            );

            break;
          }
      }

      emit(state.copyWith(projectModel: () => projectModel));
    });
    on<InsertDataItem>((final event, final emit) {
      var projectModel = state.projectModel;

      switch (event.dataItemToInsert) {
        case final Course courseDataItem:
          {
            projectModel = projectModel.copyWith(
              courses: [
                ...projectModel.courses
                    .where((final course) => course != courseDataItem),
                courseDataItem.copyWith(
                  ownerId: event.targetDataItem.id,
                  isPrefixSlot: event.isPrefix,
                ),
              ],
            );

            break;
          }
        case final Module moduleDataItem:
          {
            projectModel = projectModel.copyWith(
              modules: [
                ...projectModel.modules
                    .where((final module) => module != moduleDataItem),
                moduleDataItem.copyWith(
                  ownerId: event.targetDataItem.id,
                  isPrefixSlot: event.isPrefix,
                ),
              ],
            );

            break;
          }
        case final StudyMaterial studyMaterialDataItem:
          {
            projectModel = projectModel.copyWith(
              studyMaterials: [
                ...projectModel.studyMaterials.where(
                  (final studyMaterial) =>
                      studyMaterial != studyMaterialDataItem,
                ),
                studyMaterialDataItem.copyWith(
                  ownerId: event.targetDataItem.id,
                  isPrefixSlot: event.isPrefix,
                ),
              ],
            );

            break;
          }
        case final Assignment assignmentDataItem:
          {
            projectModel = projectModel.copyWith(
              assignments: [
                ...projectModel.assignments.where(
                  (final assignment) => assignment != assignmentDataItem,
                ),
                assignmentDataItem.copyWith(
                  ownerId: event.targetDataItem.id,
                  isPrefixSlot: event.isPrefix,
                ),
              ],
            );

            break;
          }
        case final Timestamp timestampDataItem:
          {
            projectModel = projectModel.copyWith(
              timestamps: [
                ...projectModel.timestamps.where(
                  (final timestamp) => timestamp != timestampDataItem,
                ),
                timestampDataItem.copyWith(
                  ownerId: event.targetDataItem.id,
                  isPrefixSlot: event.isPrefix,
                ),
              ],
            );

            break;
          }
      }

      emit(state.copyWith(projectModel: () => projectModel));
    });
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
    on<DeleteDataItem>((event, emit) {
      var projectModel = state.projectModel;

      final dataItemId = event.dataItem.id;

      switch (event.dataItem) {
        case Course _:
          {
            projectModel = projectModel.copyWith(
              courses: projectModel.courses
                  .where((final course) => course != event.dataItem)
                  .toList(),
            );

            break;
          }
        case Module _:
          {
            projectModel = projectModel.copyWith(
              modules: projectModel.modules
                  .where((final module) => module != event.dataItem)
                  .toList(),
            );

            break;
          }
        case StudyMaterial _:
          {
            projectModel = projectModel.copyWith(
              studyMaterials: projectModel.studyMaterials
                  .where(
                      (final studyMaterial) => studyMaterial != event.dataItem)
                  .toList(),
            );

            break;
          }
        case Assignment _:
          {
            projectModel = projectModel.copyWith(
              assignments: projectModel.assignments
                  .where((final assignment) => assignment != event.dataItem)
                  .toList(),
            );

            break;
          }
        case Timestamp _:
          {
            projectModel = projectModel.copyWith(
              timestamps: projectModel.timestamps
                  .where((final timestamp) => timestamp != event.dataItem)
                  .toList(),
            );

            break;
          }
      }

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
  }
}
