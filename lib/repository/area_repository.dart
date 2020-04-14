import 'package:flutter/material.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/repository/irepository.dart';

class AreaRepository implements IRepository<Area> {
  final IRepository<Area> source;
  AreaRepository({
    @required this.source,
  });

  @override
  Future<Area> get(dynamic id) async {

    final remoteArea = await this.source.get(id);

    return remoteArea;
  }

  @override
  Future<void> add(Area object) async {
    await this.source.add(object);
  }

  @override
  Future<void> put(dynamic id, Area object) async {
    await this.source.put(id, object);
  }

  @override
  Future<Iterable<Area>> getAll() async { 
    return this.source.getAll();
  }
}