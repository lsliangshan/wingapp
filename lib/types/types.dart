enum TabName {
  home,
  tclass,
  student,
  schedule,
  profile,
}

enum MemberActionType {
  // 创建多于 3 个礼簿
  createGiftRegister,
  // 导入通讯录
  importContacts,
  // 事件提醒
  eventReminder,
  // 共享记账
  sharedAccounting,
  // 导入导出所有礼簿
  importExportAllGiftRegister,
  // 详细的数据统计
  detailedDataStatistics,
}

enum MessageType {
  text,
  image,
  voice,
  video,
}

class TeacherType {
  static const fullTime = 'full-time';
  static const partTime = 'part-time';
}

class Gender {
  static const male = 'male';
  static const female = 'female';
}

class CustomPurchaseStatus {
  static const purchaseCanceled = 'PURCHASE_CANCELLED';
  static const purchaseFailed = 'purchase_failed';
}
