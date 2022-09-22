import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/page/planning_page.dart';

class MeetingWidgetNotifier extends ChangeNotifier {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  String? nomEvenement = '';
  DateTime? dateDebut = DateTime.now();
  DateTime? dateFin = DateTime.now();
  bool? isAllDay = false;
  TimeOfDay? heureDebut = TimeOfDay.now();
  TimeOfDay? heureFin =
      TimeOfDay.now().replacing(hour: TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1))).hour);

  DateTime stringToDate(String dateAsString) {
    return dateFormat.parse(dateAsString);
  }

  String dateToString(DateTime dateTime) {
    return dateFormat.format(dateTime);
  }

  void setIsAllDay(bool? isAllDay) {
    this.isAllDay = isAllDay;
    notifyListeners();
  }

  void setNomEvenement(String? nomEvenement) {
    this.nomEvenement = nomEvenement;
  }

  void setDateDebut(DateTime? dateDebut, TextEditingController dateDebutController) {
    this.dateDebut = dateDebut;
    dateDebutController.text = dateToString(this.dateDebut!);
  }

  void setDateFin(DateTime? dateFin, TextEditingController dateFinController) {
    this.dateFin = dateFin;
    dateFinController.text = dateToString(this.dateFin!);
  }

  Meeting? save(GlobalKey<FormState> formKey, Function(Meeting meeting) onSave) {
    final DateTime dateDebutFormatted =
        DateTime(dateDebut!.year, dateDebut!.month, dateDebut!.day, heureDebut!.hour, heureDebut!.minute);
    final DateTime dateFinFormatted =
        DateTime(dateFin!.year, dateFin!.month, dateFin!.day, heureFin!.hour, heureFin!.minute);
    if (formKey.currentState?.validate() == true) {
      Meeting meetingToSave = Meeting(
          eventName: nomEvenement!,
          from: dateDebutFormatted,
          to: dateFinFormatted,
          background: const Color(0xff3D5FC7),
          isAllDay: isAllDay!,
          resources: ['0', '2']);
      onSave(meetingToSave);
    } else {
      return null;
    }
  }

  void setHeureDebut(BuildContext context, TimeOfDay? heureDebut, TextEditingController heureDebutController) {
    this.heureDebut = heureDebut;
    heureDebutController.text = heureDebut!.format(context);
  }

  void setHeureFin(BuildContext context, TimeOfDay? heureFin, TextEditingController heureFinController) {
    this.heureFin = heureFin;
    heureFinController.text = heureFin!.format(context);
  }

  void setDateDebutAsString(String value) {
    try {
      final DateTime dateDebutParsed = dateFormat.parse(value);
      dateDebut = dateDebutParsed;
    } catch (exception) {
      print('Date impossible à formatter.');
    }
  }

  void setDateFinAsString(String value) {
    try {
      final DateTime dateFinParsed = dateFormat.parse(value);
      dateFin = dateFinParsed;
    } catch (exception) {
      print('Date impossible à formatter.');
    }
  }
}

class MeetingWidget extends StatelessWidget {
  Meeting? initialMeeting;
  final Function(Meeting meeting) onSave;
  final Function() onExit;
  final GlobalKey<FormState> formKey = GlobalKey();
  final MaskTextInputFormatter dateMaskFormatter =
      MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  final TextEditingController nomEvenementController = TextEditingController();
  final TextEditingController heureDebutController = TextEditingController();
  final TextEditingController heureFinController = TextEditingController();
  final TextEditingController dateDebutController = TextEditingController();
  final TextEditingController dateFinController = TextEditingController();

  MeetingWidget({Key? key, required this.onSave, required this.onExit, this.initialMeeting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MeetingWidgetNotifier(),
      builder: (context, child) {
        return Consumer<MeetingWidgetNotifier>(builder: (context, notifier, child) {
          heureDebutController.text = notifier.heureDebut!.format(context);
          heureFinController.text = notifier.heureFin!.format(context);
          dateDebutController.text = notifier.dateToString(notifier.dateDebut!);
          dateFinController.text = notifier.dateToString(notifier.dateFin!);

          if (initialMeeting != null) {
            notifier.setNomEvenement(initialMeeting!.eventName);
            nomEvenementController.text = notifier.nomEvenement!;
            notifier.setDateDebut(initialMeeting!.from, dateDebutController);
            notifier.setDateFin(initialMeeting!.to, dateFinController);
            notifier.setHeureDebut(context, TimeOfDay.fromDateTime(initialMeeting!.from), heureDebutController);
            notifier.setHeureFin(context, TimeOfDay.fromDateTime(initialMeeting!.to), heureFinController);
            initialMeeting = null;
          }

          return Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: nomEvenementController,
                    onChanged: notifier.setNomEvenement,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Champ obligatoire.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text('Ajouter un titre'),
                      labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                      counterStyle: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: dateDebutController,
                            onChanged: notifier.setDateDebutAsString,
                            inputFormatters: [dateMaskFormatter],
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                            decoration: InputDecoration(
                                label: const Text("Début"),
                                labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: notifier.dateDebut ?? DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100))
                                        .then((value) {
                                      notifier.setDateDebut(value, dateDebutController);
                                    });
                                  },
                                  icon: const Icon(Icons.calendar_today),
                                )),
                            validator: (String? value) {
                              if (value == null) {
                                return 'Champ obligatoire.';
                              }
                              try {
                                notifier.stringToDate(value);
                              } catch (e) {
                                return 'La date de début est mal formatée.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: heureDebutController,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              label: const Text("Heure"),
                              labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showTimePicker(context: context, initialTime: notifier.heureDebut!)
                                      .then((value) => notifier.setHeureDebut(context, value, heureDebutController));
                                },
                                icon: const Icon(Icons.access_time_rounded),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: dateFinController,
                            onChanged: notifier.setDateFinAsString,
                            inputFormatters: [dateMaskFormatter],
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                            decoration: InputDecoration(
                                label: const Text("Fin"),
                                labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: notifier.dateFin ?? DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100))
                                        .then((value) {
                                      notifier.setDateFin(value, dateFinController);
                                    });
                                  },
                                  icon: const Icon(Icons.calendar_today),
                                )),
                            validator: (String? value) {
                              if (value == null) {
                                return 'Champ obligatoire.';
                              }
                              try {
                                notifier.stringToDate(value);
                              } catch (e) {
                                return 'La date de fin est mal formatée.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: heureFinController,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              label: const Text("Heure"),
                              labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showTimePicker(context: context, initialTime: notifier.heureFin!)
                                      .then((value) => notifier.setHeureFin(context, value, heureFinController));
                                },
                                icon: const Icon(Icons.access_time_rounded),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTile(
                    value: notifier.isAllDay,
                    title: Text(
                      "Toute la journée",
                      style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                    ),
                    onChanged: notifier.setIsAllDay,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: onExit, child: const Text('Annuler')),
                    TextButton(
                      onPressed: () => notifier.save(formKey, onSave),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      child: const Text('Enregistrer'),
                    ),
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }
}
