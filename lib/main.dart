import 'package:flutter/material.dart';
import 'package:guia_click/models/user/isar_user.dart';
import 'package:guia_click/src/app.dart';
import 'package:guia_click/src/settings/settings_controller.dart';
import 'package:guia_click/src/settings/settings_service.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getExternalStorageDirectory();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();
  await Isar.open(
    [
      IsarUserSchema,
    ],
    directory: dir?.path ?? '',
  );
  runApp(MyApp(settingsController: settingsController));
}
