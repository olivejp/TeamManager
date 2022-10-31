import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:team_manager/component/conges/conges_widget.dart';
import 'package:team_manager/component/left_bar.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';
import 'package:team_manager/page/planning/planning_datasource.dart';
import 'package:team_manager/page/planning/planning_page_notifier.dart';

class RightPlanningDrawer extends StatelessWidget {
  final CongesDataSource dataSource;

  const RightPlanningDrawer({Key? key, required this.dataSource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 700,
      backgroundColor: Colors.white,
      elevation: 10,
      child: Consumer<RightDrawerNotifier>(builder: (context, notifier, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Constants.primaryColor,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notifier.creation ? 'Création' : 'Mise à jour',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () => context.read<RightDrawerNotifier>().closeDrawer(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CongesWidget(
                initialConges: notifier.conges!,
                onSave: (conges) => dataSource.saveConges(conges).then((_) {
                  // Provider.of<ListCongesNotifier>(context).reload();
                  Navigator.of(context).pop();
                }),
                onDelete: (id) {
                  dataSource.deleteById(id).then((_) {
                    // Provider.of<ListCongesNotifier>(context).reload();
                    Navigator.of(context).pop();
                  });
                },
                onExit: Navigator.of(context).pop,
              ),
            )
          ],
        );
      }),
    );
  }
}

class RightDrawerNotifier extends ChangeNotifier {
  final GlobalKey<ScaffoldState> key;
  Conges? conges;
  bool creation = false;

  RightDrawerNotifier(this.key);

  setConges(bool creation, Conges? conges) {
    this.creation = creation;
    this.conges = conges;
    if (key.currentState?.isEndDrawerOpen == false) {
      openDrawer();
    }
    notifyListeners();
  }

  openDrawer() {
    if (key.currentState?.isEndDrawerOpen == false) {
      key.currentState?.openEndDrawer();
    }
  }

  closeDrawer() {
    key.currentState?.closeEndDrawer();
  }
}

class ListCongesNotifier extends ChangeNotifier {
  final CongesControllerApi congesControllerApi = GetIt.I.get();

  List<CongesDto> listConges = [];

  reload() {
    congesControllerApi.getAll2(Pageable()).then((value) {
      listConges = value!.content;
      notifyListeners();
    });
  }
}

class PlanningPage extends StatelessWidget {
  final CongesPersistDtoPortionDebutEnumTypeTransformer portionDebutEnumTypeTransformer =
      CongesPersistDtoPortionDebutEnumTypeTransformer();
  final CongesPersistDtoPortionFinEnumTypeTransformer portionFinEnumTypeTransformer =
      CongesPersistDtoPortionFinEnumTypeTransformer();

  final congesPayesColor = const Color(0xFF1B46D0);
  final maladieColor = const Color(0xFF1B7FD0);
  final sansSoldeColor = const Color(0xFF1BA6D0);

  PlanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarCtl = CalendarController();
    final TeammateControllerApi teammateControllerApi = GetIt.I.get();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    final CongesDataSource dataSource = CongesDataSource();
    calendarCtl.view = CalendarView.timelineMonth;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PlanningPageNotifier(calendarCtl)),
          ChangeNotifierProvider(create: (_) => ListCongesNotifier()),
          ChangeNotifierProvider(create: (_) => RightDrawerNotifier(scaffoldKey)),
        ],
        child: Scaffold(
          key: scaffoldKey,
          endDrawer: RightPlanningDrawer(
            dataSource: dataSource,
          ),
          drawerScrimColor: Colors.transparent,
          endDrawerEnableOpenDragGesture: false,
          body: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LeftBarWidget(),
              Expanded(
                child: FutureBuilder<PageTeammateDto?>(
                    future: teammateControllerApi.getAll(Pageable()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        dataSource.setPage(snapshot.data);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                'Planning',
                                style: GoogleFonts.nunito(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: Constants.borderRadius,
                                      ),
                                      color: Constants.backgroundColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SfCalendarTheme(
                                          data: SfCalendarThemeData(
                                              backgroundColor: Constants.backgroundColor,
                                              headerTextStyle: const TextStyle(color: Colors.white54),
                                              viewHeaderDayTextStyle: const TextStyle(color: Colors.white54),
                                              viewHeaderDateTextStyle: const TextStyle(color: Colors.white54),
                                              cellBorderColor: Colors.white10),
                                          child: SfCalendar(
                                            showDatePickerButton: false,
                                            controller: calendarCtl,
                                            allowAppointmentResize: true,
                                            firstDayOfWeek: 1,
                                            showNavigationArrow: true,
                                            showCurrentTimeIndicator: true,
                                            dataSource: dataSource,
                                            resourceViewSettings: const ResourceViewSettings(size: 60),
                                            resourceViewHeaderBuilder: resourceBuilder,
                                            timeSlotViewSettings: const TimeSlotViewSettings(timeIntervalWidth: 70),
                                            appointmentBuilder: appointmentBuilder,
                                            onTap: (calendarTapDetails) => openMeetingWidget(context, dataSource,
                                                calendarTapDetails: calendarTapDetails),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return LoadingRotating.square();
                      }
                    }),
              ),
            ],
          ),
        ));
  }

  Widget resourceBuilder(BuildContext context, ResourceViewHeaderDetails details) {
    return Container(
      color: Constants.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundImage: details.resource.image,
              backgroundColor: details.resource.color,
            ),
            Text(
              details.resource.displayName,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 9,
              ),
            ),
            Consumer<ListCongesNotifier>(builder: (_, notifier, __) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                clipBehavior: Clip.hardEdge,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        color: congesPayesColor,
                        child: const Center(child: Text('0')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: maladieColor,
                        child: const Center(child: Text('0')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: sansSoldeColor,
                        child: const Center(child: Text('0')),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget appointmentBuilder(BuildContext context, CalendarAppointmentDetails details) {
    final Conges conges = details.appointments.first;

    Color color;
    switch (conges.typeConges) {
      case CongesPersistDtoTypeCongesEnum.CONGE_PAYE:
        color = congesPayesColor;
        break;
      case CongesPersistDtoTypeCongesEnum.MALADIE:
        color = maladieColor;
        break;
      case CongesPersistDtoTypeCongesEnum.SANS_SOLDE:
        color = sansSoldeColor;
        break;
      default:
        color = congesPayesColor;
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          conges.typeConges.toString(),
        ),
      ),
    );
  }

  openMeetingWidget(BuildContext context, CongesDataSource dataSource, {CalendarTapDetails? calendarTapDetails}) {
    Conges initialConges;
    bool creation = false;
    // TODO Ne pas récupérer le conges si on a pas cliqué dessus mais à coté sur la meme date.
    if (calendarTapDetails?.appointments?.isNotEmpty == true) {
      // Si on a cliqué sur un Conges qui existait, on va le réouvrir.
      creation = false;
      initialConges = calendarTapDetails!.appointments?.first;
    } else {
      // Sinon on va créer un nouveau Conges.
      creation = true;
      final DateTime now = DateTime.now();
      initialConges = Conges(
        id: null,
        dateDebut: calendarTapDetails?.date ?? now,
        dateFin: calendarTapDetails?.date ?? now,
        resources: (calendarTapDetails?.resource?.id != null) ? [calendarTapDetails!.resource!.id] : [],
        typeConges: CongesPersistDtoTypeCongesEnum.CONGE_PAYE,
        portionDebut: portionDebutEnumTypeTransformer.encode(CongesPersistDtoPortionDebutEnum.MATIN),
        portionFin: portionFinEnumTypeTransformer.encode(CongesPersistDtoPortionFinEnum.MATIN),
      );
    }

    context.read<RightDrawerNotifier>().setConges(creation, initialConges);
  }
}
