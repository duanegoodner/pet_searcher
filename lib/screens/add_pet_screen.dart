import 'package:flutter/material.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';

class AddPetScreen extends StatefulWidget {
  static const routeName = 'addPetScreen';

  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final formKey = GlobalKey<FormState>();
  //final animalData = AnimalDTO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Animal'),
        backgroundColor: Colors.blue[300],
      ),
      backgroundColor: Colors.blue[300],
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              logo(),
              animalNameField(context),
              dispositionField(context),
              addAnimalButton(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Image.asset('assets/images/paw_logo.png',
        height: 250, width: 200, fit: BoxFit.fitWidth);
    //IDEA: wrap the image in a gestureDetector for selecting animal
    //image and then display in place of the image logo
  }

  Widget animalNameField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Animal Name',
        validatorPrompt: 'Enter animal name.',
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          //
        });
  }

  Widget dispositionField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Disposition',
        validatorPrompt: 'Enter animal disposition.',
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          //
        });
  }

  Widget addAnimalButton(BuildContext context) {
    return addPadding(elevatedButtonStandard('Add animal', createAnimal));
  }

  void createAnimal() async {
    //save form
    //add animal to database
    //go to next screen
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
  
}
