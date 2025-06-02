// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'project_model.dart';

class DataItemBaseMapper extends ClassMapperBase<DataItemBase> {
  DataItemBaseMapper._();

  static DataItemBaseMapper? _instance;
  static DataItemBaseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataItemBaseMapper._());
      ProjectModelMapper.ensureInitialized();
      CourseMapper.ensureInitialized();
      ModuleMapper.ensureInitialized();
      ModuleItemMapper.ensureInitialized();
      TimestampMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DataItemBase';

  static String _$id(DataItemBase v) => v.id;
  static const Field<DataItemBase, String> _f$id = Field('id', _$id);
  static String _$name(DataItemBase v) => v.name;
  static const Field<DataItemBase, String> _f$name = Field('name', _$name);
  static String? _$ownerId(DataItemBase v) => v.ownerId;
  static const Field<DataItemBase, String> _f$ownerId =
      Field('ownerId', _$ownerId);
  static bool _$isPrefixSlot(DataItemBase v) => v.isPrefixSlot;
  static const Field<DataItemBase, bool> _f$isPrefixSlot =
      Field('isPrefixSlot', _$isPrefixSlot, opt: true, def: false);

  @override
  final MappableFields<DataItemBase> fields = const {
    #id: _f$id,
    #name: _f$name,
    #ownerId: _f$ownerId,
    #isPrefixSlot: _f$isPrefixSlot,
  };

  static DataItemBase _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('DataItemBase');
  }

  @override
  final Function instantiate = _instantiate;

  static DataItemBase fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataItemBase>(map);
  }

  static DataItemBase fromJson(String json) {
    return ensureInitialized().decodeJson<DataItemBase>(json);
  }
}

mixin DataItemBaseMappable {
  String toJson();
  Map<String, dynamic> toMap();
  DataItemBaseCopyWith<DataItemBase, DataItemBase, DataItemBase> get copyWith;
}

abstract class DataItemBaseCopyWith<$R, $In extends DataItemBase, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, bool? isPrefixSlot});
  DataItemBaseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ProjectModelMapper extends ClassMapperBase<ProjectModel> {
  ProjectModelMapper._();

  static ProjectModelMapper? _instance;
  static ProjectModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProjectModelMapper._());
      DataItemBaseMapper.ensureInitialized();
      CourseMapper.ensureInitialized();
      ModuleMapper.ensureInitialized();
      StudyMaterialMapper.ensureInitialized();
      AssignmentMapper.ensureInitialized();
      TimestampMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProjectModel';

  static String _$id(ProjectModel v) => v.id;
  static const Field<ProjectModel, String> _f$id = Field('id', _$id, opt: true);
  static String _$name(ProjectModel v) => v.name;
  static const Field<ProjectModel, String> _f$name =
      Field('name', _$name, opt: true, def: 'Unnamed project');
  static bool _$isPrefixSlot(ProjectModel v) => v.isPrefixSlot;
  static const Field<ProjectModel, bool> _f$isPrefixSlot =
      Field('isPrefixSlot', _$isPrefixSlot, opt: true, def: false);
  static List<Course> _$courses(ProjectModel v) => v.courses;
  static const Field<ProjectModel, List<Course>> _f$courses =
      Field('courses', _$courses, opt: true, def: const []);
  static List<Module> _$modules(ProjectModel v) => v.modules;
  static const Field<ProjectModel, List<Module>> _f$modules =
      Field('modules', _$modules, opt: true, def: const []);
  static List<StudyMaterial> _$studyMaterials(ProjectModel v) =>
      v.studyMaterials;
  static const Field<ProjectModel, List<StudyMaterial>> _f$studyMaterials =
      Field('studyMaterials', _$studyMaterials, opt: true, def: const []);
  static List<Assignment> _$assignments(ProjectModel v) => v.assignments;
  static const Field<ProjectModel, List<Assignment>> _f$assignments =
      Field('assignments', _$assignments, opt: true, def: const []);
  static List<Timestamp> _$timestamps(ProjectModel v) => v.timestamps;
  static const Field<ProjectModel, List<Timestamp>> _f$timestamps =
      Field('timestamps', _$timestamps, opt: true, def: const []);
  static String? _$ownerId(ProjectModel v) => v.ownerId;
  static const Field<ProjectModel, String> _f$ownerId =
      Field('ownerId', _$ownerId, mode: FieldMode.member);

  @override
  final MappableFields<ProjectModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #isPrefixSlot: _f$isPrefixSlot,
    #courses: _f$courses,
    #modules: _f$modules,
    #studyMaterials: _f$studyMaterials,
    #assignments: _f$assignments,
    #timestamps: _f$timestamps,
    #ownerId: _f$ownerId,
  };

  static ProjectModel _instantiate(DecodingData data) {
    return ProjectModel(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        isPrefixSlot: data.dec(_f$isPrefixSlot),
        courses: data.dec(_f$courses),
        modules: data.dec(_f$modules),
        studyMaterials: data.dec(_f$studyMaterials),
        assignments: data.dec(_f$assignments),
        timestamps: data.dec(_f$timestamps));
  }

  @override
  final Function instantiate = _instantiate;

  static ProjectModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProjectModel>(map);
  }

  static ProjectModel fromJson(String json) {
    return ensureInitialized().decodeJson<ProjectModel>(json);
  }
}

