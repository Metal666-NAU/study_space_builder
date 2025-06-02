part of 'root.dart';

abstract class Event {
  const Event();
}

class Startup extends Event {
  const Startup();
}
