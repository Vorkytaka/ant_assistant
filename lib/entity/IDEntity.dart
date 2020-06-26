class IDEntity<T> {
  final int id;
  final T entity;
  final Function(T) mapper;

  IDEntity(this.id, this.entity, this.mapper);

  Map<String, dynamic> toMap() {
    final map = {"id": id};
    map.addAll(mapper(entity));
    return map;
  }
}
