import 'package:flutter/material.dart';
import 'package:horario_corte_luz/presentation/widget/add_sector_card.dart';
import 'package:horario_corte_luz/presentation/widget/sector_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
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
                      SectorCard(
                          title: "Mi Casa asdf asdf asdf asdf",
                          horario: "2-3 y 4-5",
                          actualizado: "22/22/2023"),
                      SectorCard(
                          title: "Oficina Gizlo",
                          horario: "2-3 y 4-5",
                          actualizado: "22/22/2023"),
                      SectorCard(
                          title: "Casa Helen",
                          horario: "2-3 y 4-5",
                          actualizado: "22/22/2023"),
                      AddSectorCard()
                    ]))));
  }
}
