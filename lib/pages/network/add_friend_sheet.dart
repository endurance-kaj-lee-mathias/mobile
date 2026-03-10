import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendSheet extends StatefulWidget {
  final NetworkController controller;

  const AddFriendSheet({super.key, required this.controller});

  @override
  State<AddFriendSheet> createState() => _AddFriendSheetState();
}

class _AddFriendSheetState extends State<AddFriendSheet> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.networkAddToNetwork,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: l10n.networkUsernameLabel,
                hintText: l10n.networkUsernameHint,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12),
                  child: HeroIcon(HeroIcons.atSymbol, size: 20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              textInputAction: TextInputAction.next,
              autocorrect: false,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return l10n.networkUsernameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: l10n.networkNoteOptional,
                hintText: l10n.networkNoteHint,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12),
                  child: HeroIcon(HeroIcons.chatBubbleLeft, size: 20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLength: 300,
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
            Obx(() {
              final err = widget.controller.sendError.value;
              if (err == null) return const SizedBox.shrink();
              final msg = switch (err) {
                NetworkInviteError.userNotFound =>
                  l10n.networkErrorUserNotFound,
                NetworkInviteError.alreadyConnected =>
                  l10n.networkErrorAlreadyConnected,
                NetworkInviteError.cannotSend => l10n.networkErrorCannotSend,
                NetworkInviteError.generic => l10n.networkErrorGeneric,
              };
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  msg,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 13,
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Obx(
              () => ElevatedButton(
                onPressed:
                    widget.controller.isSending.value
                        ? null
                        : () => _submit(context),
                child:
                    widget.controller.isSending.value
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Text(l10n.networkSendRequest),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = S.of(context);
    final username = _usernameController.text.trim();
    final note = _noteController.text.trim();
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final success = await widget.controller.sendInvite(
      username,
      note: note.isEmpty ? null : note,
    );

    if (success) {
      nav.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.networkRequestSentSuccess(username)),
          backgroundColor: AppColors.mossGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
