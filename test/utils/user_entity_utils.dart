import 'package:faker/faker.dart';
import 'package:grocery_store_app/domain/domain.dart';

UserEntity makeUserEntity({String? name}) {
  return UserEntity(
    id: faker.guid.guid(),
    name: name ?? faker.person.name(),
    cpf: faker.randomGenerator.numberOfLength(11),
    mainAddress: AddressEntity(
      id: faker.guid.guid(),
      title: faker.lorem.word(),
      zipCode: faker.randomGenerator.numberOfLength(8),
      city: faker.lorem.sentence(),
      country: faker.lorem.word(),
      number: faker.randomGenerator.numberOfLength(3),
      state: faker.lorem.word(),
      street: faker.lorem.sentence(),
      additionalInfo: faker.lorem.sentence(),
    ),
  );
}
