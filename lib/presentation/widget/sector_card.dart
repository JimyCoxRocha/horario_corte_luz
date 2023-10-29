import 'package:flutter/material.dart';
import 'package:horario_corte_luz/presentation/core/theme/AppColors.dart';

class SectorCard extends StatelessWidget {
  final String title;
  final String horario;
  final String actualizado;

  const SectorCard(
      {super.key,
      required this.title,
      required this.horario,
      required this.actualizado});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Colors.blue[100]!,
            )),
        elevation: 0,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  )),
              const SizedBox(height: 15),
              Column(
                children: [
                  const Text(
                    'Horario',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    horario,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  const Text(
                    'Fecha',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    actualizado,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filledTonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors().interactableColor),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.update_rounded),
                      color: Colors.blue),
                  IconButton.filledTonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors().interactableColor),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.picture_as_pdf),
                      color: Colors.blue),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
