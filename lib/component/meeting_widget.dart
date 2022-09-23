import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/page/planning_page.dart';
import 'package:team_manager/service/user_connected_service.dart';

enum TypeConges { conges, maladie, sansSolde }

class MeetingWidgetNotifier extends ChangeNotifier {
  final DateFormat dateFormat = DateFormat('EEEE dd MMMM yyyy - HH:mm', 'fr_FR');

  final TextEditingController dateDebutController;
  final TextEditingController dateFinController;

  User? userConnected;
  String? commentaire = '';
  List<bool> listToggleSelected = [true, false, false];
  List<bool> listToggleDebut = [true, false];
  List<bool> listToggleFin = [true, false];
  TypeConges typeConges = TypeConges.conges;
  DateTime? dateDebut = DateTime.now();
  DateTime? dateFin = DateTime.now();
  bool? isAllDay = false;

  MeetingWidgetNotifier(this.dateDebutController, this.dateFinController) {
    final UserConnectedService userConnectedService = GetIt.I.get();
    userConnected = userConnectedService.user;
  }

  DateTime stringToDate(String dateAsString) {
    return dateFormat.parse(dateAsString);
  }

  String dateToString(DateTime dateTime) {
    return dateFormat.format(dateTime);
  }

  setIsAllDay(bool? isAllDay) {
    this.isAllDay = isAllDay;
    notifyListeners();
  }

  setCommentaire(String? commentaire) {
    this.commentaire = commentaire;
  }

  setDateDebut(DateTime? dateDebut) {
    if (dateDebut == null) {
      return;
    }
    this.dateDebut = dateDebut;
    this.dateDebut = getDateDebut();
    dateDebutController.text = dateToString(this.dateDebut!);
  }

  setDateFin(DateTime? dateFin) {
    if (dateFin == null) {
      return;
    }
    this.dateFin = dateFin;
    this.dateFin = getDateFin();
    dateFinController.text = dateToString(this.dateFin!);
  }

  TimeOfDay getHeureDebut() {
    return TimeOfDay(hour: (listToggleDebut[0]) ? 7 : 12, minute: 00);
  }

  TimeOfDay getHeureFin() {
    return TimeOfDay(hour: (listToggleFin[0]) ? 11 : 16, minute: 00);
  }

  DateTime getDateDebut() {
    TimeOfDay heureDebut = getHeureDebut();
    return DateTime(dateDebut!.year, dateDebut!.month, dateDebut!.day, heureDebut.hour, heureDebut.minute);
  }

  DateTime getDateFin() {
    TimeOfDay heureFin = getHeureFin();
    return DateTime(dateFin!.year, dateFin!.month, dateFin!.day, heureFin.hour, heureFin.minute);
  }

  Meeting? save(GlobalKey<FormState> formKey, Function(Meeting meeting) onSave) {
    if (formKey.currentState?.validate() == true) {
      Meeting meetingToSave = Meeting(
          eventName: commentaire!,
          from: getDateDebut(),
          to: getDateFin(),
          background: const Color(0xff3D5FC7),
          isAllDay: isAllDay!,
          comment: commentaire!,
          resources: [userConnected!.email!]);
      onSave(meetingToSave);
    } else {
      return null;
    }
  }

  setDateDebutAsString(String value) {
    try {
      final DateTime dateDebutParsed = dateFormat.parse(value);
      dateDebut = dateDebutParsed;
      dateDebut = getDateDebut();
    } catch (exception) {
      print('Date impossible à formatter.');
    }
  }

  setDateFinAsString(String value) {
    try {
      final DateTime dateFinParsed = dateFormat.parse(value);
      dateFin = dateFinParsed;
      dateFin = getDateFin();
    } catch (exception) {
      print('Date impossible à formatter.');
    }
  }

  selectToggle(int index) {
    listToggleSelected = [false, false, false];
    listToggleSelected[index] = true;
    switch (index) {
      case 0:
        typeConges = TypeConges.conges;
        break;
      case 1:
        typeConges = TypeConges.maladie;
        break;
      case 2:
        typeConges = TypeConges.sansSolde;
        break;
    }
    notifyListeners();
  }

