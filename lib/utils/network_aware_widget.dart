import 'package:flutter/material.dart';
import 'package:iris_app/utils/network_status_service.dart';
import 'package:provider/provider.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;

  const NetworkAwareWidget({Key? key, required this.onlineChild, required this.offlineChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetworkStatus networkStatus = Provider.of<NetworkStatus>(context);
    if (networkStatus == NetworkStatus.Online) {
      return onlineChild;
    } else {
      _showToastMessage("Offline");
      return offlineChild;
    }
  }

  void _showToastMessage(String message){
    print(message);
  }
}