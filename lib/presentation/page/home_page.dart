import 'package:flutter/material.dart';
import 'package:horario_corte_luz/architecture/dtos/ErrorResponse.dart';
import 'package:horario_corte_luz/domain/entities/AddressSearch.dart';
import 'package:horario_corte_luz/domain/usecase/AddressesUseCase.dart';
import 'package:horario_corte_luz/presentation/widget/add_sector_card.dart';
import 'package:horario_corte_luz/presentation/widget/sector_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AddressSearch> responseList = [];
  @override
  void initState() {
    super.initState();
    _searchAddresses();
  }

  void _searchAddresses() async {
    try {
      print("Eejecutado");
      List<AddressSearch> response =
          await AddressesUseCase().getUserAddresses();
      print(response);
      setState(() {
        responseList = response;
      });
    } on ErrorResponse catch (data) {
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 200) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Mis sectores"),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 1, right: 1),
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: itemWidth / itemHeight,
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    children: [
                      if (responseList.isNotEmpty)
                        ...responseList.map((e) => SectorCard(
                            onRefresh: () {
                              setState(() {
                                _searchAddresses();
                              });
                            },
                            title: e.sector,
                            horario: e.schedule,
                            actualizado: e.lastUpdate)),
                      AddSectorCard(onComplete: () {
                        setState(() {
                          _searchAddresses();
                        });
                      })
                    ]))));
  }
}
