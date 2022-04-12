import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/controller/sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const regexpEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final SignInController controller = GetIt.I.get();

    final ValueNotifier<bool> isLoading = ValueNotifier(false);
    final ValueNotifier<bool> hidePasswordNotifier = ValueNotifier(true);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: Theme.of(context).primaryColor,
      ),
    );

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
                            key: _formKey,
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
                                      color: Colors.grey,
                                    ),
                                    decoration: InputDecoration(
                                        labelText: 'email'.i18n(),
                                        hintStyle: GoogleFonts.roboto(fontSize: 15),
                                        focusedBorder: defaultBorder,
                                        border: defaultBorder,
                                        enabledBorder: defaultBorder),
                                    onChanged: controller.setEmail,
                                    onFieldSubmitted: (value) => pressEnter(isLoading, controller, _formKey),
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
                                      ValueListenableBuilder<bool>(
                                        valueListenable: hidePasswordNotifier,
                                        builder: (_, hidePassword, __) {
                                          return TextFormField(
                                            style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                            obscureText: hidePassword,
                                            enableSuggestions: false,
                                            autocorrect: false,
                                            onChanged: controller.setPassword,
                                            onFieldSubmitted: (value) => pressEnter(isLoading, controller, _formKey),
                                            decoration: InputDecoration(
                                              labelText: 'password'.i18n(),
                                              focusedBorder: defaultBorder,
                                              border: defaultBorder,
                                              enabledBorder: defaultBorder,
                                              hintStyle: GoogleFonts.roboto(fontSize: 15),
                                              suffixIcon: IconButton(
                                                tooltip: hidePassword ? 'showPassword'.i18n() : 'hidePassword'.i18n(),
                                                onPressed: () => hidePasswordNotifier.value = !hidePassword,
                                                icon: hidePassword
                                                    ? const Icon(Icons.visibility_outlined)
                                                    : const Icon(Icons.visibility_off_outlined),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text('passwordForgotten'.i18n()),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: ElevatedButton(
                                    onPressed: () => pressEnter(isLoading, controller, _formKey),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(double.infinity, 55),
                                    ),
                                    child: ValueListenableBuilder<bool>(
                                      valueListenable: isLoading,
                                      builder: (_, value, child) {
                                        if (value) {
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
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20),
                        child: Row(
                          children: <Widget>[
                            Text('noAccount'.i18n()),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'signUp'.i18n(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void pressEnter(ValueNotifier<bool> isLoading, SignInController controller, GlobalKey<FormState> _formKey) {
    isLoading.value = true;
    controller
        .onPressEnter(_formKey)
        .then((value) => isLoading.value = false)
        .onError((error, stackTrace) => isLoading.value = false);
  }
}
