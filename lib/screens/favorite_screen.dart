import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/animal_filter.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/models/user_favorites.dart';
import 'package:pet_matcher/screens/add_pet_screen.dart';
import 'package:pet_matcher/screens/animal_detail_screen.dart';
import 'package:pet_matcher/screens/choose_animal_type_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/animal_search_button.dart';
import 'package:pet_matcher/widgets/animal_sort_button.dart';
import 'package:pet_matcher/widgets/delete_dialog.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = 'favoriteScreen';

  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userType = Provider
        .of<AppUser>(context)
        .role;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Matches!'),
        backgroundColor: Styles.appBarColor,
      ),
      drawer: getDrawerType(userType),
      backgroundColor: Styles.backgroundColor,
      body: Column(
        children: [
          animalList(context, userType),
        ],
      ),
    );
  }

  //function returning user or admin drawer
  Widget getDrawerType(userType) {
    if (userType == 'admin') {
      return AdminDrawer();
    } else {
      return UserDrawer();
    }
  }

  Widget animalList(BuildContext context, String userType) {
    // List<Animal> allAnimals = Provider.of<List<Animal>>(context)
   /*List animals = Provider
        .of<AppUser>(context)
        .favorites;*/
    AppUser user = Provider.of<AppUser>(context);
    Animal animal = Animal();

    if (user == null) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Expanded(
      child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListView.builder(
                itemCount: user.favorites.length,
                itemBuilder: (context, index) {
                  animal.animalID = user.favorites[index];
                  var favAnimal = FirebaseFirestore.instance
                    .collection('animals')
                    .doc('${animal.animalID}')
                    .get();
                  return inventoryListTile(context, favAnimal);
                },
              ),
            ),
      );
  }

  Widget inventoryListTile(BuildContext context, favAnimal) {
    return GestureDetector(
      onTap: () {
       /*Navigator.of(context)
            .pushNamed(AnimalDetailScreen.routename, arguments: animal);*/
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: EdgeInsets.only(bottom: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              animalPhotoTile(favAnimal, context),
              animalInfoText(favAnimal),
            ],
          ),
        ),
      ),
    );
  }

  Widget animalPhotoTile(animal, BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AspectRatio(
          aspectRatio: 1.1,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl: animal['imageURL'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        //animalInventoryLayout(userType, animal, context),
      ],
    );
  }

  Widget animalInfoText(animal) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${animal['name']}',
              style: Styles.titleTextBlack,
            ),
            Text(
              'Breed: ${animal['breed']}',
              style: Styles.detailTextBlack,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Age: ${animal['breed']}',
              style: Styles.detailTextBlack,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Arrived: ${animal['formattedDateAdded']}',
              style: Styles.inventoryDateText,
            ),
          ],
        ),
      ),
    );
  }

}