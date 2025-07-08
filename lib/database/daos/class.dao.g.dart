// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dao.dart';

// ignore_for_file: type=lint
mixin _$ClassDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClassesTable get classes => attachedDatabase.classes;
  Selectable<int> countAll() {
    return customSelect('SELECT COUNT(*) AS _c0 FROM classes',
        variables: [],
        readsFrom: {
          classes,
        }).map((QueryRow row) => row.read<int>('_c0'));
  }
}
