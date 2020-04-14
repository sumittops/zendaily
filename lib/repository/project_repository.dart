import 'package:flutter/material.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/repository/irepository.dart';

class ProjectRepository implements IRepository<Project> {
  final IRepository<Project> source;
  ProjectRepository({
    @required this.source,
  });

  @override
  Future<Project> get(dynamic id) async {

    final remoteProject = await this.source.get(id);

    return remoteProject;
  }

  @override
  Future<void> add(Project object) async {
    await this.source.add(object);
  }

  @override
  Future<void> put(dynamic id, Project object) async {
    await this.source.put(id, object);
  }

  @override
  Future<Iterable<Project>> getAll() {
    return this.source.getAll();
  }
}