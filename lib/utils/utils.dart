import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_country_picker/config/country_list_config.dart';
import 'package:max_country_picker/model/country_model.dart';
import 'package:max_country_picker/view/country_picker.dart';

// IconViewMode
countryFlag(
    {required MaxCountry country,
    required FlagMode mode,
    required double flagIconSize}) {
  if (mode == FlagMode.circle) {
    return SvgPicture.asset(
      country.flagIconCircle!,
      package: 'max_country_picker',
      width: flagIconSize,
    );
  } else if (mode == FlagMode.square) {
    return SvgPicture.asset(
      country.flagIconSquare!,
      width: flagIconSize,
      package: 'max_country_picker',
    );
  } else if (mode == FlagMode.emoji) {
    return Text(
      country.flagEmoji!,
      style: TextStyle(fontSize: flagIconSize),
    );
  }
}

Widget maxDivideThick({height, color, margin}) {
  return Container(
    height: height ?? 2,
    color: color ?? Colors.grey.shade50,
    margin: margin ?? EdgeInsets.zero,
  );
}

maxBottomSheet(BuildContext context, Widget child,
    {String? subtitle,
    String? title,
    double? height,
    double? topLeftRadius,
    double? topRightRadius,
    double? bottomRightRadius,
    double? bottomLeftRadius,
    required CountryListConfig countryListConfig}) {
  return showModalBottomSheet(
      isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(topLeft:Radius.circular(topLeftRadius!) ,topRight:Radius.circular(topRightRadius!) ,bottomRight:Radius.circular(bottomRightRadius!) ,bottomLeft:Radius.circular(bottomLeftRadius!) ,),),
      backgroundColor: countryListConfig.modalBackgoroundColor,
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.25,
            maxChildSize: 1.0,
            expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(topLeftRadius!) ,topRight:Radius.circular(topRightRadius!) ,bottomRight:Radius.circular(bottomRightRadius!) ,bottomLeft:Radius.circular(bottomLeftRadius!) ,),
                color: countryListConfig.modalBackgoroundColor,
              ),

              height: height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  maxIndicatorModal(
                      color: countryListConfig.modalIndicatorColor!),
                  const SizedBox(height: 6),
                  if (title != null)
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: countryListConfig.modalTitleTextStyle,
                      ),
                    ),
                  if (title != null) const SizedBox(height: 16),
                  // // if (title != null) divideThick(),
                  // const SizedBox(height: 6),
                  child,
                ],
              ),
            );
          }
        );
      });
}

Widget maxIndicatorModal({Color? color}) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 40,
      height: 8,
      decoration: maxRoundedDecoration(color: color ?? Colors.grey.shade200),
    ),
  );
}

BoxDecoration maxRoundedDecoration({color, borderColor, radius}) {
  return BoxDecoration(
      color: color ?? Colors.white,
      border: Border.all(color: borderColor ?? Colors.white, width: 1),
      borderRadius: radius ??
          const BorderRadius.all(
            Radius.circular(16),
          ));
}
