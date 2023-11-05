import 'package:flutter/material.dart';
import 'package:horario_corte_luz/presentation/entities/InputFormValidator.dart';

class InputForm extends StatefulWidget {
  final bool hiddenText;
  final int? maxLength;
  final String text;
  final int? minLength;
  final InputType inputType;
  final Widget? prefixIcon;
  const InputForm(
      {super.key,
      required this.text,
      this.hiddenText = false,
      required this.inputType,
      this.maxLength,
      this.minLength,
      this.prefixIcon,
      required this.onValueChanged});

  final void Function(InputFormValidator) onValueChanged;
  @override
  State<InputForm> createState() => _InputFormState();
}

enum InputType { email, password, onlyText, onlyTextWithoutSpace, prayer }

class _InputFormState extends State<InputForm> {
  bool hasError = false;
  final myText = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myText.dispose();
    super.dispose();
  }

  void removeSpace() {
    myText.text = myText.text.replaceAll(" ", "");
  }

  bool _validateInput() {
    if (widget.inputType == InputType.email &&
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(myText.text)) {
      return true;
    }
    if (widget.inputType == InputType.password &&
        !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(myText.text)) {
      return true;
    }
    if (widget.inputType == InputType.onlyText &&
        !RegExp(r'^[a-zA-Z]+$').hasMatch(myText.text)) {
      return true;
    }
    if (widget.inputType == InputType.onlyTextWithoutSpace &&
        !RegExp(r'^[a-zA-Z]+$').hasMatch(myText.text)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myText,
      onChanged: (inputValue) {
        if (widget.inputType == InputType.email ||
            widget.inputType == InputType.password ||
            widget.inputType == InputType.onlyTextWithoutSpace) {
          removeSpace();
        }
        //print(myText.text);
        widget.onValueChanged(InputFormValidator(
            text: myText.text, isValidData: !_validateInput()));
      },
      onTapOutside: (_) {
        if (myText.text.isEmpty) return;
        setState(() {
          setValidator(_validateInput());
        });
      },
      maxLength: widget.maxLength,
      obscureText: widget.hiddenText,
      decoration: InputDecoration(
              errorText: hasError ? 'Ingrese correctamente los datos' : null,
              errorStyle: const TextStyle(color: Colors.red),
              border: const OutlineInputBorder().copyWith(
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              labelText: widget.text,
              prefixIcon: widget.prefixIcon)
          .copyWith(),
    );
  }

  void setValidator(valid) {
    setState(() {
      hasError = valid;
    });
  }
}
