import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _introductionController;
  late TextEditingController _aboutController;
  late TextEditingController _streetController;
  late TextEditingController _localityController;
  late TextEditingController _regionController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;

  final userCtrl = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final user = userCtrl.user.value;
    final auth = Get.find<AuthController>();

    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _phoneController = TextEditingController(
      text: (user?.phoneNumber?.isNotEmpty == true)
          ? user!.phoneNumber!
          : (auth.phoneNumber ?? ''),
    );
    _introductionController = TextEditingController(text: user?.introduction ?? '');
    _aboutController = TextEditingController(text: user?.about ?? '');
    _streetController = TextEditingController(text: user?.address?.street ?? '');
    _localityController = TextEditingController(text: user?.address?.locality ?? '');
    _regionController = TextEditingController(text: user?.address?.region ?? '');
    _postalCodeController = TextEditingController(text: user?.address?.postalCode ?? '');
    _countryController = TextEditingController(text: user?.address?.country ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _introductionController.dispose();
    _aboutController.dispose();
    _streetController.dispose();
    _localityController.dispose();
    _regionController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  InputDecoration _field(String label, {String? hint, int? maxLength}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      counterText: maxLength != null ? null : '',
      floatingLabelStyle: const TextStyle(color: AppColors.mossGreen, fontWeight: FontWeight.w600),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = S.of(context);

    setState(() => _isSaving = true);

    try {
      final user = userCtrl.user.value;

      if (_firstNameController.text != (user?.firstName ?? '')) {
        await userCtrl.updateFirstName(_firstNameController.text);
      }
      if (_lastNameController.text != (user?.lastName ?? '')) {
        await userCtrl.updateLastName(_lastNameController.text);
      }
      if (_phoneController.text != (user?.phoneNumber ?? '')) {
        await userCtrl.updatePhoneNumber(_phoneController.text);
      }
      if (_introductionController.text != (user?.introduction ?? '')) {
        await userCtrl.updateIntroduction(_introductionController.text);
      }
      if (_aboutController.text != (user?.about ?? '')) {
        await userCtrl.updateAbout(_aboutController.text);
      }

      final street = _streetController.text.trim();
      final locality = _localityController.text.trim();
      final postalCode = _postalCodeController.text.trim();
      final country = _countryController.text.trim();
      final region = _regionController.text.trim();

      final hasRequiredAddress = street.isNotEmpty && locality.isNotEmpty &&
          postalCode.isNotEmpty && country.isNotEmpty;

      final existingAddress = user?.address;
      final addressChanged = street != (existingAddress?.street ?? '') ||
          locality != (existingAddress?.locality ?? '') ||
          postalCode != (existingAddress?.postalCode ?? '') ||
          country != (existingAddress?.country ?? '') ||
          region != (existingAddress?.region ?? '');

      if (hasRequiredAddress && addressChanged) {
        await userCtrl.upsertAddress(
          street: street,
          locality: locality,
          postalCode: postalCode,
          country: country,
          region: region.isEmpty ? null : region,
        );
      }

      await userCtrl.refresh();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileUpdateSuccess)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        final l10n = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.profileUpdateError(e.toString())),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileEditTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: SectionHeader(label: l10n.profileEditSectionName),
              ),
              _FieldGroup(
                colorScheme: colorScheme,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: _field(l10n.profileEditFirstName),
                    textCapitalization: TextCapitalization.words,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? l10n.profileEditFirstNameRequired : null,
                  ),
                  _divider(colorScheme),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: _field(l10n.profileEditLastName),
                    textCapitalization: TextCapitalization.words,
                  ),
                ],
              ),
              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: SectionHeader(label: l10n.profileEditSectionContact),
              ),
              _FieldGroup(
                colorScheme: colorScheme,
                children: [
                  TextFormField(
                    controller: _phoneController,
                    decoration: _field(l10n.profileEditPhone),
                    keyboardType: TextInputType.phone,
                    autofillHints: const [AutofillHints.telephoneNumber],
                  ),
                ],
              ),
              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: SectionHeader(label: l10n.profileEditSectionAddress),
              ),
              _FieldGroup(
                colorScheme: colorScheme,
                children: [
                  TextFormField(
                    controller: _streetController,
                    decoration: _field(l10n.profileEditStreet),
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.streetAddressLine1],
                  ),
                  _divider(colorScheme),
                  TextFormField(
                    controller: _localityController,
                    decoration: _field(l10n.profileEditCity),
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.addressCity],
                  ),
                  _divider(colorScheme),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _regionController,
                          decoration: _field(l10n.profileEditRegion),
                          textCapitalization: TextCapitalization.words,
                          autofillHints: const [AutofillHints.addressState],
                        ),
                      ),
                      Container(width: 1, height: 48, color: colorScheme.outlineVariant),
                      Expanded(
                        child: TextFormField(
                          controller: _postalCodeController,
                          decoration: _field(l10n.profileEditPostalCode),
                          keyboardType: TextInputType.number,
                          autofillHints: const [AutofillHints.postalCode],
                        ),
                      ),
                    ],
                  ),
                  _divider(colorScheme),
                  TextFormField(
                    controller: _countryController,
                    decoration: _field(l10n.profileEditCountry),
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.countryName],
                  ),
                ],
              ),
              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: SectionHeader(label: l10n.profileEditSectionBio),
              ),
              _FieldGroup(
                colorScheme: colorScheme,
                children: [
                  TextFormField(
                    controller: _introductionController,
                    decoration: _field(l10n.profileEditIntroduction,
                        hint: l10n.profileEditIntroductionHint),
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  _divider(colorScheme),
                  TextFormField(
                    controller: _aboutController,
                    decoration: _field(l10n.profileEditAbout,
                        hint: l10n.profileEditAboutHint,
                        maxLength: 500),
                    maxLines: 4,
                    maxLength: 500,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveProfile,
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(l10n.profileEditSaveButton),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider(ColorScheme cs) =>
      Divider(height: 1, indent: 16, color: cs.outlineVariant.withValues(alpha: 0.6));
}

class _FieldGroup extends StatelessWidget {
  final ColorScheme colorScheme;
  final List<Widget> children;

  const _FieldGroup({required this.colorScheme, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
