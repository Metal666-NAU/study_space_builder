part of 'home.dart';

class Bloc extends flutter_bloc.Bloc<Event, State> {
  final ProjectRepository _projectRepository;

  Bloc({
    required final ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(const State()) {
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
      try {
        final (projectModel, projectPath) = await _projectRepository.get();

        emit(
          state.copyWith(
            projectPath: () => projectPath,
            projectModel: () => projectModel,
          ),
        );
      } on OperationCancelledException {
        return;
      }
    });
    on<SaveProject>((final event, final emit) async {
      try {
        final projectPath = await _projectRepository.save(
          state.projectPath,
          state.projectModel,
        );

        emit(state.copyWith(projectPath: () => projectPath));
      } on OperationCancelledException {
        return;
      }
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
          projectModel: () => state.projectModel.copyWith(
            dataItems: state.projectModel.dataItems
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
          projectModel: () => state.projectModel.copyWith(
            dataItems: [
              ...state.projectModel.dataItems.map(
                (dataItem) {
                  final alreadyHasAsChild =
                      dataItem.childrenIds.contains(event.dataItemToInsert.id);
                  final alreadyHasAsPrefix =
                      dataItem.prefixId == event.dataItemToInsert.id;
                  final shouldHaveAsChild = dataItem == event.parentDataItem;
                  final shouldHaveAsPrefix =
                      shouldHaveAsChild && event.isPrefix;

                  if (alreadyHasAsChild) {
                    dataItem = dataItem.copyWith(
                      childrenIds: dataItem.childrenIds
                          .where(
                            (final childId) =>
                                childId != event.dataItemToInsert.id,
                          )
                          .toList(),
                    );
                  }
                  if (alreadyHasAsPrefix) {
                    dataItem = dataItem.copyWith(prefixId: null);
                  }

                  if (shouldHaveAsPrefix) {
                    dataItem =
                        dataItem.copyWith(prefixId: event.dataItemToInsert.id);
                  } else if (shouldHaveAsChild) {
                    dataItem = dataItem.copyWith(
                      childrenIds: [
                        ...dataItem.childrenIds,
                        event.dataItemToInsert.id,
                      ],
                    );
                  }

                  return dataItem;
                },
              ),
              if (!state.projectModel.dataItems
                  .contains(event.dataItemToInsert))
                event.dataItemToInsert,
            ],
          ),
        ),
      ),
    );
    on<UpdateTimestamp>(
      (final event, final emit) => emit(
        state.copyWith(
          projectModel: () => state.projectModel.copyWith(
            dataItems: state.projectModel.dataItems
                .map(
                  (final dataItem) => dataItem == event.timestamp
                      ? (dataItem as Timestamp).copyWith(value: event.newValue)
                      : dataItem,
                )
                .toList(),
          ),
        ),
      ),
    );
    on<DeleteDataItem>(
      (final event, final emit) => emit(
        state.copyWith(
          projectModel: () => state.projectModel.copyWith(
            dataItems: state.projectModel.dataItems
                .where((final dataItem) => dataItem != event.dataItem)
                .map(
              (dataItem) {
                if (dataItem.childrenIds.contains(event.dataItem.id)) {
                  dataItem = dataItem.copyWith(
                    childrenIds: dataItem.childrenIds
                        .where(
                          (final childId) => childId != event.dataItem.id,
                        )
                        .toList(),
                  );
                }
                if (dataItem.prefixId == event.dataItem.id) {
                  dataItem = dataItem.copyWith(prefixId: null);
                }

                return dataItem;
              },
            ).toList(),
          ),
        ),
      ),
    );
    on<UpdateModuleItemContent>(
      (final event, final emit) => emit(
        state.copyWith(
          projectModel: () => state.projectModel.copyWith(
            dataItems: state.projectModel.dataItems
                .map(
                  (final dataItem) => dataItem == event.moduleItem
                      ? (dataItem as ModuleItem)
                          .copyWith(content: event.content)
                      : dataItem,
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
