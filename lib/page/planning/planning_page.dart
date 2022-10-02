import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team_manager/component/conges/conges_widget.dart';
import 'package:team_manager/component/left_bar.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';
import 'package:team_manager/page/planning/planning_datasource.dart';
import 'package:team_manager/page/planning/planning_page_notifier.dart';

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
  final CongesCreateDtoPortionDebutEnumTypeTransformer portionDebutEnumTypeTransformer =
      CongesCreateDtoPortionDebutEnumTypeTransformer();
  final CongesCreateDtoPortionFinEnumTypeTransformer portionFinEnumTypeTransformer =
      CongesCreateDtoPortionFinEnumTypeTransformer();

  final congesPayesColor = const Color(0xFF1B46D0);
  final maladieColor = const Color(0xFF1B7FD0);
  final sansSoldeColor = const Color(0xFF1BA6D0);

  PlanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarCtl = CalendarController();
    final TeammateControllerApi teammateControllerApi = GetIt.I.get();
    calendarCtl.view = CalendarView.timelineMonth;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PlanningPageNotifier(calendarCtl)),
          ChangeNotifierProvider(create: (_) => ListCongesNotifier()),
        ],
        child: Scaffold(
          body: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LeftBarWidget(),
              Expanded(
                child: FutureBuilder<PageTeammateDto?>(
                    future: teammateControllerApi.getAll(Pageable()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final pageTeammateDto = snapshot.data;
                        final CongesDataSource dataSource = CongesDataSource(pageTeammateDto);
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () => calendarCtl.backward!(),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.arrow_back_ios_sharp),
                                            Text('previous'.i18n()),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Consumer<PlanningPageNotifier>(builder: (context, planningNotifier, child) {
                                            return ToggleButtons(
                                              color: Colors.white,
                                              borderColor: Colors.white,
                                              selectedBorderColor: Constants.primaryColor,
                                              borderRadius: Constants.borderRadius,
                                              onPressed: planningNotifier.changeViewOnIndex,
                                              isSelected: [
                                                calendarCtl.view == CalendarView.timelineDay,
                                                calendarCtl.view == CalendarView.timelineMonth
                                              ],
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text('Timeline jour'),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text('Timeline mois'),
                                                ),
                                              ],
                                            );
                                          }),
                                          TextButton(
                                            onPressed: () => calendarCtl.forward!(),
                                            child: Row(
                                              children: [
                                                Text('next'.i18n()),
                                                const Icon(Icons.arrow_forward_ios_sharp),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: Constants.borderRadius,
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SfCalendar(
                                          showDatePickerButton: true,
                                          controller: calendarCtl,
                                          allowAppointmentResize: true,
                                          view: CalendarView.month,
                                          backgroundColor: Colors.white,
                                          firstDayOfWeek: 1,
                                          showCurrentTimeIndicator: true,
                                          dataSource: dataSource,
                                          resourceViewSettings: const ResourceViewSettings(size: 60),
                                          resourceViewHeaderBuilder: resourceBuilder,
                                          blackoutDates: [DateTime(2022, 9, 24), DateTime(2022, 11, 1)],
                                          timeSlotViewSettings: const TimeSlotViewSettings(timeIntervalWidth: 50),
                                          appointmentBuilder: appointmentBuilder,
                                          monthViewSettings: const MonthViewSettings(
                                            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                                          ),
                                          onTap: (calendarTapDetails) => openMeetingWidget(context, dataSource,
                                              calendarTapDetails: calendarTapDetails),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          foregroundImage: details.resource.image,
          backgroundColor: details.resource.color,
        ),
        Text(
          details.resource.displayName,
          style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.black87),
        ),
        Consumer<ListCongesNotifier>(builder: (_, notifier, __) {
          final String email = details.resource.id as String;

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
    );
  }

  Widget appointmentBuilder(BuildContext context, CalendarAppointmentDetails details) {
    final Conges conges = details.appointments.first;

    Color color;
    switch (conges.typeConges) {
      case CongesCreateDtoTypeCongesEnum.CONGE_PAYE:
        color = congesPayesColor;
        break;
      case CongesCreateDtoTypeCongesEnum.MALADIE:
        color = maladieColor;
        break;
      case CongesCreateDtoTypeCongesEnum.SANS_SOLDE:
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
    // TODO Ne pas récupérer le conges si on a pas cliquer dessus mais à coté sur la meme date.
    if (calendarTapDetails?.appointments?.isNotEmpty == true) {
      // Si on a cliqué sur un Meeting qui existait, on va le réouvrir.
      initialConges = calendarTapDetails!.appointments?.first;
    } else {
      // Sinon on va créer un nouveau Meeting.
      final DateTime now = DateTime.now();
      initialConges = Conges(
        id: null,
        dateDebut: calendarTapDetails?.date ?? now,
        dateFin: calendarTapDetails?.date ?? now,
        resources: (calendarTapDetails?.resource?.id != null) ? [calendarTapDetails!.resource!.id] : [],
        typeConges: CongesCreateDtoTypeCongesEnum.CONGE_PAYE,
        portionDebut: portionDebutEnumTypeTransformer.encode(CongesCreateDtoPortionDebutEnum.MATIN),
        portionFin: portionFinEnumTypeTransformer.encode(CongesCreateDtoPortionFinEnum.MATIN),
      );
    }

    showDialog(
      context: context,
      builder: (alertContext) => AlertDialog(
        content: CongesWidget(
          initialConges: initialConges,
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
      ),
    );
  }
}
