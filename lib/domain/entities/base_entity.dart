import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class BaseEntity extends Equatable {
  late final String id;

  BaseEntity(String? id) {
    this.id = id ?? const Uuid().v4();
  }
}