mixin ProjectModelMappable {
  String toJson() {
    return ProjectModelMapper.ensureInitialized()
        .encodeJson<ProjectModel>(this as ProjectModel);
  }

  Map<String, dynamic> toMap() {
    return ProjectModelMapper.ensureInitialized()
        .encodeMap<ProjectModel>(this as ProjectModel);
  }

  ProjectModelCopyWith<ProjectModel, ProjectModel, ProjectModel> get copyWith =>
      _ProjectModelCopyWithImpl<ProjectModel, ProjectModel>(
          this as ProjectModel, $identity, $identity);
  @override
  String toString() {
    return ProjectModelMapper.ensureInitialized()
        .stringifyValue(this as ProjectModel);
  }

  @override
  bool operator ==(Object other) {
    return ProjectModelMapper.ensureInitialized()
        .equalsValue(this as ProjectModel, other);
  }

  @override
  int get hashCode {
    return ProjectModelMapper.ensureInitialized()
        .hashValue(this as ProjectModel);
  }
}

extension ProjectModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProjectModel, $Out> {
  ProjectModelCopyWith<$R, ProjectModel, $Out> get $asProjectModel =>
      $base.as((v, t, t2) => _ProjectModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProjectModelCopyWith<$R, $In extends ProjectModel, $Out>
    implements DataItemBaseCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Course, CourseCopyWith<$R, Course, Course>> get courses;
  ListCopyWith<$R, Module, ModuleCopyWith<$R, Module, Module>> get modules;
  ListCopyWith<$R, StudyMaterial,
          StudyMaterialCopyWith<$R, StudyMaterial, StudyMaterial>>
      get studyMaterials;
  ListCopyWith<$R, Assignment, AssignmentCopyWith<$R, Assignment, Assignment>>
      get assignments;
  ListCopyWith<$R, Timestamp, TimestampCopyWith<$R, Timestamp, Timestamp>>
      get timestamps;
  @override
  $R call(
      {String? id,
      String? name,
      bool? isPrefixSlot,
      List<Course>? courses,
      List<Module>? modules,
      List<StudyMaterial>? studyMaterials,
      List<Assignment>? assignments,
      List<Timestamp>? timestamps});
  ProjectModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProjectModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProjectModel, $Out>
    implements ProjectModelCopyWith<$R, ProjectModel, $Out> {
  _ProjectModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProjectModel> $mapper =
      ProjectModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Course, CourseCopyWith<$R, Course, Course>> get courses =>
      ListCopyWith($value.courses, (v, t) => v.copyWith.$chain(t),
          (v) => call(courses: v));
  @override
  ListCopyWith<$R, Module, ModuleCopyWith<$R, Module, Module>> get modules =>
      ListCopyWith($value.modules, (v, t) => v.copyWith.$chain(t),
          (v) => call(modules: v));
  @override
  ListCopyWith<$R, StudyMaterial,
          StudyMaterialCopyWith<$R, StudyMaterial, StudyMaterial>>
      get studyMaterials => ListCopyWith($value.studyMaterials,
          (v, t) => v.copyWith.$chain(t), (v) => call(studyMaterials: v));
  @override
  ListCopyWith<$R, Assignment, AssignmentCopyWith<$R, Assignment, Assignment>>
      get assignments => ListCopyWith($value.assignments,
          (v, t) => v.copyWith.$chain(t), (v) => call(assignments: v));
  @override
  ListCopyWith<$R, Timestamp, TimestampCopyWith<$R, Timestamp, Timestamp>>
      get timestamps => ListCopyWith($value.timestamps,
          (v, t) => v.copyWith.$chain(t), (v) => call(timestamps: v));
  @override
  $R call(
          {Object? id = $none,
          String? name,
          bool? isPrefixSlot,
          List<Course>? courses,
          List<Module>? modules,
          List<StudyMaterial>? studyMaterials,
          List<Assignment>? assignments,
          List<Timestamp>? timestamps}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (isPrefixSlot != null) #isPrefixSlot: isPrefixSlot,
        if (courses != null) #courses: courses,
        if (modules != null) #modules: modules,
        if (studyMaterials != null) #studyMaterials: studyMaterials,
        if (assignments != null) #assignments: assignments,
        if (timestamps != null) #timestamps: timestamps
      }));
  @override
  ProjectModel $make(CopyWithData data) => ProjectModel(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      isPrefixSlot: data.get(#isPrefixSlot, or: $value.isPrefixSlot),
      courses: data.get(#courses, or: $value.courses),
      modules: data.get(#modules, or: $value.modules),
      studyMaterials: data.get(#studyMaterials, or: $value.studyMaterials),
      assignments: data.get(#assignments, or: $value.assignments),
      timestamps: data.get(#timestamps, or: $value.timestamps));

  @override
  ProjectModelCopyWith<$R2, ProjectModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProjectModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CourseMapper extends ClassMapperBase<Course> {
  CourseMapper._();

  static CourseMapper? _instance;
  static CourseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CourseMapper._());
      DataItemBaseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Course';

  static String _$id(Course v) => v.id;
  static const Field<Course, String> _f$id = Field('id', _$id, opt: true);
  static String _$name(Course v) => v.name;
  static const Field<Course, String> _f$name =
      Field('name', _$name, opt: true, def: 'Unnamed course');
  static String? _$ownerId(Course v) => v.ownerId;
  static const Field<Course, String> _f$ownerId =
      Field('ownerId', _$ownerId, opt: true);
  static bool _$isPrefixSlot(Course v) => v.isPrefixSlot;
  static const Field<Course, bool> _f$isPrefixSlot =
      Field('isPrefixSlot', _$isPrefixSlot, opt: true, def: false);

  @override
  final MappableFields<Course> fields = const {
    #id: _f$id,
    #name: _f$name,
    #ownerId: _f$ownerId,
    #isPrefixSlot: _f$isPrefixSlot,
  };

  static Course _instantiate(DecodingData data) {
    return Course(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        ownerId: data.dec(_f$ownerId),
        isPrefixSlot: data.dec(_f$isPrefixSlot));
  }

  @override
  final Function instantiate = _instantiate;

  static Course fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Course>(map);
  }

  static Course fromJson(String json) {
    return ensureInitialized().decodeJson<Course>(json);
  }
}

mixin CourseMappable {
  String toJson() {
    return CourseMapper.ensureInitialized().encodeJson<Course>(this as Course);
  }

  Map<String, dynamic> toMap() {
    return CourseMapper.ensureInitialized().encodeMap<Course>(this as Course);
  }

  CourseCopyWith<Course, Course, Course> get copyWith =>
      _CourseCopyWithImpl<Course, Course>(this as Course, $identity, $identity);
  @override
  String toString() {
    return CourseMapper.ensureInitialized().stringifyValue(this as Course);
  }

  @override
  bool operator ==(Object other) {
    return CourseMapper.ensureInitialized().equalsValue(this as Course, other);
  }

  @override
  int get hashCode {
    return CourseMapper.ensureInitialized().hashValue(this as Course);
  }
}

extension CourseValueCopy<$R, $Out> on ObjectCopyWith<$R, Course, $Out> {
  CourseCopyWith<$R, Course, $Out> get $asCourse =>
      $base.as((v, t, t2) => _CourseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CourseCopyWith<$R, $In extends Course, $Out>
    implements DataItemBaseCopyWith<$R, $In, $Out> {
  @override
  $R call({String? id, String? name, String? ownerId, bool? isPrefixSlot});
  CourseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CourseCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Course, $Out>
    implements CourseCopyWith<$R, Course, $Out> {
  _CourseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Course> $mapper = CourseMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? name,
          Object? ownerId = $none,
          bool? isPrefixSlot}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (ownerId != $none) #ownerId: ownerId,
        if (isPrefixSlot != null) #isPrefixSlot: isPrefixSlot
      }));
  @override
  Course $make(CopyWithData data) => Course(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      ownerId: data.get(#ownerId, or: $value.ownerId),
      isPrefixSlot: data.get(#isPrefixSlot, or: $value.isPrefixSlot));

  @override
  CourseCopyWith<$R2, Course, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CourseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ModuleMapper extends ClassMapperBase<Module> {
  ModuleMapper._();

  static ModuleMapper? _instance;
  static ModuleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ModuleMapper._());
      DataItemBaseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Module';

  static String _$id(Module v) => v.id;
  static const Field<Module, String> _f$id = Field('id', _$id, opt: true);
  static String _$name(Module v) => v.name;
  static const Field<Module, String> _f$name =
      Field('name', _$name, opt: true, def: 'Unnamed module');
  static String? _$ownerId(Module v) => v.ownerId;
  static const Field<Module, String> _f$ownerId =
      Field('ownerId', _$ownerId, opt: true);
  static bool _$isPrefixSlot(Module v) => v.isPrefixSlot;
  static const Field<Module, bool> _f$isPrefixSlot =
      Field('isPrefixSlot', _$isPrefixSlot, opt: true, def: false);

  @override
  final MappableFields<Module> fields = const {
    #id: _f$id,
    #name: _f$name,
    #ownerId: _f$ownerId,
    #isPrefixSlot: _f$isPrefixSlot,
  };

  static Module _instantiate(DecodingData data) {
    return Module(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        ownerId: data.dec(_f$ownerId),
        isPrefixSlot: data.dec(_f$isPrefixSlot));
  }

  @override
  final Function instantiate = _instantiate;

  static Module fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Module>(map);
  }

  static Module fromJson(String json) {
    return ensureInitialized().decodeJson<Module>(json);
  }
}

mixin ModuleMappable {
  String toJson() {
    return ModuleMapper.ensureInitialized().encodeJson<Module>(this as Module);
  }

  Map<String, dynamic> toMap() {
    return ModuleMapper.ensureInitialized().encodeMap<Module>(this as Module);
  }

  ModuleCopyWith<Module, Module, Module> get copyWith =>
      _ModuleCopyWithImpl<Module, Module>(this as Module, $identity, $identity);
  @override
  String toString() {
    return ModuleMapper.ensureInitialized().stringifyValue(this as Module);
  }

  @override
  bool operator ==(Object other) {
    return ModuleMapper.ensureInitialized().equalsValue(this as Module, other);
  }

  @override
  int get hashCode {
    return ModuleMapper.ensureInitialized().hashValue(this as Module);
  }
}

extension ModuleValueCopy<$R, $Out> on ObjectCopyWith<$R, Module, $Out> {
  ModuleCopyWith<$R, Module, $Out> get $asModule =>
      $base.as((v, t, t2) => _ModuleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ModuleCopyWith<$R, $In extends Module, $Out>
    implements DataItemBaseCopyWith<$R, $In, $Out> {
  @override
  $R call({String? id, String? name, String? ownerId, bool? isPrefixSlot});
  ModuleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ModuleCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Module, $Out>
    implements ModuleCopyWith<$R, Module, $Out> {
  _ModuleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Module> $mapper = ModuleMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? name,
          Object? ownerId = $none,
          bool? isPrefixSlot}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (ownerId != $none) #ownerId: ownerId,
        if (isPrefixSlot != null) #isPrefixSlot: isPrefixSlot
      }));
  @override
  Module $make(CopyWithData data) => Module(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      ownerId: data.get(#ownerId, or: $value.ownerId),
      isPrefixSlot: data.get(#isPrefixSlot, or: $value.isPrefixSlot));

  @override
  ModuleCopyWith<$R2, Module, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ModuleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class StudyMaterialMapper extends ClassMapperBase<StudyMaterial> {
  StudyMaterialMapper._();

  static StudyMaterialMapper? _instance;
  static StudyMaterialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StudyMaterialMapper._());
      ModuleItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StudyMaterial';

  static String _$id(StudyMaterial v) => v.id;
  static const Field<StudyMaterial, String> _f$id =
      Field('id', _$id, opt: true);
  static String _$name(StudyMaterial v) => v.name;
  static const Field<StudyMaterial, String> _f$name =
      Field('name', _$name, opt: true, def: 'Material');
  static String? _$ownerId(StudyMaterial v) => v.ownerId;
  static const Field<StudyMaterial, String> _f$ownerId =
      Field('ownerId', _$ownerId, opt: true);
  static bool _$isPrefixSlot(StudyMaterial v) => v.isPrefixSlot;
  static const Field<StudyMaterial, bool> _f$isPrefixSlot =
      Field('isPrefixSlot', _$isPrefixSlot, opt: true, def: false);
  static String _$content(StudyMaterial v) => v.content;
  static const Field<StudyMaterial, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<StudyMaterial> fields = const {
    #id: _f$id,
    #name: _f$name,
    #ownerId: _f$ownerId,
    #isPrefixSlot: _f$isPrefixSlot,
    #content: _f$content,
  };

  static StudyMaterial _instantiate(DecodingData data) {
    return StudyMaterial(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        ownerId: data.dec(_f$ownerId),
        isPrefixSlot: data.dec(_f$isPrefixSlot),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static StudyMaterial fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StudyMaterial>(map);
  }

  static StudyMaterial fromJson(String json) {
    return ensureInitialized().decodeJson<StudyMaterial>(json);
  }
}

mixin StudyMaterialMappable {
  String toJson() {
    return StudyMaterialMapper.ensureInitialized()
        .encodeJson<StudyMaterial>(this as StudyMaterial);
  }

  Map<String, dynamic> toMap() {
    return StudyMaterialMapper.ensureInitialized()
        .encodeMap<StudyMaterial>(this as StudyMaterial);
  }

  StudyMaterialCopyWith<StudyMaterial, StudyMaterial, StudyMaterial>
      get copyWith => _StudyMaterialCopyWithImpl<StudyMaterial, StudyMaterial>(
          this as StudyMaterial, $identity, $identity);
  @override
  String toString() {
    return StudyMaterialMapper.ensureInitialized()
        .stringifyValue(this as StudyMaterial);
  }

  @override
  bool operator ==(Object other) {
    return StudyMaterialMapper.ensureInitialized()
        .equalsValue(this as StudyMaterial, other);
  }

  @override
  int get hashCode {
    return StudyMaterialMapper.ensureInitialized()
        .hashValue(this as StudyMaterial);
  }
}

extension StudyMaterialValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StudyMaterial, $Out> {
  StudyMaterialCopyWith<$R, StudyMaterial, $Out> get $asStudyMaterial =>
      $base.as((v, t, t2) => _StudyMaterialCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StudyMaterialCopyWith<$R, $In extends StudyMaterial, $Out>
    implements ModuleItemCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? name,
      String? ownerId,
      bool? isPrefixSlot,
      String? content});
  StudyMaterialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StudyMaterialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StudyMaterial, $Out>
    implements StudyMaterialCopyWith<$R, StudyMaterial, $Out> {
  _StudyMaterialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StudyMaterial> $mapper =
      StudyMaterialMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? name,
          Object? ownerId = $none,
          bool? isPrefixSlot,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (ownerId != $none) #ownerId: ownerId,
        if (isPrefixSlot != null) #isPrefixSlot: isPrefixSlot,
        if (content != null) #content: content
      }));
  @override
  StudyMaterial $make(CopyWithData data) => StudyMaterial(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      ownerId: data.get(#ownerId, or: $value.ownerId),
      isPrefixSlot: data.get(#isPrefixSlot, or: $value.isPrefixSlot),
      content: data.get(#content, or: $value.content));

  @override
  StudyMaterialCopyWith<$R2, StudyMaterial, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StudyMaterialCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ModuleItemMapper extends ClassMapperBase<ModuleItem> {
  ModuleItemMapper._();

  static ModuleItemMapper? _instance;
  static ModuleItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ModuleItemMapper._());
      DataItemBaseMapper.ensureInitialized();
      StudyMaterialMapper.ensureInitialized();
      AssignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ModuleItem';

  static String _$id(ModuleItem v) => v.id;
  static const Field<ModuleItem, String> _f$id = Field('id', _$id, opt: true);
  static String _$name(ModuleItem v) => v.name;
  static const Field<ModuleItem, String> _f$name =
      Field('name', _$name, opt: true, def: 'Unnamed item');
  static String? _$ownerId(ModuleItem v) => v.ownerId;
  static const Field<ModuleItem, String> _f$ownerId =
      Field('ownerId', _$ownerId, opt: true);
  static bool _$isPrefixSlot(ModuleItem v) => v.isPrefixSlot;
  static const Field<ModuleItem, bool> _f$isPrefixSlot =
      Field('isPrefixSlot', _$isPrefixSlot, opt: true, def: false);
  static String _$content(ModuleItem v) => v.content;
  static const Field<ModuleItem, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<ModuleItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #ownerId: _f$ownerId,
    #isPrefixSlot: _f$isPrefixSlot,
    #content: _f$content,
  };

  static ModuleItem _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('ModuleItem');
  }

  @override
  final Function instantiate = _instantiate;

  static ModuleItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ModuleItem>(map);
  }

  static ModuleItem fromJson(String json) {
    return ensureInitialized().decodeJson<ModuleItem>(json);
  }
}

mixin ModuleItemMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ModuleItemCopyWith<ModuleItem, ModuleItem, ModuleItem> get copyWith;
}

abstract class ModuleItemCopyWith<$R, $In extends ModuleItem, $Out>
    implements DataItemBaseCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? name,
      String? ownerId,
      bool? isPrefixSlot,
      String? content});
  ModuleItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class AssignmentMapper extends ClassMapperBase<Assignment> {
  AssignmentMapper._();

  static AssignmentMapper? _instance;
  static AssignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignmentMapper._());
      ModuleItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Assignment';

  static String _$id(Assignment v) => v.id;
  static const Field<Assignment, String> _f$id = Field('id', _$id, opt: true);
  static String _$name(Assignment v) => v.name;
  static const Field<Assignment, String> _f$name =
      Field('name', _$name, opt: true, def: 'Assignment');
  static String? _$ownerId(Assignment v) => v.ownerId;
  static const Field<Assignment, String> _f$ownerId =
      Field('ownerId', _$ownerId, opt: true);
  static bool _$isPrefixSlot(Assignment v) => v.isPrefixSlot;
  static const Field<Assignment, bool> _f$isPrefixSlot =
      Field('isPrefixSlot', _$isPrefixSlot, opt: true, def: false);
  static String _$content(Assignment v) => v.content;
  static const Field<Assignment, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<Assignment> fields = const {
    #id: _f$id,
    #name: _f$name,
    #ownerId: _f$ownerId,
    #isPrefixSlot: _f$isPrefixSlot,
    #content: _f$content,
  };

  static Assignment _instantiate(DecodingData data) {
    return Assignment(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        ownerId: data.dec(_f$ownerId),
        isPrefixSlot: data.dec(_f$isPrefixSlot),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static Assignment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Assignment>(map);
  }

  static Assignment fromJson(String json) {
    return ensureInitialized().decodeJson<Assignment>(json);
  }
}

mixin AssignmentMappable {
  String toJson() {
    return AssignmentMapper.ensureInitialized()
        .encodeJson<Assignment>(this as Assignment);
  }

  Map<String, dynamic> toMap() {
    return AssignmentMapper.ensureInitialized()
        .encodeMap<Assignment>(this as Assignment);
  }

  AssignmentCopyWith<Assignment, Assignment, Assignment> get copyWith =>
      _AssignmentCopyWithImpl<Assignment, Assignment>(
          this as Assignment, $identity, $identity);
  @override
  String toString() {
    return AssignmentMapper.ensureInitialized()
        .stringifyValue(this as Assignment);
  }

  @override
  bool operator ==(Object other) {
    return AssignmentMapper.ensureInitialized()
        .equalsValue(this as Assignment, other);
  }

  @override
  int get hashCode {
    return AssignmentMapper.ensureInitialized().hashValue(this as Assignment);
  }
}

extension AssignmentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Assignment, $Out> {
  AssignmentCopyWith<$R, Assignment, $Out> get $asAssignment =>
      $base.as((v, t, t2) => _AssignmentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssignmentCopyWith<$R, $In extends Assignment, $Out>
    implements ModuleItemCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? name,
      String? ownerId,
      bool? isPrefixSlot,
      String? content});
  AssignmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssignmentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Assignment, $Out>
    implements AssignmentCopyWith<$R, Assignment, $Out> {
  _AssignmentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Assignment> $mapper =
      AssignmentMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? name,
          Object? ownerId = $none,
          bool? isPrefixSlot,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (ownerId != $none) #ownerId: ownerId,
        if (isPrefixSlot != null) #isPrefixSlot: isPrefixSlot,
        if (content != null) #content: content
      }));
  @override
  Assignment $make(CopyWithData data) => Assignment(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      ownerId: data.get(#ownerId, or: $value.ownerId),
      isPrefixSlot: data.get(#isPrefixSlot, or: $value.isPrefixSlot),
      content: data.get(#content, or: $value.content));

  @override
  AssignmentCopyWith<$R2, Assignment, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AssignmentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TimestampMapper extends ClassMapperBase<Timestamp> {
  TimestampMapper._();

  static TimestampMapper? _instance;
  static TimestampMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TimestampMapper._());
      DataItemBaseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Timestamp';

  static String _$id(Timestamp v) => v.id;
  static const Field<Timestamp, String> _f$id = Field('id', _$id, opt: true);
  static String? _$ownerId(Timestamp v) => v.ownerId;
  static const Field<Timestamp, String> _f$ownerId =
      Field('ownerId', _$ownerId, opt: true);
  static bool _$isPrefixSlot(Timestamp v) => v.isPrefixSlot;
  static const Field<Timestamp, bool> _f$isPrefixSlot =
      Field('isPrefixSlot', _$isPrefixSlot, opt: true, def: false);
  static int _$value(Timestamp v) => v.value;
  static const Field<Timestamp, int> _f$value = Field('value', _$value);
  static String _$name(Timestamp v) => v.name;
  static const Field<Timestamp, String> _f$name =
      Field('name', _$name, mode: FieldMode.member);

  @override
  final MappableFields<Timestamp> fields = const {
    #id: _f$id,
    #ownerId: _f$ownerId,
    #isPrefixSlot: _f$isPrefixSlot,
    #value: _f$value,
    #name: _f$name,
  };

  static Timestamp _instantiate(DecodingData data) {
    return Timestamp(
        id: data.dec(_f$id),
        ownerId: data.dec(_f$ownerId),
        isPrefixSlot: data.dec(_f$isPrefixSlot),
        value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static Timestamp fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Timestamp>(map);
  }

  static Timestamp fromJson(String json) {
    return ensureInitialized().decodeJson<Timestamp>(json);
  }
}

mixin TimestampMappable {
  String toJson() {
    return TimestampMapper.ensureInitialized()
        .encodeJson<Timestamp>(this as Timestamp);
  }

  Map<String, dynamic> toMap() {
    return TimestampMapper.ensureInitialized()
        .encodeMap<Timestamp>(this as Timestamp);
  }

  TimestampCopyWith<Timestamp, Timestamp, Timestamp> get copyWith =>
      _TimestampCopyWithImpl<Timestamp, Timestamp>(
          this as Timestamp, $identity, $identity);
  @override
  String toString() {
    return TimestampMapper.ensureInitialized()
        .stringifyValue(this as Timestamp);
  }

  @override
  bool operator ==(Object other) {
    return TimestampMapper.ensureInitialized()
        .equalsValue(this as Timestamp, other);
  }

  @override
  int get hashCode {
    return TimestampMapper.ensureInitialized().hashValue(this as Timestamp);
  }
}

extension TimestampValueCopy<$R, $Out> on ObjectCopyWith<$R, Timestamp, $Out> {
  TimestampCopyWith<$R, Timestamp, $Out> get $asTimestamp =>
      $base.as((v, t, t2) => _TimestampCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TimestampCopyWith<$R, $In extends Timestamp, $Out>
    implements DataItemBaseCopyWith<$R, $In, $Out> {
  @override
  $R call({String? id, String? ownerId, bool? isPrefixSlot, int? value});
  TimestampCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TimestampCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Timestamp, $Out>
    implements TimestampCopyWith<$R, Timestamp, $Out> {
  _TimestampCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Timestamp> $mapper =
      TimestampMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? ownerId = $none,
          bool? isPrefixSlot,
          int? value}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (ownerId != $none) #ownerId: ownerId,
        if (isPrefixSlot != null) #isPrefixSlot: isPrefixSlot,
        if (value != null) #value: value
      }));
  @override
  Timestamp $make(CopyWithData data) => Timestamp(
      id: data.get(#id, or: $value.id),
      ownerId: data.get(#ownerId, or: $value.ownerId),
      isPrefixSlot: data.get(#isPrefixSlot, or: $value.isPrefixSlot),
      value: data.get(#value, or: $value.value));

  @override
  TimestampCopyWith<$R2, Timestamp, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TimestampCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
