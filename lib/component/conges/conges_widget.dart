import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/component/conges/conges_notifier.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/page/planning/planning_conges.dart';

class CongesWidget extends StatelessWidget {
  final Conges initialConges;
  final Function(Conges meeting) onSave;
  final Function(int id) onDelete;
  final Function() onExit;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController commentaireController = TextEditingController();
  final TextEditingController dateDebutController = TextEditingController();
  final TextEditingController dateFinController = TextEditingController();

  final CongesPersistDtoPortionDebutEnumTypeTransformer _portionDebutEnumTypeTransformer =
      CongesPersistDtoPortionDebutEnumTypeTransformer();
  final CongesPersistDtoPortionFinEnumTypeTransformer _portionFinEnumTypeTransformer =
      CongesPersistDtoPortionFinEnumTypeTransformer();

  CongesWidget({
    Key? key,
    required this.initialConges,
    required this.onSave,
    required this.onExit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CongesWidgetNotifier(
        initialConges,
        dateDebutController,
        dateFinController,
        commentaireController,
      ),
      builder: (context, child) {
        return Consumer<CongesWidgetNotifier>(builder: (context, notifier, child) {
          dateDebutController.text = notifier.dateToString(notifier.conges.dateDebut);
          dateFinController.text = notifier.dateToString(notifier.conges.dateFin);
          return Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  onPressed: notifier.selectToggle,
                  isSelected:
                      CongesPersistDtoTypeCongesEnum.values.map((e) => e == notifier.conges.typeConges).toList(),
                  borderWidth: 0,
                  borderRadius: BorderRadius.circular(5),
                  textStyle: Theme.of(context).textTheme.titleSmall,
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
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              label: Text('from'.i18n()),
                              labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: notifier.conges.dateDebut,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100))
                                      .then(notifier.setDateDebut);
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
                            isSelected: CongesPersistDtoPortionDebutEnum.values
                                .map((e) => e == _portionDebutEnumTypeTransformer.decode(notifier.conges.portionDebut))
                                .toList(),
                            borderWidth: 0,
                            borderRadius: BorderRadius.circular(5),
                            textStyle: Theme.of(context).textTheme.titleSmall,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('morning'.i18n()),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('noon'.i18n()),
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
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            label: Text('to'.i18n()),
                            labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                            suffixIcon: IconButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: notifier.conges.dateFin,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100))
                                    .then(notifier.setDateFin);
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
                            DateTime dateDebut = notifier.conges.dateDebut;
                            DateTime dateFin = notifier.conges.dateFin;
                            if (dateFin.isAtSameMomentAs(dateDebut) &&
                                (CongesPersistDtoPortionDebutEnum.APRES_MIDI ==
                                        _portionDebutEnumTypeTransformer.decode(notifier.conges.portionDebut) &&
                                    CongesPersistDtoPortionFinEnum.MATIN ==
                                        _portionFinEnumTypeTransformer.decode(notifier.conges.portionFin))) {
                              return 'Date de fin antérieure à date de début.';
                            }

                            if (dateFin.isBefore(dateDebut)) {
                              return 'Date de fin antérieure à date de début.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ToggleButtons(
                            isSelected: CongesPersistDtoPortionFinEnum.values
                                .map((e) => e == _portionFinEnumTypeTransformer.decode(notifier.conges.portionFin))
                                .toList(),
                            onPressed: notifier.setToggleFin,
                            borderWidth: 0,
                            borderRadius: BorderRadius.circular(5),
                            textStyle: Theme.of(context).textTheme.titleSmall,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('morning'.i18n()),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('noon'.i18n()),
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                    minLines: 2,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 2000,
                    decoration: InputDecoration(
                        label: Text('comment'.i18n()),
                        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
                        counterStyle: Theme.of(context).textTheme.bodySmall,
                        border: const OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (notifier.conges.id == null) Container(),
                      if (notifier.conges.id != null)
                        TextButton(
                          onPressed: () => onDelete(notifier.conges.id!),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            overlayColor: MaterialStateProperty.all(Colors.red.shade50),
                          ),
                          child: Text(
                            'delete'.i18n(),
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.red),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              onPressed: onExit,
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.titleSmall),
                                padding:
                                    MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                              child: Text('cancel'.i18n()),
                            ),
                          ),
                          TextButton(
                            onPressed: () => notifier.save(formKey, onSave),
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.titleSmall),
                              backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              padding:
                                  MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            child: Text('save'.i18n()),
                          )
                        ],
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
