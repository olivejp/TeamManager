import 'package:flutter/material.dart';
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  onPressed: notifier.selectToggle,
                  isSelected: CongesCreateDtoTypeCongesEnum.values.map((e) => e == notifier.conges.typeConges).toList(),
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
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                              label: const Text("A partir du"),
                              labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
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
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            label: const Text("Jusqu'au"),
                            labelStyle: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
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
                            'Supprimer',
                            style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.red),
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
                                textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.subtitle2),
                                padding:
                                    MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                              child: const Text('Annuler'),
                            ),
                          ),
                          TextButton(
                            onPressed: () => notifier.save(formKey, onSave),
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.subtitle2),
                              backgroundColor: MaterialStateProperty.all(Constants.primaryColor),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              padding:
                                  MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            child: const Text('Enregistrer'),
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
