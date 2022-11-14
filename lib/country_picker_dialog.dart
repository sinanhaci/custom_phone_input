import 'package:flutter/material.dart';

import 'countries.dart';
import 'helpers.dart';


class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;
  final Color backgroundColor;
  final Color backButtonColor;
  final TextStyle searchFieldStyle;

  const CountryPickerDialog({
    Key? key,
    required this.searchFieldStyle,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    required this.backgroundColor,
    required this.backButtonColor,
    this.style,
  }) : super(key: key);

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 85,
        backgroundColor: widget.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: theme.colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.arrow_back_ios_new,color: widget.backButtonColor,),
                //  icon == null
                //     ? Center(
                //         child: SvgPicture.asset(svgIcon!),
                //       )
                //     : Icon(
                //         icon,
                //         size: 20,
                //         color: context.theme.colorScheme.black,
                //       ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: widget.style?.searchFieldPadding ?? const EdgeInsets.all(0),
                child: TextField(
                  style: widget.searchFieldStyle,
                  cursorColor: widget.style?.searchFieldCursorColor,
                  decoration: widget.style?.searchFieldInputDecoration ??
                      InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        labelText: widget.searchText,
                      ),
                  onChanged: (value) {
                    _filteredCountries = isNumeric(value)
                        ? widget.countryList
                            .where((country) => country.dialCode.contains(value))
                            .toList()
                        : widget.countryList
                            .where((country) => country.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                    if (mounted) setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: widget.backgroundColor,
        padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: ListView.separated(
          separatorBuilder: (context,index){
            return widget.style?.listTileDivider ?? Container(
              height: 1,
              color: widget.backButtonColor,
            );
          },
          shrinkWrap: true,
          itemCount: _filteredCountries.length,
          itemBuilder: (ctx, index) => Column(
            children: <Widget>[
              ListTile(
                
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                    package: 'custom_phone_input',
                    width: 45,
                  ),
                ),
                contentPadding: widget.style?.listTilePadding,
                title: Text(
                  _filteredCountries[index].name,
                  style: widget.style?.countryNameStyle ??
                      const TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: Text(
                  '+${_filteredCountries[index].dialCode}',
                  style: widget.style?.countryCodeStyle ??
                      const TextStyle(fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  _selectedCountry = _filteredCountries[index];
                  widget.onCountryChanged(_selectedCountry);
                  Navigator.of(context).pop();
                },
              ),
              //widget.style?.listTileDivider ?? Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
