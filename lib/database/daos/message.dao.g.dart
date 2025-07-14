// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dao.dart';

// ignore_for_file: type=lint
mixin _$MessageDaoMixin on DatabaseAccessor<AppDatabase> {
  $MessagesTable get messages => attachedDatabase.messages;
  Selectable<int> countAll() {
    return customSelect('SELECT COUNT(*) AS _c0 FROM messages',
        variables: [],
        readsFrom: {
          messages,
        }).map((QueryRow row) => row.read<int>('_c0'));
  }
}
