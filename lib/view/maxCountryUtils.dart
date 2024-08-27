
import 'package:flutter/cupertino.dart';
import 'package:max_country_picker/model/country_model.dart';
import 'package:max_country_picker/src/max_country_list.dart';
import 'package:max_country_picker/utils/utils.dart';
import 'package:max_country_picker/max_country_picker.dart';

class MaxCountryUtils {
  static Widget? getFlagByCountryName(String countryName, {FlagMode? mode, double? flagIconSize}) {
    try {
      MaxCountry? country = MaxCountryList.list.firstWhere(
            (element) => element.name!.toLowerCase() == countryName.toLowerCase(),
      );

      if (country != null) {
        return countryFlag(
          country: country,
          mode: mode ?? FlagMode.circle,
          flagIconSize: flagIconSize ?? 24.0, // Default size if not provided
        );
      } else {
        return null; // Return null if country not found
      }
    } catch (e) {
      return null; // Handle any exceptions
    }
  }
}
