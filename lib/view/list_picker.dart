import 'package:flutter/material.dart';
import 'package:max_country_picker/config/country_list_config.dart';
import 'package:max_country_picker/model/country_model.dart';
import 'package:max_country_picker/src/max_country_list.dart';
import 'package:max_country_picker/view/country_picker.dart';
import 'package:max_country_picker/view/search_bar.dart';
import 'package:max_country_picker/utils/utils.dart';

class MaxListPicker extends StatefulWidget {
  final Function(MaxCountry)? onCanged;
  final FlagMode? mode;
     int languageId;
  final CountryListConfig countryListConfig;
   MaxListPicker(
      {Key? key,
      this.onCanged,
        required this.languageId,
      this.mode = FlagMode.circle,
      required this.countryListConfig})
      : super(key: key);

  @override
  State<MaxListPicker> createState() => _MaxListPickerState();
}

class _MaxListPickerState extends State<MaxListPicker> {
  String? title;

  final searchController = TextEditingController();

  List<MaxCountry> countryList = MaxCountryList.list;
  List<MaxCountry> dataList = [];

  @override
  void initState() {
    setState(() {
      if (widget.countryListConfig.filterOnlyShowingCountry.isNotEmpty) {
        dataList = countryList
            .where((element) => widget
                .countryListConfig.filterOnlyShowingCountry
                .contains(element.code))
            .toList()
            .where((element) => !widget.countryListConfig.filterExcludeCountry
                .contains(element.code))
            .toList();
      } else {
        dataList = countryList
            .where((element) => !widget.countryListConfig.filterExcludeCountry
                .contains(element.code))
            .toList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.countryListConfig.backgroundColor,
      body: Column(
        children: [
          if (widget.countryListConfig.hideSearchBar == false)
            MaxSearchBar(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  if (widget
                      .countryListConfig.filterOnlyShowingCountry.isNotEmpty) {
                    dataList = countryList
                        .where((element) => widget
                            .countryListConfig.filterOnlyShowingCountry
                            .contains(element.code))
                        .toList()
                        .where((element) => !widget
                            .countryListConfig.filterExcludeCountry
                            .contains(element.code))
                        .toList()
                        .where((e) => e.name!
                            .toLowerCase()
                            .startsWith(value.toLowerCase()))
                        .toList();
                  } else {
                    dataList = countryList
                        .where((element) => !widget
                            .countryListConfig.filterExcludeCountry
                            .contains(element.code))
                        .toList()
                        .where((e) => e.name!
                            .toLowerCase()
                            .startsWith(value.toLowerCase()))
                        .toList();
                  }
                });
              },
              countrtyListConfig: widget.countryListConfig,
            ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.separated(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              var country = dataList[index];
              return ListTile(
                title: Row(
                  children: [
                    countryFlag(
                        country: country,
                        mode: widget.mode!,
                        flagIconSize: widget.countryListConfig.flagIconSize!),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Text(
                            widget.languageId==1?
                            country.name!: country.nameAr!,
                            style:
                                widget.countryListConfig.countryNameTextStyle)),
                  ],
                ),
                trailing: Text(
                  country.dialCode!,
                  style: widget.countryListConfig.countryCodeTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.onCanged!(country);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return maxDivideThick(
                  color: widget.countryListConfig.separatedColor);
            },
          ))
        ],
      ),
    );
  }
}
