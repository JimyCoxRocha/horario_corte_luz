import 'package:flutter/material.dart';
import 'package:horario_corte_luz/presentation/core/theme/AppColors.dart';

class AddSectorCard extends StatelessWidget {
  const AddSectorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
        color: AppColors().interactableColor,
        child: const SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 70,
                  )),
              Text(
                'Añadir Sector',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 15)
            ],
          ),
        ),
      ),
    );
  }
}
