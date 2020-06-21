class IDEntity<T extends Mapped> extends Mapped {
  final int id;
  final T entity;

  IDEntity(this.id, this.entity);

  @override
  Map<String, dynamic> toMap() {
    final map = {"id": id};
    map.addAll(entity.toMap());
    return map;
  }
}

abstract class Mapped {
  Map<String, dynamic> toMap();
}
