import 'package:guia_click/models/user/isar_user.dart';
import 'package:guia_click/utilities/repository.dart';
import 'package:isar/isar.dart';

/// {@template LocalStorage}
/// Manages the local storage of the app
/// {@endtemplate}
class LocalStorage {
  /// Set the user data in the local storage
  static Future<void> setUser({required User user}) async {
    try {
      final isar = Isar.getInstance();

      await isar?.writeTxn(() async {
        await isar.isarUsers.put(IsarUser()..user = user);
      });
    } catch (e, st) {
      Repository.handleException(e, st);
    }
  }

  /// Get the user data from the local storage
  static Future<User?> getUser() async {
    try {
      final isar = Isar.getInstance();

      IsarUser? isarUser;

      isarUser = await isar?.isarUsers.get(1);

      final user = isarUser?.user;

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Clear the user data from the local storage
  static Future<void> clearUser() async {
    try {
      final isar = Isar.getInstance();

      await isar?.writeTxn(() async {
        await isar.isarUsers.clear();
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
