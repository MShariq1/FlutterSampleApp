import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smaple_project/src/core/app_localizations.dart';
import 'package:smaple_project/src/core/route_generator.dart';
import 'package:smaple_project/src/core/theme/app_theme.dart';
import 'package:smaple_project/src/presentation/providers/authentication_provider.dart';
import 'package:smaple_project/src/presentation/providers/home_provider.dart';
import 'package:smaple_project/src/presentation/providers/locale_provider.dart';
import 'package:smaple_project/src/presentation/providers/main_view_provider.dart';

import 'dependency_injector.dart';

class sampleApp extends StatelessWidget {
  const sampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainViewProvider>.value(
          value: sl<MainViewProvider>(),
        ),
        ChangeNotifierProvider<AuthenticationProvider>.value(
            value: sl<AuthenticationProvider>()),
        ChangeNotifierProvider<HomeProvider>.value(
            value: sl<HomeProvider>()),
        ChangeNotifierProvider<LocaleProvider>.value(
            value: sl<LocaleProvider>()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (_,locale,child)=>MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
          ),
          title: 'Sample',
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar', 'AR'),
          ],
          locale: locale.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // CountryLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),

      ),
    );
  }
}
