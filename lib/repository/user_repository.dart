import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:capstonedesign/model/user.dart';

class UserRepository {
  final UserDataSource userDataSource;

  UserRepository({required this.userDataSource});

  Future<void> signUp(User user) {
    return userDataSource.signUp(user);
  }
}
