import 'dart:developer';

import 'package:example/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:max_country_picker/max_country_picker.dart';
import 'package:max_country_picker/view/maxCountryUtils.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var countryCode = 'ID';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                children: [
                  CustomTextField(
                    label: 'Default',
                    prefixWidget: MaxCountryPicker(
                      languageId: 2,
                      onCanged: (country) {
                        log(country.code!);
                      },
                    ),
                  ),
                  CustomTextField(
                    label:
                        'Emoji mode with filtered country [US, ID, SG, MY, GB]',
                    prefixWidget: MaxCountryPicker(
                      flagMode: FlagMode.emoji,
                      languageId: 2,
                      viewMode: ViewMode.modal,
                      flagIconSize: 22,
                      initialCountryCode: countryCode,
                      countryListConfig: const CountryListConfig(
                          filterOnlyShowingCountry: [
                            'US',
                            'ID',
                            'SG',
                            'MY',
                            'GB'
                          ]),
                      onCanged: (country) {
                        log(country.code!);
                      },
                    ),
                  ),
                  CustomTextField(
                    label: 'Page with customize',
                    prefixWidget: MaxCountryPicker(
                      flagMode: FlagMode.square,
                      languageId: 2,
                      viewMode: ViewMode.modal,
                      flagIconSize: 22,
                      topLeftRadius: 30,
                      topRightRadius: 30,
                      initialCountryCode: countryCode,
                      countryListConfig: CountryListConfig(
                        searchBackgroundColor: Colors.grey[800],
                        countryCodeTextStyle: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        countryNameTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        appBarTitleTextStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        appBarBackButtonColor: Colors.white,
                        searchIconColor: Colors.grey,
                        searchHintText: 'Search country',
                        searchHintTextStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        searchTextStyle:
                            const TextStyle(fontSize: 16, color: Colors.white),

                        //
                      ),
                      onCanged: (country) {
                        log(country.code!);
                      },
                    ),
                  ),
                  SizedBox(
                    child: MaxCountryUtils.getFlagByCountryName( "pakistan",mode:FlagMode.circle,flagIconSize: 30) ,
                  )



                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
