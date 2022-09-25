import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/service/user_connected_service.dart';

class PlanningPageNotifier extends ChangeNotifier {
  final PlanningControllerApi planningControllerApi = GetIt.I.get();
  final CongesControllerApi congesControllerApi = GetIt.I.get();
  final UserConnectedService userConnectedService = GetIt.I.get();
  final CalendarController calendarController;

  PlanningPageNotifier(this.calendarController);

  CalendarView? getCalendarView() {
    return calendarController.view;
  }

  changeView(CalendarView newView) {
    calendarController.view = newView;
    notifyListeners();
  }

  changeViewOnIndex(int index) {
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
