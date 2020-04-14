import 'package:flutter/material.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/repository/irepository.dart';

class TaskRepository implements IRepository<Task> {
  final IRepository<Task> source;
  TaskRepository({
    @required this.source,
  });

  @override
  Future<Task> get(dynamic id) async {

    final remoteTask = await this.source.get(id);

    return remoteTask;
  }

  @override
  Future<void> add(Task object) async {
    await this.source.add(object);
  }

  @override
  Future<void> put(dynamic id, Task object) async {
    await this.source.put(id, object);
  }

  @override
  Future<Iterable<Task>> getAll() {
    return this.source.getAll();
  }
}