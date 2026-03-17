import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/agenda/add_slot_sheet.dart';
import 'package:endurance_mobile_app/pages/agenda/appointments_tab.dart';
import 'package:endurance_mobile_app/pages/agenda/availability_tab.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller = Get.find<CalendarController>();
    _controller.loadAppointments();
    _controller.loadMySlots();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.agendaTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const HeroIcon(HeroIcons.calendarDays),
            tooltip: l10n.agendaExportCalendar,
            onPressed: () => _exportCalendar(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.agendaTabAppointments),
            Tab(text: l10n.agendaTabAvailability),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AppointmentsTab(),
          AvailabilityTab(),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _tabController,
        builder: (context2, child2) {
          if (_tabController.index == 0) {
            return FloatingActionButton.extended(
              heroTag: 'agenda_book',
              onPressed: () => _showMemberPicker(context),
              label: Text(l10n.agendaBookButton),
              icon: const Icon(Icons.add),
            );
          }
          return FloatingActionButton.extended(
            heroTag: 'agenda_add',
            onPressed: () => AddSlotSheet.show(context),
            label: Text(l10n.agendaAddAvailability),
            icon: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  void _showMemberPicker(BuildContext context) {
    showMemberPickerSheet(context);
  }

  Future<void> _exportCalendar(BuildContext context) async {
    final l10n = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _controller.exportCalendar();
      if (context.mounted) {
        messenger.showSnackBar(SnackBar(
          content: Text(l10n.agendaExportSuccess),
          backgroundColor: AppColors.mossGreen,
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      if (context.mounted) {
        messenger.showSnackBar(SnackBar(
          content: Text(l10n.agendaExportError),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }
}
