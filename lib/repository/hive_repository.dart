import 'package:hive/hive.dart';
import 'package:zendaily/repository/irepository.dart';

class HiveRepository<T> implements IRepository<T> {
  final Box _box;

  HiveRepository(this._box);

  @override
  Future<T> get(dynamic id) async {
    if (this.boxIsClosed) {
      return null;
    }

    return this._box.get(id);
  }

  @override
  Future<void> add(T object) async {
    if (this.boxIsClosed) {
      return;
    }

    await this._box.add(object);
  }

  bool get boxIsClosed => !(this._box?.isOpen ?? false);
}