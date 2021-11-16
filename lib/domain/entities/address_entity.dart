import 'package:grocery_store_app/domain/domain.dart';

class AddressEntity extends BaseEntity {
  final String title;
  final String street;
  final String number;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String? additionalInfo;

  AddressEntity({
    String? id,
    this.title = "My Home",
    required this.street,
    required this.number,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    this.additionalInfo,
  }) : super(id);

  @override
  List<Object?> get props => [
        id,
        title,
        street,
        city,
        number,
        state,
        country,
        zipCode,
        additionalInfo,
      ];
}
