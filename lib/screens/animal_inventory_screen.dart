import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/screens/animal_detail_screen.dart';

class AnimalInventoryScreen extends StatelessWidget {
  static const routeName = 'animalInventoryScreen';
  const AnimalInventoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Animal Inventory'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: AdminDrawer(),
      backgroundColor: Colors.blue[300],
      body: buildInventoryList(context),
    );
  }
}

Widget buildInventoryList(BuildContext context) {
  return FutureBuilder(
    future: locator<AnimalService>().getAllAnimals(),
    builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data.length != 0) {
        return animalList(snapshot, context);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Column animalList(AsyncSnapshot<List<Animal>> animals, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: animals.data.length,
          itemBuilder: (context, index) {
            Animal animal = animals.data[index];
            return inventoryListTile(context, animal);
          },
        ),
      )
    ],
  );
}

Widget inventoryListTile(BuildContext context, Animal animal) {
  return GestureDetector(
    onTap: () {
     Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnimalDetailScreen(animal: animal)),
      );
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
                  child: CachedNetworkImage(
                    imageUrl: animal.imageURL,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${animal.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Breed: ${animal.breed}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Age: ${animal.age}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ],
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

Widget noAnimalsFoundTile() {
  return GestureDetector(
    onTap: () {},
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
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Sorry. No animals found.',
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
