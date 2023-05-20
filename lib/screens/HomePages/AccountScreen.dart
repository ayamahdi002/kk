import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final referenceDatase = FirebaseDatabase.instance;
  final emailContoller = TextEditingController();
  File? _image;
  final ImagePicker _imagePicker = ImagePicker();
  String _email = 'ayamahdi@gmail.com';
  String _username = '';
  String _phoneNumber = '';

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _changeEmail() async {
    final newEmail = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedEmail = '';

        return AlertDialog(
          title: Text('Change Email'),
          content: TextField(
            controller: emailContoller,
            onChanged: (value) {
              updatedEmail = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter new email',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final ref = referenceDatase.reference();
                ref
                    .child('userprofile')
                    .child('email')
                    .set('emailContoller.text')
                    .asStream();
                emailContoller.clear();
                Navigator.of(context).pop(updatedEmail);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (newEmail != null && newEmail.isNotEmpty) {
      // Save the new email to Firebase Firestore
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'email': newEmail});
      }

      setState(() {
        _email = newEmail;
      });
    }
  }

  Future<void> _changeUsername() async {
    final newUsername = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedUsername = '';

        return AlertDialog(
          title: Text('Change Username'),
          content: TextField(
            onChanged: (value) {
              updatedUsername = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter new username',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(updatedUsername);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (newUsername != null && newUsername.isNotEmpty) {
      // Save the new username to Firebase Firestore
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'username': newUsername});
      }

      setState(() {
        _username = newUsername;
      });
    }
  }

  Future<void> _changePhoneNumber() async {
    final newPhoneNumber = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedPhoneNumber = '';

        return AlertDialog(
          title: Text('Change Phone Number'),
          content: TextField(
            onChanged: (value) {
              updatedPhoneNumber = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter new phone number',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(updatedPhoneNumber);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (newPhoneNumber != null && newPhoneNumber.isNotEmpty) {
      // Save the new phone number to Firebase Firestore
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'phoneNumber': newPhoneNumber});
      }

      setState(() {
        _phoneNumber = newPhoneNumber;
      });
    }
  }

  Future<void> _changePassword() async {
    final newPassword = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedPassword = '';

        return AlertDialog(
          title: Text('Change Password'),
          content: TextField(
            onChanged: (value) {
              updatedPassword = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter new password',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(updatedPassword);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (newPassword != null && newPassword.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          // Re-authenticate the user with their current password
          final credential = EmailAuthProvider.credential(
            email: user.email!,
            password:
                'current_password', // Replace with the user's current password
          );
          await user.reauthenticateWithCredential(credential);

          // Update the password
          await user.updatePassword(newPassword);
        } catch (error) {
          // Handle re-authentication or password update errors
          print('Password update error: $error');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve user data from Firebase Firestore
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data();
          setState(() {
            _email = data!['email'] ?? '0';
            _username = data['username'] ?? '0';
            _phoneNumber = data['phoneNumber'] ?? '0';
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatase.reference();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 233, 241),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  'https://img.freepik.com/premium-vector/vector-cute-cat-paw-logo-icon-pet-shop-zoo-print-children-textile-grooming-salon-animal-paw_615232-899.jpg?w=740',
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: AppColors.primaryColor,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 110,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Take a photo'),
                                      onTap: () {
                                        _getImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text('Choose from gallery'),
                                      onTap: () {
                                        _getImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomCard(
                  title: 'Email',
                  content: _email,
                  onTap: () {
                    _changeEmail();
                  },
                ),
                CustomCard(
                  title: 'Username',
                  content: _username,
                  onTap: () {
                    _changeUsername();
                  },
                ),
                CustomCard(
                  title: 'Phone Number',
                  content: _phoneNumber,
                  onTap: () {
                    _changePhoneNumber();
                  },
                ),
                CustomCard(
                  title: 'Password',
                  content: '********', // Display masked password
                  onTap: () {
                    _changePassword();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('signupScreen');
                    // Implement logout logic here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(130, 3, 130, 3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onTap;

  const CustomCard({
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Text(content),
      ),
    );
  }
}

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 114, 168, 212);
}
