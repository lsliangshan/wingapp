enum TabName {
  gift,
  events,
  contact,
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

class CustomPurchaseStatus {
  static const purchaseCanceled = 'PURCHASE_CANCELLED';
  static const purchaseFailed = 'purchase_failed';
}
