import 'package:dart_mappable/dart_mappable.dart';
import 'package:uuid/uuid.dart';

part 'project_model.mapper.dart';

@MappableClass()
abstract class DataItemBase with DataItemBaseMappable {
  final String id;
  final String name;
  final String? ownerId;
  final bool isPrefixSlot;

  bool get hasPrefixSlot => true;
  bool get hasChildrenSlots => true;
  DisplayStyle get displayStyle => DisplayStyle.full;

  DataItemBase({
    required final String? id,
    required this.name,
    required this.ownerId,
    this.isPrefixSlot = false,
  }) : id = id ?? Uuid().v4();

  bool canBeParentFor(final DataItemBase childItem) => childItem is Timestamp;
  bool canBePrefixedBy(final DataItemBase prefixItem) =>
      prefixItem is Timestamp;
}

@MappableClass()
class ProjectModel extends DataItemBase with ProjectModelMappable {
  final List<Course> courses;
  final List<Module> modules;
  final List<StudyMaterial> studyMaterials;
  final List<Assignment> assignments;
  final List<Timestamp> timestamps;

  List<DataItemBase> get dataItems => [
        ...courses,
        ...modules,
        ...studyMaterials,
        ...assignments,
        ...timestamps,
      ];

  ProjectModel({
    super.id,
    super.name = 'Unnamed project',
    super.isPrefixSlot,
    this.courses = const [],
    this.modules = const [],
    this.studyMaterials = const [],
    this.assignments = const [],
    this.timestamps = const [],
  }) : super(ownerId: null);

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

  @override
  bool canBeParentFor(final DataItemBase childItem) =>
      super.canBeParentFor(childItem) || childItem is Course;
}

@MappableClass()
class Course extends DataItemBase with CourseMappable {
  Course({
    super.id,
    super.name = 'Unnamed course',
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
  Module({
    super.id,
    super.name = 'Unnamed module',
    super.ownerId,
    super.isPrefixSlot,
  });

  @override
  bool canBeParentFor(final DataItemBase childItem) =>
      super.canBeParentFor(childItem) || childItem is ModuleItem;
}

@MappableClass()
abstract class ModuleItem extends DataItemBase with ModuleItemMappable {
  ModuleItem({
    super.id,
    super.name = 'Unnamed item',
    super.ownerId,
    super.isPrefixSlot,
  });
}

@MappableClass()
class StudyMaterial extends ModuleItem with StudyMaterialMappable {
  StudyMaterial({
    super.id,
    super.name = 'Material',
    super.ownerId,
    super.isPrefixSlot,
  });
}

@MappableClass()
class Assignment extends ModuleItem with AssignmentMappable {
  Assignment({
    super.id,
    super.name = 'Assignment',
    super.ownerId,
    super.isPrefixSlot,
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

  Timestamp({
    super.id,
    super.ownerId,
    super.isPrefixSlot,
    required this.value,
  }) : super(name: 'Timestamp');

  @override
  bool canBeParentFor(final childItem) => false;
  @override
  bool canBePrefixedBy(final prefixItem) => false;
}

enum DisplayStyle { full, titleOnly, contentOnly }
