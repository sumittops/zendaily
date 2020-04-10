abstract class IRepository<E> {
  Future<E> get (dynamic id);
  Future<void> add (E object);
}