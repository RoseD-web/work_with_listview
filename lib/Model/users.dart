import 'package:faker/faker.dart';

class User {
  String firstName;
  String lastName;
  int age;
  String sex;
  String squareAvatarUrl;
  List<String> description;

  User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.sex,
    required this.squareAvatarUrl,
    required this.description,
  });
}

void main() {
  Faker faker = Faker();
  List<User> users = [];

  for (int i = 0; i < 30; i++) {
    User user = User(
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      age: faker.randomGenerator.integer(100),
      sex: faker.randomGenerator.element(['Male', 'Female']),
      squareAvatarUrl:
          'https://image.cnbcfm.com/api/v1/image/105773423-1551716977818rtx6p9yw.jpg?v=1551717428&w=700&h=700',
      description:
          faker.lorem.sentences(faker.randomGenerator.integer(1, min: 5)),
    );

    users.add(user);
  }

  // Выводим информацию о пользователях
  for (User user in users) {
    print('Name: ${user.firstName} ${user.lastName}');
    print('Age: ${user.age}');
    print('Sex: ${user.sex}');
    print('Avatar URL: ${user.squareAvatarUrl}');
    print('Description:');
    for (String line in user.description) {
      print(line);
    }
    print('---');
  }
}
