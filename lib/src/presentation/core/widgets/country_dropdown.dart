import 'package:chat/src/domain/models/country/country_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CountryDropdown extends StatefulWidget {
  final List<CountryModel>? countryList;
  final Function(CountryModel?) onChanged;
  final String? Function(CountryModel?) validator;
  const CountryDropdown({super.key, this.countryList, required this.onChanged, required this.validator});

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  final ValueNotifier<CountryModel?> selectedCountry = ValueNotifier<CountryModel?>(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedCountry,
        builder: (context, value, child) {
          return DropdownSearch<CountryModel>(
            selectedItem: selectedCountry.value,
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                counterText: "",
                suffixIcon: selectedCountry.value != null
                    ? GestureDetector(
                        onTap: () {
                          selectedCountry.value = null;
                          widget.onChanged(null);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 18,
                        ),
                      )
                    : null,
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Select Country",
                counter: const SizedBox(),
                hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                errorStyle: const TextStyle(color: Colors.red),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            validator: widget.validator,
            itemAsString: (CountryModel? country) => country != null ? country.name.common : '',
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  labelText: "Search Country",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              loadingBuilder: (context, searchEntry) {
                return CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                );
              },
              cacheItems: false,
              itemBuilder: (context, country, isSelected, unSelected) {
                return ListTile(
                  leading: Image.network(
                    country.flags.png,
                    height: 24,
                    width: 24,
                  ),
                  title: Text(
                    country.name.common,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
            compareFn: (item1, item2) {
              return item1 != item2;
            },
            dropdownBuilder: (context, selectedItem) {
              if (selectedItem != null) {
                return ListTile(
                  leading: Image.network(
                    selectedItem.flags.png,
                    height: 24,
                    width: 24,
                  ),
                  title: Text(
                    selectedItem.name.common,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
            items: (filter, loadProps) {
              return filter.isEmpty
                  ? widget.countryList!.toList()
                  : widget.countryList!
                      .where((country) => country.name.common.toUpperCase().contains(filter.toUpperCase()))
                      .toList(); //loadProps. //.filter(filter).map((country) {});
            },
            onChanged: (CountryModel? value) {
              widget.onChanged(value);
            },
          );
        });
  }
}
