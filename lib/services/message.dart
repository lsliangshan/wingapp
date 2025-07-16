import 'dart:async';
import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:eventflux/client.dart';
import 'package:eventflux/enum.dart';
import 'package:eventflux/models/reconnect.dart';
import 'package:eventflux/models/response.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:get/get.dart';
import 'package:wingapp/database/daos/message.dao.dart';

import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';

class MessageService extends GetxService {
  EventBus eventBus = Get.find<EventBus>();
  MessageDao messageDao = Get.find<MessageDao>();

  RxMap<String, Function(Message)> messageEventCallbacks =
      <String, Function(Message)>{}.obs;

  StreamSubscription? subscription;

  int maxRetries = 3;
  int attempt = 0;
  Duration delay = const Duration(seconds: 1);

  @override
  void onClose() {
    super.onClose();
    subscription?.cancel();
  }

  Future<NormalResponse> getMessages({
    required String classId,
    int? pageIndex = 1,
    int? pageSize = 20,
  }) async {
    return await messageDao.getMessages(
      classId: classId,
      pageIndex: pageIndex,
      pageSize: pageSize,
    );
  }

  void connect({
    required String url,
    required Map<String, String> headers,
    SSERequestType method = SSERequestType.GET,
    Map<String, dynamic>? body,
    required void Function(SSEModel) onEvent,
  }) {
    attempt++;
    subscription = SSEClient.subscribeToSSE(
      method: method,
      url: url,
      header: headers,
      body: body,
    ).listen(onEvent, onError: (e, st) async {
      if (attempt >= maxRetries) {
        print('>>>>> 超过重连次数: ${maxRetries}');
        await subscription?.cancel();
        SSEClient.unsubscribeFromSSE();
      } else {
        await Future.delayed(delay);
        connect(
          // 递归重连
          url: url,
          headers: headers,
          method: method,
          body: body,
          onEvent: onEvent,
        );
      }
    });
  }

  Future<void> sendMessage({
    required String id,
    required String classId,
    required String content,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    String? type,
    bool? isRobot,
    String? from,
  }) async {
    await messageDao.createMessage(
      id: id,
      classId: classId,
      content: content,
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar,
      type: type,
      isRobot: isRobot,
      from: from,
    );
  }

  Future<void> initMessageService() async {
    EventFlux.instance.connect(
      EventFluxConnectionType.get,
      'http://frp.liangqy.com/on/all/wing/robot/message',
      files: [
        /// Optional, If you want to send multipart files with the request
      ],
      multipartRequest:
          true, // Optional, By default, it will be considered as normal request, but if the files are provided or this flag is true, it will be considered as multipart request
      onSuccessCallback: (EventFluxResponse? response) {
        response?.stream?.listen((data) {
          // Your data is now in the spotlight!
          print('>>>>> 收到数据: ${data}');
        });
      },
      onError: (oops) {
        // Oops! Time to handle those little hiccups.
        // You can also choose to disconnect here
        print('>>>>> 错误: ${oops}');
      },
      autoReconnect: true,
      reconnectConfig: ReconnectConfig(
          mode: ReconnectMode.linear, // or exponential,
          interval: Duration(seconds: 5),
          // reconnectHeader: () async {
          //   /// If you want to send custom headers during reconnect which are different from the initial connection
          //   /// If you don't want to send any headers, you can skip this, initial headers will be used

          //   // Your async code to refresh or fetch headers
          //   // For example, fetching a new access token:
          //   String newAccessToken = await fetchNewAccessToken();
          //   return {
          //     'Authorization': 'Bearer $newAccessToken',
          //     'Accept': 'text/event-stream',
          //   };
          // },
          maxAttempts: 5, // or -1 for infinite,
          onReconnect: () {
            print('>>>>> 重连成功');
            // Things to execute when reconnect happens
            // FYI: for network changes, the `onReconnect` will not be called.
            // It will only be called when the connection is interupted by the server and eventflux is trying to reconnect.
          }),
    );
    // connect(
    //   url: 'http://frp.liangqy.com/on/all/wing/robot/message',
    //   headers: {
    //     'Accept': 'text/event-stream',
    //     "Cache-Control": "no-cache",
    //   },
    //   onEvent: (event) {
    //     if (event.data != null && event.data!.isNotEmpty) {
    //       Message data = Message.fromJson(jsonDecode(event.data!));
    //       messageEventCallbacks[data.classId]?.call(data);
    //       sendMessage(
    //         id: data.id,
    //         classId: data.classId,
    //         content: data.content,
    //         senderId: data.senderId,
    //         senderName: data.senderName,
    //         senderAvatar: data.senderAvatar,
    //         type: data.type,
    //         isRobot: data.isRobot,
    //         from: data.from,
    //       );
    //     }
    //   },
    // );
  }

  onMessageEvent({
    required String classId,
    required Function(Message) callback,
  }) {
    messageEventCallbacks[classId] = callback;
  }

  offMessageEvent({
    required String classId,
  }) {
    messageEventCallbacks.remove(classId);
  }
}
