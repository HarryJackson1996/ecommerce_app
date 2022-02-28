import 'package:hive/hive.dart';

abstract class IRepository<T> {
  T? get(String id);
  Future<void> put(String id, T object);
}

class HiveRepository<T> implements IRepository<T> {
  final Box _box;

  HiveRepository(this._box);

  @override
  T? get(String id) {
    if (!_box.isOpen) {
      return null;
    }
    return _box.get(id);
  }

  @override
  Future<void> put(String id, T object) async {
    if (_box.isOpen) {
      await _box.put(id, object);
    }
  }
}
