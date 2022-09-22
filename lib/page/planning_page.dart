import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team_manager/component/meeting_widget.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/openapi/api.dart';

class PlanningPageNotifier extends ChangeNotifier {
  final PlanningControllerApi planningControllerApi = GetIt.I.get();
  final CalendarController calendarController;

  PlanningPageNotifier(this.calendarController);

  CalendarView? getCalendarView() {
    return calendarController.view;
  }

  void changeView(CalendarView newView) {
    calendarController.view = newView;
    notifyListeners();
  }

  void changeViewOnIndex(int index) {
    switch (index) {
      case 0:
        changeView(CalendarView.day);
        break;
      case 1:
        changeView(CalendarView.week);
        break;
      case 2:
        changeView(CalendarView.month);
        break;
      case 3:
        changeView(CalendarView.timelineDay);
        break;
      case 4:
        changeView(CalendarView.timelineMonth);
        break;
    }
  }
}

class PlanningPage extends StatelessWidget {
  const PlanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarCtl = CalendarController();
    final TeammateControllerApi teammateControllerApi = GetIt.I.get();
    final MeetingDataSource dataSource = MeetingDataSource([], []);
    calendarCtl.view = CalendarView.month;

    return FutureBuilder<PageTeammateDto?>(
      future: teammateControllerApi.getAll(Pageable()),
      builder: (BuildContext context, AsyncSnapshot<PageTeammateDto?> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: LoadingBouncingGrid.square(),
          );
        }
        final PageTeammateDto? pageTeammateDto = snapshot.data;
        dataSource.setResources(pageTeammateDto);
        return ChangeNotifierProvider(
          create: (_) => PlanningPageNotifier(calendarCtl),
          builder: (context, child) {
            final PlanningPageNotifier notifier = Provider.of<PlanningPageNotifier>(context, listen: false);
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                isExtended: true,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (alertContext) => AlertDialog(
                      content: MeetingWidget(
                        onSave: (meeting) {
                          dataSource.addMeeting(meeting);
                          Navigator.of(context).pop();
                        },
                        onExit: Navigator.of(context).pop,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.edit_calendar),
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
                                  children: const [
                                    Icon(Icons.arrow_back_ios_sharp),
                                    Text('Précédent'),
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
                                      children: const [
                                        Text('Suivant'),
                                        Icon(Icons.arrow_forward_ios_sharp),
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
                                  onTap: (calendarTapDetails) {
                                    showDialog(
                                      context: context,
                                      builder: (alertContext) => AlertDialog(
                                        content: MeetingWidget(
                                          initialMeeting: calendarTapDetails.appointments?.isNotEmpty == true
                                              ? calendarTapDetails.appointments?.first
                                              : null,
                                          onSave: (meeting) {
                                            dataSource.addMeeting(meeting);
                                            Navigator.of(context).pop();
                                          },
                                          onExit: Navigator.of(context).pop,
                                        ),
                                      ),
                                    );
                                  },
                                  appointmentBuilder: (context, calendarAppointmentDetails) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: calendarAppointmentDetails.appointments.first.background,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child:
                                          Text(calendarAppointmentDetails.appointments.map((e) => e.eventName).join()),
                                    );
                                  },
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
      },
    );
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source, List<CalendarResource>? listResource) {
    appointments = source;
    resources = listResource;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  @override
  List<Object> getResourceIds(int index) {
    return _getMeetingData(index).resources;
  }

  void setResources(PageTeammateDto? pageTeammateDto) {
    resources?.clear();
    if (pageTeammateDto != null) {
      resources?.addAll(
        pageTeammateDto.content.map((e) => CalendarResource(id: e.id!, displayName: e.prenom!)),
      );
    }
  }

  void addMeeting(Meeting meeting) {
    appointments?.add(meeting);
    notifyListeners(CalendarDataSourceAction.add, [meeting]);
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  Meeting(
      {required this.eventName,
      required this.from,
      required this.to,
      required this.background,
      required this.isAllDay,
      required this.resources});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  List<Object> resources;
}
