import 'package:dart_mappable/dart_mappable.dart';
import 'package:uuid/uuid.dart';

part 'project_model.mapper.dart';

abstract class IHasName {
  String get name;
}

@MappableClass()
abstract class DataItemBase with DataItemBaseMappable implements IHasName {
  final String id;
  final String? _name;
  final String? ownerId;
  final bool isPrefixSlot;

  bool get hasPrefixSlot => true;
  bool get hasChildrenSlots => true;
  DisplayStyle get displayStyle => DisplayStyle.full;
  String get defaultName;

  @override
  String get name => _name ?? defaultName;

  DataItemBase({
    final String? id,
    final String? name,
    this.ownerId,
    this.isPrefixSlot = false,
  })  : id = id ?? Uuid().v4(),
        _name = name;

  bool canBeParentFor(final DataItemBase childItem) => childItem is Timestamp;
  bool canBePrefixedBy(final DataItemBase prefixItem) =>
      prefixItem is Timestamp;
}

@MappableClass()
class ProjectModel with ProjectModelMappable implements IHasName {
  final List<Course> courses;
  final List<Module> modules;
  final List<StudyMaterial> studyMaterials;
  final List<Assignment> assignments;
  final List<Timestamp> timestamps;

  @override
  final String name;

  List<DataItemBase> get dataItems => [
        ...courses,
        ...modules,
        ...studyMaterials,
        ...assignments,
        ...timestamps,
      ];

  const ProjectModel({
    this.name = 'Unnamed project',
    this.courses = const [],
    this.modules = const [],
    this.studyMaterials = const [],
    this.assignments = const [],
    this.timestamps = const [],
  });

  DataItemBase? findPrefixFor(final DataItemBase ownerDataItem) => dataItems
      .where(
        (final dataItem) =>
            (ownerDataItem.id == dataItem.ownerId) && dataItem.isPrefixSlot,
      )
      .firstOrNull;
  List<DataItemBase> findChildrenFor(final DataItemBase ownerDataItem) =>
      dataItems
          .where(
            (final dataItem) =>
                (ownerDataItem.id == dataItem.ownerId) &&
                !dataItem.isPrefixSlot,
          )
          .toList();
}

@MappableClass()
class Course extends DataItemBase with CourseMappable {
  @override
  String get defaultName => 'Course';

  Course({
    super.id,
    super.name,
    super.ownerId,
    super.isPrefixSlot,
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
    super.ownerId,
    super.isPrefixSlot,
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
    super.ownerId,
    super.isPrefixSlot,
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
    super.ownerId,
    super.isPrefixSlot,
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
    super.ownerId,
    super.isPrefixSlot,
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
  bool get hasChildrenSlots => false;
  @override
  DisplayStyle get displayStyle => DisplayStyle.contentOnly;
  @override
  String get defaultName => 'Timestamp';

  Timestamp({
    super.id,
    super.name,
    super.ownerId,
    super.isPrefixSlot,
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
