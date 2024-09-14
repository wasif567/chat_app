import 'package:chat/src/domain/models/country/country_model.dart';
import 'package:flutter/material.dart';

class CountryDropdown extends StatefulWidget {
  final List<CountryModel>? countryList;
  const CountryDropdown({super.key, this.countryList});

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CountryModel>(
        icon: const SizedBox(),
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        validator: (value) {
          if (value == null) {
            return "Select Country";
          }
          return null;
        },
        decoration: InputDecoration(
            suffix: const SizedBox(),
            suffixIcon: const SizedBox(),
            prefix: const SizedBox(),
            prefixIcon: const SizedBox(),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red)),
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
            helperText: '',
            hintText: "Select Country",
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            errorText: "Please select your Country",
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
            errorStyle: const TextStyle(color: Colors.red),
            isDense: true,
            counterText: "",
            counter: const SizedBox(),
            contentPadding: const EdgeInsets.all(16.0),
            filled: true,
            fillColor: Colors.white,
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none)),
        items: widget.countryList != null
            ? List.generate(widget.countryList!.length, (index) {
                CountryModel country = widget.countryList![index];
                return DropdownMenuItem(
                    child: Row(
                  children: [
                    Text(
                      "${country.flag} ${country.name} ",
                    ),
                  ],
                ));
              })
            : [],
        onChanged: (value) {
          //
        });
  }
}
