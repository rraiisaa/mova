import 'package:flutter/material.dart';
import 'package:mova_app/utils/size_config.dart';

class PinForm extends StatefulWidget {
  const PinForm({super.key});

  @override
  State<PinForm> createState() => _PinFormState();
}

class _PinFormState extends State<PinForm> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField({String? value, FocusNode? focusNode}) {
    if (value!.length == 1) {
      focusNode?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    initSizeConfig(context);

    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white)
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                nextField(value: value, focusNode: pin2FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin2FocusNode,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white)
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                nextField(value: value, focusNode: pin3FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin3FocusNode,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white)
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                nextField(value: value, focusNode: pin4FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin4FocusNode,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white)
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                pin4FocusNode.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}