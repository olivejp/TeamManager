import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team_manager/component/conges/conges_widget.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';
import 'package:team_manager/page/planning/planning_datasource.dart';
import 'package:team_manager/page/planning/planning_page_notifier.dart';

class PlanningPage extends StatelessWidget {
  final CongesCreateDtoPortionDebutEnumTypeTransformer portionDebutEnumTypeTransformer =
      CongesCreateDtoPortionDebutEnumTypeTransformer();
  final CongesCreateDtoPortionFinEnumTypeTransformer portionFinEnumTypeTransformer =
      CongesCreateDtoPortionFinEnumTypeTransformer();

  PlanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarCtl = CalendarController();
    final TeammateControllerApi teammateControllerApi = GetIt.I.get();
    calendarCtl.view = CalendarView.timelineMonth;

    return FutureBuilder<PageTeammateDto?>(
      future: teammateControllerApi.getAll(Pageable()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final dto = snapshot.data;
          final CongesDataSource dataSource = CongesDataSource(dto);
          return ChangeNotifierProvider(
            create: (_) => PlanningPageNotifier(calendarCtl),
            builder: (context, child) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  isExtended: true,
                  onPressed: () => openMeetingWidget(context, dataSource),
                  child: const Icon(Icons.edit_calendar),
                ),
                body: Center(
                  child: Column(
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
                                          calendarCtl.view == CalendarView.day,
                                          calendarCtl.view == CalendarView.week,
                                          calendarCtl.view == CalendarView.month,
                                          calendarCtl.view == CalendarView.timelineDay,
                                          calendarCtl.view == CalendarView.timelineMonth
                                        ],
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text('Jour'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text('Semaine'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text('Mois'),
                                          ),
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
                                    monthViewSettings: const MonthViewSettings(
                                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                                    ),
                                    blackoutDates: [DateTime(2022, 9, 24), DateTime(2022, 11, 1)],
                                    timeSlotViewSettings: const TimeSlotViewSettings(timeIntervalWidth: 50),
                                    onTap: (calendarTapDetails) =>
                                        openMeetingWidget(context, dataSource, calendarTapDetails: calendarTapDetails),
                                    appointmentBuilder: appointmentBuilder,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return LoadingRotating.square();
        }
      },
    );
  }

  Widget appointmentBuilder(BuildContext context, CalendarAppointmentDetails details) {
    final Conges conges = details.appointments.first;

    Color color;
    switch (conges.typeConges) {
      case CongesCreateDtoTypeCongesEnum.CONGE_PAYE:
        color = const Color(0xFFA621F3);
        break;
      case CongesCreateDtoTypeCongesEnum.MALADIE:
        color = const Color(0xFF67F321);
        break;
      case CongesCreateDtoTypeCongesEnum.SANS_SOLDE:
        color = const Color(0xFFF32159);
        break;
      default:
        color = const Color(0xFF2196F3);
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
        resources: [],
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
          onSave: (conges) => dataSource.saveConges(conges).then((value) => Navigator.of(context).pop()),
          onDelete: (id) {
            dataSource.deleteById(id);
            Navigator.of(context).pop();
          },
          onExit: Navigator.of(context).pop,
        ),
      ),
    );
  }
}
