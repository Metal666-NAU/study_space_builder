import 'package:dart_mappable/dart_mappable.dart';
import 'package:uuid/uuid.dart';

part 'project_model.mapper.dart';

abstract class IHasName {
  String? get name;
}

@MappableClass()
abstract class DataItemBase with DataItemBaseMappable implements IHasName {
  final String id;
  final List<String> childrenIds;
  final String? prefixId;

  @override
  final String? name;

  bool get hasPrefixSlot => true;
  bool get hasChildSlots => true;
  DisplayStyle get displayStyle => DisplayStyle.full;
  String get defaultName;
  String get nameOrDefault => name ?? defaultName;

  DataItemBase({
    final String? id,
    this.name,
    this.childrenIds = const [],
    this.prefixId,
  }) : id = id ?? Uuid().v4();

  bool canBeParentFor(final DataItemBase childItem) => childItem is Timestamp;
  bool canBePrefixedBy(final DataItemBase prefixItem) =>
      prefixItem is Timestamp;
}

@MappableClass()
class PackedProjectModel with PackedProjectModelMappable {
  final String name;
  final List<Course> courses;
  final List<Module> modules;
  final List<StudyMaterial> studyMaterials;
  final List<Assignment> assignments;
  final List<Timestamp> timestamps;

  const PackedProjectModel({
    required this.name,
    required this.courses,
    required this.modules,
    required this.studyMaterials,
    required this.assignments,
    required this.timestamps,
  });

  PackedProjectModel.fromModel(final ProjectModel projectModel)
      : this(
          name: projectModel.name,
          courses: getDataItems<Course>(projectModel),
          modules: getDataItems<Module>(projectModel),
          studyMaterials: getDataItems<StudyMaterial>(projectModel),
          assignments: getDataItems<Assignment>(projectModel),
          timestamps: getDataItems<Timestamp>(projectModel),
        );

  static List<T> getDataItems<T>(final ProjectModel projectModel) =>
      projectModel.dataItems.whereType<T>().toList();
}

@MappableClass()
class ProjectModel with ProjectModelMappable implements IHasName {
  final List<DataItemBase> dataItems;

  @override
  final String name;

  const ProjectModel({
    this.name = 'Unnamed project',
    this.dataItems = const [],
  });

  ProjectModel.fromPacked(final PackedProjectModel packedProjectModel)
      : this(
          name: packedProjectModel.name,
          dataItems: [
            ...packedProjectModel.courses,
            ...packedProjectModel.modules,
            ...packedProjectModel.studyMaterials,
            ...packedProjectModel.assignments,
            ...packedProjectModel.timestamps,
          ],
        );

  DataItemBase getItemById(final String id) =>
      dataItems.firstWhere((final dataItem) => dataItem.id == id);
}

@MappableClass()
class Course extends DataItemBase with CourseMappable {
  @override
  String get defaultName => 'Course';

  Course({
    super.id,
    super.name,
    super.childrenIds,
    super.prefixId,
  });

  @override
  bool canBeParentFor(final DataItemBase childItem) =>
      super.canBeParentFor(childItem) ||
      childItem is Module ||
      childItem is StudyMaterial;
}

@MappableClass()
class Module extends DataItemBase with ModuleMappable {
  @override
  String get defaultName => 'Module';

  Module({
    super.id,
    super.name,
    super.childrenIds,
    super.prefixId,
  });

  @override
  bool canBeParentFor(final DataItemBase childItem) =>
      super.canBeParentFor(childItem) || childItem is ModuleItem;
}

@MappableClass()
abstract class ModuleItem extends DataItemBase with ModuleItemMappable {
  final String content;

  ModuleItem({
    super.id,
    super.name,
    super.childrenIds,
    super.prefixId,
    this.content = '',
  });
}

@MappableClass()
class StudyMaterial extends ModuleItem with StudyMaterialMappable {
  @override
  String get defaultName => 'Material';

  StudyMaterial({
    super.id,
    super.name,
    super.childrenIds,
    super.prefixId,
    super.content,
  });
}

@MappableClass()
class Assignment extends ModuleItem with AssignmentMappable {
  @override
  String get defaultName => 'Assignment';

  Assignment({
    super.id,
    super.name,
    super.childrenIds,
    super.prefixId,
    super.content,
  });
}

@MappableClass()
class Timestamp extends DataItemBase with TimestampMappable {
  final int value;

  DateTime get valueDateTime => DateTime.fromMillisecondsSinceEpoch(value);

  @override
  bool get hasPrefixSlot => false;
  @override
  bool get hasChildSlots => false;
  @override
  DisplayStyle get displayStyle => DisplayStyle.contentOnly;
  @override
  String get defaultName => 'Timestamp';

  Timestamp({
    super.id,
    super.name,
    super.childrenIds,
    super.prefixId,
    final int? value,
  }) : value = value ?? DateTime.now().millisecondsSinceEpoch;

  @override
  bool canBeParentFor(final childItem) => false;
  @override
  bool canBePrefixedBy(final prefixItem) => false;
}

enum DisplayStyle {
  full,
  titleOnly,
  contentOnly,
}
