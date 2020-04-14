abstract class IRepository<E> {
  Future<E> get (dynamic id);
  Future<Iterable<E>> getAll ();
  Future<void> add (E object);
  Future<void> put (dynamic id, E object);
}