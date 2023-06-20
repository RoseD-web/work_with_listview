import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'empty_view.dart';

void main() => runApp(MyApp());

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

class UsersProvider with ChangeNotifier {
  List<User> users = [];

  void generateUsers() {
    final faker = Faker();
    final genders = ['Male', 'Female'];
    for (int i = 0; i < 30; i++) {
      final user = User(
        firstName: faker.person.firstName(),
        lastName: faker.person.lastName(),
        age: faker.randomGenerator.integer(99),
        sex: faker.randomGenerator.element(genders),
        squareAvatarUrl:
            'https://image.cnbcfm.com/api/v1/image/105773423-1551716977818rtx6p9yw.jpg?v=1551717428&w=700&h=700',
        description:
            faker.lorem.sentences(faker.randomGenerator.integer(3, min: 1)),
      );
      users.add(user);
    }
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsersProvider(),
      child: MaterialApp(
        title: 'User App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    UsersScreen(),
    FavoritesScreen(),
    SettingsScreen(),
    InfoScreen(),
    NewScreen(), // Новый экран
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work with ListView'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apple),
            label: 'Apples',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_label), // Иконка для нового пункта
            label: 'New', // Название для нового пункта
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final users = usersProvider.users;
    usersProvider.generateUsers();

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        IconData genderIcon;
        Color genderIconColor;
        if (user.sex == 'Male') {
          genderIcon = Icons.male;
          genderIconColor = Colors.blue;
        } else {
          genderIcon = Icons.female;
          genderIconColor = Colors.pink;
        }
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.squareAvatarUrl),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Age: ${user.age}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          trailing: Icon(
            genderIcon,
            color: genderIconColor,
          ),
          onTap: () {},
        );
      },
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final users = usersProvider.users;
    usersProvider.generateUsers();

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        IconData genderIcon;
        Color genderIconColor;
        if (user.sex == 'Male') {
          genderIcon = Icons.male;
          genderIconColor = Colors.blue;
        } else {
          genderIcon = Icons.female;
          genderIconColor = Colors.pink;
        }

        return ListTile(
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: NetworkImage(user.squareAvatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Age: ${user.age}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                ' ${user.description.join(" ")}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          trailing: Icon(
            genderIcon,
            color: genderIconColor,
          ),
          onTap: () {},
        );
      },
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final List<String> texts = [
    'Text 1',
    'Text 2',
    'Text 3',
    'Text 4',
    'Text 5',
    'Text 6',
  ];

  final List<Color> colors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        final text = texts[index % texts.length];
        final color = colors[index % colors.length];

        return Container(
          margin: EdgeInsets.all(16.0),
          height: 100.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.apple_sharp,
                size: 90.0,
              ),
              SizedBox(width: 16.0),
              Text(
                text,
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 0, 0, 0),
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(0, index == 0 ? 16 : 0, 16, 0),
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
          ],
        );
      },
    );
  }
}

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Simulate a delay of 6 seconds
    await Future.delayed(Duration(seconds: 6));

    setState(() {
      isLoading = false;
    });
  }

  void clearUsers(UsersProvider usersProvider) {
    usersProvider.users.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final users = usersProvider.users;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Очистить список'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => clearUsers(usersProvider),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: users.isEmpty
            ? EmptyView()
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  IconData genderIcon;
                  Color genderIconColor;
                  if (user.sex == 'Male') {
                    genderIcon = Icons.male;
                    genderIconColor = Colors.blue;
                  } else {
                    genderIcon = Icons.female;
                    genderIconColor = Colors.pink;
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.squareAvatarUrl),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Age: ${user.age}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      genderIcon,
                      color: genderIconColor,
                    ),
                    onTap: () {},
                  );
                },
              ),
      ),
    );
  }
}
