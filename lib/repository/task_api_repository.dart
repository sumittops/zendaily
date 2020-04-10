import 'package:zendaily/repository/irepository.dart';
import 'package:zendaily/models/task.dart';

class TaskApiRepository implements IRepository<Task> {
  @override
  Future<void> add(object) => Future.delayed(Duration(seconds: 2), () {
        //Send to a remote data source
      });

  @override
  Future<Task> get(id) =>
      Future.delayed(Duration(seconds: 2), () => Task());
}