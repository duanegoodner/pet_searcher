import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/locator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/models/user_favorites.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/models/user_favorites.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';
import 'package:pet_matcher/widgets/contact_form.dart';

import '../styles.dart';
import 'add_pet_screen.dart';

class AnimalDetailScreen extends StatefulWidget {
  static const routename = 'animal_detail_screen';

  @override
  _AnimalDetailScreenState createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Animal receivedAnimal = ModalRoute.of(context).settings.arguments;
    String userType = Provider.of<AppUser>(context).role;
    //List userFavorites = Provider.of<AppUser>(context).favorites;
    return StreamProvider<UserFavorites>(
      create: (_) => locator<AppUserService>().favoritesOnDataChange(),
      initialData: UserFavorites.initial(),
      catchError: (_, __) => UserFavorites.initial(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Meet ${receivedAnimal.name}!'),
          backgroundColor: Styles.appBarColor,
        ),
        backgroundColor: Styles.backgroundColor,
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              displayImage(context, receivedAnimal, userType),
              headingText('${receivedAnimal.name}\'s Ideal Match:'),
              datingBlerb(receivedAnimal),
              headingText('The Lowdown:'),
              detailsBox(receivedAnimal),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: submitButton(context, receivedAnimal),
              )
            ],
          )),
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

  Widget displayImage(BuildContext context, Animal animal, userType) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Card(
          color: Colors.white,
          elevation: 20,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Stack(children: <Widget>[
              Card(
                  child: Wrap(children: <Widget>[
                CachedNetworkImage(
                  imageUrl: animal.imageURL,
                  height: 300,
                  width: 350,
                  fit: BoxFit.cover,
                )
              ])),
              Positioned(
                top: 0,
                right: 0,
                child: userType == 'admin'
                    ? editIcon(animal)
                    : favoriteIcon(context, animal),
              ),
            ]),
            temperamentRow(animal),
          ]),
        ),
      ),
    );
  }

  Widget favoriteIcon(BuildContext context, Animal animal) {
    return Consumer<UserFavorites>(
      builder: (context, userFavorites, __) {
        return IconButton(
            icon: Icon(Icons.favorite),
            color: userFavorites.favorites.contains(animal.animalID)
                ? Colors.red
                : Colors.white,
            onPressed: () {
              locator<AppUserService>().updateFavorites(
                  animal, Provider.of<UserFavorites>(context, listen: false));
            });
      },
    );
  }

  Widget editIcon(Animal animal) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context)
            .pushNamed(AddPetScreen.routeName, arguments: animal);
      },
    );
  }

  Widget temperamentRow(Animal animal) {
    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: animal.disposition.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: setIcon(animal.disposition[index]),
                title: Align(
                  alignment: Alignment(-1.25, 0),
                  child: Text('${animal.disposition[index]}',
                      style: Styles.detailTextBlack),
                ),
              );
            }));
  }

  Widget datingBlerb(Animal animal) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        child: Text(
            '${animal.name} is looking for an active family to conquer the world with.',
            textAlign: TextAlign.center,
            style: Styles.animalDetailDatingBlurbText),
      ),
    );
  }

  Widget setIcon(String disposition) {
    List<String> happyDispositions = [
      'Good with children',
      'Good with other animals',
    ];

    List<String> warningDispositions = [
      'Animal must be leashed at all times',
    ];

    if (happyDispositions.contains(disposition)) {
      return Icon(Icons.sentiment_very_satisfied,
          color: Colors.green, size: 18);
    } else if (warningDispositions.contains(disposition)) {
      return Icon(Icons.warning, color: Colors.yellow, size: 18);
    } else
      return Icon(Icons.sentiment_neutral, color: Colors.white, size: 18);
  }

  Widget detailsBox(Animal animal) {
    return Container(
      width: 375,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: <Widget>[
        displayRow1(animal),
        displayRow2(animal),
      ]),
    );
  }

  Widget displayRow1(Animal animal) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(children: <Widget>[
              Icon(Icons.info_outlined, color: Colors.white),
              Text('${animal.type}', style: Styles.standardTextWhite),
            ]),
            Column(children: <Widget>[
              FaIcon(FontAwesomeIcons.paw, color: Colors.white),
              Text(
                '${animal.breed}',
                style: Styles.standardTextWhite,
              ),
            ]),
            Column(children: <Widget>[
              FaIcon(FontAwesomeIcons.venusMars, color: Colors.white),
              Text(
                '${animal.gender}',
                style: Styles.standardTextWhite,
              ),
            ]),
          ]),
    );
  }

  Widget displayRow2(Animal animal) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(children: <Widget>[
              Icon(Icons.calendar_today, color: Colors.white),
              Text('${animal.age}', style: Styles.standardTextWhite),
            ]),
            Column(children: <Widget>[
              Icon(Icons.home_rounded, color: Colors.white),
              Text('${animal.status}', style: Styles.standardTextWhite),
            ]),
          ]),
    );
  }

  Widget headingText(String heading) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Text(
        '$heading',
        style: Styles.animalDetailHeadingText,
      ),
    );
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  Widget submitButton(BuildContext context, Animal animal) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => ContactForm(animal: animal),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
        child: Text('Meet Me!'),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        onPrimary: Colors.white,
        textStyle: Styles.elevatedButtonText,
        shadowColor: Colors.black,
        elevation: 8,
      ),
    );
  }
}
