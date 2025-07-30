import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateService extends GetxService {
  Future<DateTime?> showDatetimePicker({DateTime? initialDate}) async {
    DateTime? result = await showBoardDateTimePickerForDateTime(
      context: Get.context!,
      initialDate: initialDate,
      options: BoardDateTimeOptions(
        languages: BoardPickerLanguages(
          locale: 'datetime.locale'.tr,
          today: 'datetime.locale.today'.tr,
          tomorrow: 'datetime.locale.tomorrow'.tr,
          yesterday: 'datetime.locale.yesterday'.tr,
          now: 'datetime.locale.now'.tr,
        ),
        startDayOfWeek: DateTime.monday,
      ),
      customCloseButtonBuilder: (context, f, onPressed) {
        return TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text('btn.save'.tr),
        );
      },
    );
    return result;
  }

  Future<DateTime?> showDatePicker({DateTime? initialDate}) async {
    DateTime? result = await showBoardDateTimePickerForDate(
      context: Get.context!,
      initialDate: initialDate,
      enableDrag: false,
      options: BoardDateTimeOptions(
        languages: BoardPickerLanguages(
          locale: 'datetime.locale'.tr,
          today: 'datetime.locale.today'.tr,
          tomorrow: 'datetime.locale.tomorrow'.tr,
          yesterday: 'datetime.locale.yesterday'.tr,
          now: 'datetime.locale.now'.tr,
        ),
        startDayOfWeek: DateTime.monday,
      ),
      customCloseButtonBuilder: (context, f, onPressed) {
        return TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text('btn.save'.tr),
        );
      },
    );
    return result;
  }

  Future<dynamic> showDatetimeRangePicker({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final result = await showBoardDateTimeMultiPicker(
      context: Get.context!,
      enableDrag: false,
      startDate: startDate,
      endDate: endDate,
      options: BoardDateTimeOptions(
        languages: BoardPickerLanguages(
          locale: 'datetime.locale'.tr,
          today: 'datetime.locale.today'.tr,
          tomorrow: 'datetime.locale.tomorrow'.tr,
          yesterday: 'datetime.locale.yesterday'.tr,
          now: 'datetime.locale.now'.tr,
        ),
        startDayOfWeek: DateTime.monday,
      ),
      customCloseButtonBuilder: (context, f, onPressed) {
        return TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text('btn.save'.tr),
        );
      },
      pickerType: DateTimePickerType.time,
    );
    return result;
  }
}
