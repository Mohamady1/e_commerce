import 'package:e_commerce/controller/firebase/firebase_auth_helper.dart';
import 'package:e_commerce/controller/firebase/cloud_firebase_helper.dart';
import 'package:e_commerce/controller/profile/profile_controller.dart';
import 'package:e_commerce/view/widgets/build_editable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/controller/firebase/firestore_firebase_helper.dart';
import 'package:e_commerce/view/utils/colors.dart' as color;
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future userDataFuture;
  final ProfileController profileController = Get.put(ProfileController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    userDataFuture = FireStoreHelper.getUserData();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
      child: FutureBuilder(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: color.Colors.redColor));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map userData = snapshot.data!;

            nameController.text = userData['username'] ?? '';
            emailController.text = userData['email'] ?? '';
            weightController.text = userData['weight'] ?? '';
            heightController.text = userData['height'] ?? '';
            ageController.text = userData['age'] ?? '';

            return buildProfileUI(userData);
          }
        },
      ),
    );
  }

  Widget buildProfileUI(Map userData) {
    Future<String> getProfilePicUrl() async {
      return await CloudFirebaseHelper.getImageUrl(
          "users/" + FirebaseAuthHelper.firebaseAuth.currentUser!.uid);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              FirebaseAuthHelper.signOut();
              Get.offAllNamed("/login");
            },
            icon: Icon(Icons.exit_to_app)),
        Stack(children: [
          GetBuilder<ProfileController>(
            builder: (controller) {
              return Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: controller.image != null
                      ? Image.file(
                          controller.image!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : FutureBuilder<String>(
                          future: getProfilePicUrl(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(
                                color: color.Colors.redColor,
                              );
                            } else if (snapshot.hasError) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: Image.asset(
                                  "assets/images/placeholder.jpg",
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              );
                            } else {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: Image.network(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              );
                            }
                          },
                        ),
                ),
              );
            },
          ),
          Positioned(
              right: 0,
              top: -13,
              child: IconButton(
                  onPressed: () {
                    profileController.getImageFromGallery();
                  },
                  icon: Icon(Icons.add_a_photo)))
        ]),
        EditableTextField('Name', nameController),
        EditableTextField('Email', emailController),
        EditableTextField('Weight', weightController),
        EditableTextField('Height', heightController),
        EditableTextField('Age', ageController),

        // Save button
        Center(
          child: SizedBox(
            width: 250,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: color.Colors.redColor),
              onPressed: () {
                Map<String, dynamic> userDataUpdate = {
                  'username': nameController.text,
                  'email': emailController.text,
                  'weight': weightController.text,
                  'height': heightController.text,
                  'age': ageController.text,
                };
                FireStoreHelper.updateUserData(userDataUpdate)
                    .then((_) => Get.snackbar("Done", "Data Updated"));
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