  setToggleDebut(int index) {
    listToggleDebut = [false, false];
    listToggleDebut[index] = true;
    dateDebut = getDateDebut();
    dateDebutController.text = dateToString(dateDebut!);
    notifyListeners();
  }

  setToggleFin(int index) {
    listToggleFin = [false, false];
    listToggleFin[index] = true;
    dateFin = getDateFin();
    dateFinController.text = dateToString(dateFin!);
    notifyListeners();
  }
}

class MeetingWidget extends StatelessWidget {
  Meeting? initialMeeting;
  final Function(Meeting meeting) onSave;
  final Function() onExit;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController commentaireController = TextEditingController();
  final TextEditingController dateDebutController = TextEditingController();
  final TextEditingController dateFinController = TextEditingController();

  MeetingWidget({Key? key, required this.onSave, required this.onExit, this.initialMeeting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MeetingWidgetNotifier(dateDebutController, dateFinController),
      builder: (context, child) {
        return Consumer<MeetingWidgetNotifier>(builder: (context, notifier, child) {
          dateDebutController.text = notifier.dateToString(notifier.dateDebut!);
          dateFinController.text = notifier.dateToString(notifier.dateFin!);

          if (initialMeeting != null) {
            notifier.setCommentaire(initialMeeting!.eventName);
            commentaireController.text = notifier.commentaire!;
            notifier.setDateDebut(initialMeeting!.from);
            notifier.setDateFin(initialMeeting!.to);
            initialMeeting = null;
          }

          return Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  onPressed: notifier.selectToggle,
                  isSelected: notifier.listToggleSelected,
                  borderWidth: 0,
                  borderRadius: BorderRadius.circular(5),
                  textStyle: Theme.of(context).textTheme.subtitle2,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Congès payés',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Maladie',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Sans solde',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: dateDebutController,
                          onChanged: notifier.setDateDebutAsString,
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              label: const Text("A partir du"),
                              labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: notifier.dateDebut ?? DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100))
                                      .then((value) {
                                    notifier.setDateDebut(value);
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
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ToggleButtons(
                            onPressed: notifier.setToggleDebut,
                            isSelected: notifier.listToggleDebut,
                            borderWidth: 0,
                            borderRadius: BorderRadius.circular(5),
                            textStyle: Theme.of(context).textTheme.subtitle2,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Matin'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Après midi'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: dateFinController,
                          onChanged: notifier.setDateFinAsString,
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            label: const Text("Jusqu'au"),
                            labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                            suffixIcon: IconButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: notifier.dateFin ?? DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100))
                                    .then((value) {
                                  notifier.setDateFin(value);
                                });
                              },
                              icon: const Icon(Icons.calendar_today),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null) {
                              return 'Champ obligatoire.';
                            }
                            try {
                              notifier.stringToDate(value);
                            } catch (e) {
                              return 'La date de fin est mal formatée.';
                            }
                            DateTime dateDebut = notifier.getDateDebut();
                            DateTime dateFin = notifier.getDateFin();
                            if (dateFin.isBefore(dateDebut)) {
                              return 'La date de fin ne peut être avant la date de début.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ToggleButtons(
                            isSelected: notifier.listToggleFin,
                            onPressed: notifier.setToggleFin,
                            borderWidth: 0,
                            borderRadius: BorderRadius.circular(5),
                            textStyle: Theme.of(context).textTheme.subtitle2,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Matin'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Après midi'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: TextFormField(
                    controller: commentaireController,
                    onChanged: notifier.setCommentaire,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                    minLines: 2,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 2000,
                    decoration: InputDecoration(
                        label: const Text('Commentaire'),
                        labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
                        counterStyle: Theme.of(context).textTheme.caption,
                        border: const OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                            onPressed: onExit,
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.subtitle2),
                              padding:
                                  MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            child: const Text('Annuler')),
                      ),
                      TextButton(
                        onPressed: () => notifier.save(formKey, onSave),
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.subtitle2),
                          backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        child: const Text('Enregistrer'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }
}
