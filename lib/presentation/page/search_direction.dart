import 'package:flutter/material.dart';
import 'package:horario_corte_luz/architecture/dtos/ErrorResponse.dart';
import 'package:horario_corte_luz/domain/entities/AddressSearch.dart';
import 'package:horario_corte_luz/domain/usecase/AddressesUseCase.dart';
import 'package:horario_corte_luz/presentation/widget/debouncer_widget.dart';
import 'package:horario_corte_luz/presentation/widget/input_form.dart';
import 'package:horario_corte_luz/presentation/widget/toast_widget.dart';

class SearchDirection extends StatefulWidget {
  SearchDirection({super.key, required this.onComplete});

  VoidCallback onComplete;
  @override
  State<SearchDirection> createState() => _SearchDirectionState();
}

const List<String> citiesList = <String>['Guayaquil', 'Quito'];

class _SearchDirectionState extends State<SearchDirection> {
  final debouncer = Debouncer(milliseconds: 500);

  String citySelected = citiesList[0];
  String sectorValue = "";

  List<AddressSearch> responseList = [];

  void _searchAddresses(String localSectorValue) async {
    try {
      print(localSectorValue);
      List<AddressSearch> response = await AddressesUseCase()
          .getAddresses(city: citySelected, sector: localSectorValue);
      setState(() {
        responseList = response;
      });
    } on ErrorResponse catch (data) {
      print(data);
    }
  }

  @override
  void initState() {
    super.initState();
    _searchAddresses("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('')),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              InputForm(
                  text: 'Buscar dirección',
                  inputType: InputType.prayer,
                  prefixIcon: const Icon(Icons.search),
                  onValueChanged: (value) {
                    debouncer.run(() {
                      sectorValue = value.text;
                      _searchAddresses(value.text);
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text("Ciudad:")),
                  DropdownButtonExample(
                      citiesList: citiesList,
                      cityDefault: citySelected,
                      onChanged: (value) => setState(() {
                            _searchAddresses(sectorValue);

                            citySelected = value;
                          }))
                ],
              ),
              Expanded(
                  child: LocationsFound(
                responseList: responseList,
                onTapUbication: (value) => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => DialogConfigLocation(
                        locationData: value,
                        onAccept: () {
                          widget.onComplete();
                          Navigator.pop(context);
                        })),
              ))
            ],
          ),
        )));
  }
}

class DropdownButtonExample extends StatefulWidget {
  DropdownButtonExample(
      {super.key,
      required this.onChanged,
      required this.citiesList,
      required this.cityDefault});

  ValueChanged onChanged;
  List<String> citiesList;
  String cityDefault;

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.cityDefault;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      elevation: 16,
      underline: Container(height: 2),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        widget.onChanged(value);
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.citiesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class LocationsFound extends StatefulWidget {
  LocationsFound(
      {super.key, required this.onTapUbication, required this.responseList});

  final ValueChanged onTapUbication;
  List<AddressSearch> responseList;

  @override
  State<LocationsFound> createState() => _LocationsFoundState();
}

class _LocationsFoundState extends State<LocationsFound> {
  @override
  Widget build(BuildContext context) {
    final List<AddressSearch> entries = widget.responseList;
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(entries[index].sector),
            onTap: () {
              widget.onTapUbication(entries[index]);
              //Navigator.pop(context);
            },
          );
        });
  }
}

class DialogConfigLocation extends StatefulWidget {
  const DialogConfigLocation(
      {super.key, required this.locationData, required this.onAccept});

  final AddressSearch locationData;
  final VoidCallback onAccept;

  @override
  State<DialogConfigLocation> createState() => _DialogConfigLocationState();
}

class _DialogConfigLocationState extends State<DialogConfigLocation> {
  String valueChanged = "";

  Future<void> _saveAddresses(String valueChanged) async {
    try {
      bool response = await AddressesUseCase()
          .saveLocation(name: valueChanged, scheduleId: widget.locationData.id);

      widget.onAccept();
      Navigator.pop(context);
    } on ErrorResponse catch (data) {
      ToastWidget(context).toast(message: data.message);
      Navigator.pop(context);
      print(data);
    }
  }

  void onPressedData() async {
    print(valueChanged);
    if (valueChanged.isEmpty) {
      return;
    }

    await _saveAddresses(valueChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              "Escogiste la ubicación",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(widget.locationData.sector, style: TextStyle(fontSize: 15)),
            const SizedBox(height: 60),
            const Text(
              "Personalízala",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InputForm(
                  text: 'Ejem: Casa, Enamorada',
                  inputType: InputType.prayer,
                  onValueChanged: (value) {
                    setState(() {
                      print(value.text);
                      valueChanged = value.text;
                    });
                  }),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: onPressedData,
                  child: const Text('Guardar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
