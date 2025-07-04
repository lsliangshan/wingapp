// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dao.dart';

// ignore_for_file: type=lint
mixin _$TeacherDaoMixin on DatabaseAccessor<AppDatabase> {
  $TeachersTable get teachers => attachedDatabase.teachers;
  Selectable<int> countAll() {
    return customSelect('SELECT COUNT(*) AS _c0 FROM teachers',
        variables: [],
        readsFrom: {
          teachers,
        }).map((QueryRow row) => row.read<int>('_c0'));
  }
}
