import 'entities.dart';

class UserEntity extends BaseEntity {
  final String name;
  final String cpf;
  final AddressEntity mainAddress;

  UserEntity({
    String? id,
    required this.name,
    required this.cpf,
    required this.mainAddress,
  }) : super(id);

  @override
  List<Object?> get props => [
        id,
        name,
        cpf,
        mainAddress,
      ];
}
