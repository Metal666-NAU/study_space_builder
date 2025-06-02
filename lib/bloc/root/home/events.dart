part of 'home.dart';

abstract class Event {
  const Event();
}

class Startup extends Event {
  const Startup();
}

class NewProject extends Event {
  const NewProject();
}

class LoadProject extends Event {
  const LoadProject();
}

class SaveProject extends Event {
  const SaveProject();
}

class ToggleProjectLock extends Event {
  const ToggleProjectLock();
}

class RenameDataItem extends Event {
  final String newName;
  final DataItemBase dataItem;

  const RenameDataItem(this.newName, this.dataItem);
}

class InsertDataItem extends Event {
  final DataItemBase dataItemToInsert;
  final DataItemBase targetDataItem;
  final bool isPrefix;

  const InsertDataItem(
    this.dataItemToInsert,
    this.targetDataItem,
    this.isPrefix,
  );
}

class UpdateTimestamp extends Event {
  final Timestamp timestamp;
  final int newValue;

  const UpdateTimestamp(
    this.timestamp,
    this.newValue,
  );
}

class DeleteDataItem extends Event {
  final DataItemBase dataItem;

  const DeleteDataItem(this.dataItem);
}

class UpdateModuleItemContent extends Event {
  final ModuleItem moduleItem;
  final String content;

  const UpdateModuleItemContent(this.moduleItem, this.content);
}
