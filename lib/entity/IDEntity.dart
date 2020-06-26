class IDEntity<T> {
  final int id;
  final T entity;

  IDEntity(this.id, this.entity);

  Map<String, dynamic> toMap(Function(T) mapper) {
    final map = {"id": id};
    map.addAll(mapper(entity));
    return map;
  }
}
