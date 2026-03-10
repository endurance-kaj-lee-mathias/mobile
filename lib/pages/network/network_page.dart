import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/network/add_friend_sheet.dart';
import 'package:endurance_mobile_app/pages/network/connections_tab.dart';
import 'package:endurance_mobile_app/pages/network/requests_tab.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  late final NetworkController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<NetworkController>();
    _controller.enterNetworkTab();
  }

  @override
  void dispose() {
    _controller.leaveNetworkTab();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.networkTitle),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add_outlined),
              tooltip: l10n.networkAddToNetwork,
              onPressed: () => _showAddFriendSheet(context),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.networkConnections),
              Obx(() {
                final count = _controller.incoming.length;
                if (count > 0) {
                  return Tab(
                    child: Badge(
                      label: Text('$count'),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: Text(l10n.networkRequests),
                      ),
                    ),
                  );
                }
                return Tab(text: l10n.networkRequests);
              }),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ConnectionsTab(
              controller: _controller,
              onAddPressed: () => _showAddFriendSheet(context),
            ),
            RequestsTab(controller: _controller),
          ],
        ),
      ),
    );
  }

  void _showAddFriendSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddFriendSheet(controller: _controller),
    );
  }
}
