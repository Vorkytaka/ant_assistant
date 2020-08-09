import 'package:meta/meta.dart';

@immutable
class IDEntity<T> {
  final int id;
  final T entity;

  IDEntity({@required this.id, @required this.entity})
      : assert(id != null),
        assert(entity != null);

  Map<String, dynamic> toMap(Function(T) mapper) {
    final map = {"id": id};
    map.addAll(mapper(entity));
    return map;
  }
}
