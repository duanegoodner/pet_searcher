import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/models/user_favorites.dart';
import 'package:pet_matcher/screens/animal_detail_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = 'favoriteScreen';

  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userType = Provider.of<AppUser>(context).role;
    return StreamProvider<UserFavorites>(
      create: (_) => locator<AppUserService>().favoritesOnDataChange(),
      initialData: UserFavorites.initial(),
      catchError: (_, __) => UserFavorites.initial(),
      child: Scaffold(
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
    List<Animal> allAnimals = Provider.of<List<Animal>>(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Consumer<UserFavorites>(
          builder: (context, userFavorites, __) {
            List<dynamic> favAnimalIDs = userFavorites.favorites;
            List<Animal> favAnimals = allAnimals
                ?.where((animal) =>
                    favAnimalIDs.contains(animal.animalID.toString()))
                ?.toList();
            if (favAnimals == null) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(
              itemCount: favAnimals.length,
              itemBuilder: (context, index) {
                Animal favAnimal = favAnimals[index];
                return inventoryListTile(context, favAnimal);
              },
            );
          },
        ),
      ),
    );
  }

  Widget inventoryListTile(BuildContext context, Animal favAnimal) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AnimalDetailScreen.routename, arguments: favAnimal);
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

  Widget animalPhotoTile(Animal animal, BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AspectRatio(
          aspectRatio: 1.1,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl: animal.imageURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        //animalInventoryLayout(userType, animal, context),
      ],
    );
  }

  Widget animalInfoText(Animal animal) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${animal.name}',
              style: Styles.titleTextBlack,
            ),
            Text(
              'Breed: ${animal.breed}',
              style: Styles.detailTextBlack,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Age: ${animal.breed}',
              style: Styles.detailTextBlack,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Arrived: ${animal.formattedDateAdded}',
              style: Styles.inventoryDateText,
            ),
          ],
        ),
      ),
    );
  }
}
