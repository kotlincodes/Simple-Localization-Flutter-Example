import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization_app/localization/LocalizationKeys.dart';
import 'package:localization_app/localization/app_localizations.dart';
import 'package:localization_app/localization/supported_languages.dart';
import 'package:localization_app/view_models/settings_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsViewModel(),
        ),
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, viewModel, child) {
          return MaterialApp(
            supportedLocales: supportedLanguages,
            localizationsDelegates: [
              AppLocalization.delegate,
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            locale: viewModel.getLocale,
            title: 'Localization Example',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Localization Example'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(builder: (context, model, child) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalization.of(context).translate(LocalizationKey.TITLE),
                ),
                ElevatedButton(
                    onPressed: () {
                      model.setLocale(model.getLocale == Locale("en")
                          ? Locale("zh")
                          : Locale("en"));
                    },
                    child: Text("Change Language"))
              ],
            ),
          ),
        ),
      );
    });
  }
}
