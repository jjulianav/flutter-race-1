import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:meuapp/modules/create/create_controller.dart';
import 'package:meuapp/shared/widgets/button/button.dart';
import 'package:meuapp/shared/widgets/input_text/input_text.dart';

class CreateBottomSheet extends StatefulWidget {
  const CreateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  final controller = CreateController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            InputText(
              label: "Produto",
              hint: "Digite um nome",
              keyboardType: TextInputType.text,
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar o nome",
            ),
            SizedBox(
              height: 8,
            ),
            InputText(
              label: "Preço",
              hint: "Digite o valor",
              keyboardType: TextInputType.number,
              inputFormatters: [
                MoneyInputFormatter(
                  leadingSymbol: "R\$",
                )
              ],
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar o preço",
            ),
            SizedBox(
              height: 8,
            ),
            InputText(
                label: "Data da compra",
                hint: "Digite dd/mm/aaaa",
                keyboardType: TextInputType.datetime,
                validator: (value) =>
                    value.isNotEmpty ? null : "Favor digitar a data da compra",
                inputFormatters: [MaskedInputFormatter('00/00/00')]),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 20,
            ),
            Button(
                label: "Adicionar",
                onTap: () {
                  controller.create();
                })
          ],
        ),
      ),
    );
  }
}
