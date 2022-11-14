import 'package:chatapp/repository/user_repository.dart';
import 'package:chatapp/services/firebase_auth_services.dart';
import 'package:chatapp/services/firebase_storage_services.dart';
import 'package:chatapp/services/firestore_db_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  locator.registerSingleton<FirestoreDbServices>(FirestoreDbServices());
  locator.registerSingleton<FirebaseStorageServices>(FirebaseStorageServices());
  locator.registerSingleton<UserRepository>(UserRepository());
}
