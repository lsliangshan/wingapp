import 'package:dingtalk_auth/dingtalk_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/discovery_controller.dart';

class DiscoveryView extends GetView<DiscoveryController> {
  const DiscoveryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DiscoveryView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            const params = DingTalkAuthParam(
              appId: 'dingkbjfwewqmbaiz9uj',
              redirectUrl: 'http://192.168.1.11:5173/login',
            );
            final authCode = await DingtalkAuth.auth(params);
            print('>>>>>>>> authCode: $authCode');
          },
          child: Text('登录'),
        ),
      ),
    );
  }
}
