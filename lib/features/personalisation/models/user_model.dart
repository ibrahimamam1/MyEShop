import 'package:e_shop/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  //Helper Function to get Full name
  String get fullName => '$firstName $lastName';

  //Helper Function to get formated phone Number
  String get formattedPhoneNo => AppFormatter.formatPhoneNumber(phoneNumber);

  //static function to split full name into first and last name.
  static List<String> nameparts(fullName) => fullName.splt(" ");

  //static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : " ";

    String camelCaseUserName = "$firstName$lastName";
    String userNameWithPrefix = "cwt_$camelCaseUserName";
    return userNameWithPrefix;
  }

  ///static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  ///Convert Model to JSON Structure for storing data in firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  ///Factorymethod to create a UserModel from a Firebase document snapshot
  // factory UserModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   if (document.data != null) {
  //     final data = document.data()!;
  //     return UserModel(
  //         id: document.id,
  //         firstName: data['FirstName'] ?? '',
  //         lastName: data['LastName'] ?? '',
  //         userName: data['UserName'] ?? '',
  //         email: data['Email'] ?? '',
  //         phoneNumber: data['PhoneNumber'] ?? '',
  //         profilePicture: data['ProfilePicture'] ?? ''
  //         );
  //   }
  // }
}
