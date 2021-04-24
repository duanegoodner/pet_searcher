import 'package:flutter/material.dart';
import 'package:pet_matcher/screens/add_pet_screen.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';

class ChooseAnimalTypeScreen extends StatefulWidget {
  static const routeName = 'chooseAnimalTypeScreen';

  @override
  _ChooseAnimalTypeScreenState createState() => _ChooseAnimalTypeScreenState();
}

class _ChooseAnimalTypeScreenState extends State<ChooseAnimalTypeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add a New Animal'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: AdminDrawer(),
      backgroundColor: Colors.blue[300],
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          addAnimalListTile(context, 'assets/images/dog_landscape.jpg', 'Dog'),
          addAnimalListTile(context, 'assets/images/cat_landscape.jpg', 'Cat'),
          addAnimalListTile(
              context, 'assets/images/guinea_pig_landscape.jpg', 'Pet'),
        ],
      ),
    );
  }

  Widget addAnimalListTile(BuildContext context, String imageURL, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AddPetScreen.routeName, arguments: text);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.asset(imageURL),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Add New $text',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
