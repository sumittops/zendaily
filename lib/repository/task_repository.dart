import 'package:flutter/material.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/repository/irepository.dart';

class TaskRepository implements IRepository<Task> {
  final IRepository<Task> source;
  final IRepository<Task> cache;
  final bool Function() hasConnection;
  TaskRepository({
    @required this.source,
    @required this.cache,
    @required this.hasConnection,
  });

  @override
  Future<Task> get(dynamic id) async {
    final cachedTask = await this.cache.get(id);

    if (cachedTask != null) {
      return cachedTask;
    }

    if (!this.hasConnection()) {
      throw Exception('No connection');
    }

    final remoteTask = await this.source.get(id);
    this.cache.add(remoteTask);

    return remoteTask;
  }

  @override
  Future<void> add(Task object) async {
    if (!this.hasConnection()) {
      throw Exception('No connection');
    }

    await this.source.add(object);
    await this.cache.add(object);
  }
}