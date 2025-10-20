import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

import 'package:flutter_starter_todo_app/features/todo/data/model/todo_model.dart';

Future<Isar> setupIsar() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  Isar? isar;
  final dataDir = File('test/_dummy_data/data');

  if (Isar.instanceNames.isEmpty || !isar!.isOpen) {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([TodoModelSchema], directory: dataDir.path);
    return isar;
  } else {
    return Future.value(isar);
  }
}
