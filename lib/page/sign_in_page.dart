import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/component/toast_layout_widget.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/notifier/sign_in_notifier.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    const regexpEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: Theme.of(context).primaryColor,
      ),
    );

    return ToastLayoutWidget(
      child: ChangeNotifierProvider(
          create: (context) => SignInNotifier(path),
          builder: (context, child) {
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30, left: 20),
                                child: Text(
                                  Constants.appTitle,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              Card(
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius: Constants.borderRadius,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(60.0),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          'connectToYourAccount'.i18n(),
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: TextFormField(
                                            style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              color: Colors.black87,
                                            ),
                                            decoration: InputDecoration(
                                                labelText: 'email'.i18n(),
                                                hintStyle: GoogleFonts.roboto(fontSize: 15),
                                                focusedBorder: defaultBorder,
                                                border: defaultBorder,
                                                enabledBorder: defaultBorder),
                                            onChanged: context.read<SignInNotifier>().setEmail,
                                            onFieldSubmitted: (value) =>
                                                context.read<SignInNotifier>().pressEnter(formKey),
                                            validator: (String? value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Merci de renseigner votre adresse email.';
                                              }
                                              if (!RegExp(regexpEmail).hasMatch(value)) {
                                                return "L'adresse mail n'est pas formatée correctement'.";
                                              }
                                              return null;
                                            },
                                            textInputAction: TextInputAction.done,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Consumer<SignInNotifier>(
                                                builder: (_, notifier, __) {
                                                  return TextFormField(
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 15,
                                                      color: Colors.black87,
                                                    ),
                                                    obscureText: notifier.hidePassword,
                                                    enableSuggestions: false,
                                                    autocorrect: false,
                                                    onChanged: notifier.setPassword,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Le mot de passe ne peut pas être vide.';
                                                      }
                                                      return null;
                                                    },
                                                    onFieldSubmitted: (value) => notifier.pressEnter(formKey),
                                                    decoration: InputDecoration(
                                                      labelText: 'password'.i18n(),
                                                      focusedBorder: defaultBorder,
                                                      border: defaultBorder,
                                                      enabledBorder: defaultBorder,
                                                      hintStyle: GoogleFonts.roboto(fontSize: 15),
                                                      suffixIcon: IconButton(
                                                        tooltip: notifier.hidePassword
                                                            ? 'showPassword'.i18n()
                                                            : 'hidePassword'.i18n(),
                                                        onPressed: () =>
                                                            notifier.changeHidePassword(!notifier.hidePassword),
                                                        icon: notifier.hidePassword
                                                            ? const Icon(Icons.visibility_outlined)
                                                            : const Icon(Icons.visibility_off_outlined),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              TextButton(
                                                onPressed: () => context.read<SignInNotifier>().forgotPassword(),
                                                child: Text('passwordForgotten'.i18n()),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: ElevatedButton(
                                            onPressed: () => context.read<SignInNotifier>().pressEnter(formKey),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(double.infinity, 55),
                                            ),
                                            child: Consumer<SignInNotifier>(
                                              builder: (_, notifier, child) {
                                                if (notifier.isLoading) {
                                                  return const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  );
                                                } else {
                                                  return child!;
                                                }
                                              },
                                              child: Text(
                                                'connect'.i18n(),
                                                style: Theme.of(context).textTheme.caption?.copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
