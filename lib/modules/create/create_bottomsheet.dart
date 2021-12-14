import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:meuapp/modules/create/create_controller.dart';
import 'package:meuapp/modules/create/repositories/create_repository_impl.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:meuapp/shared/widgets/button/button.dart';
import 'package:meuapp/shared/widgets/input_text/input_text.dart';

class CreateBottomSheet extends StatefulWidget {
  const CreateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  late final CreateController controller;

  @override
  void initState() {
    controller = CreateController(
        repository: CreateRepositoryImpl(database: AppDatabase.instance));
    controller.addListener(() {
      controller.state.when(
          success: (_) {
            Navigator.pop(context);
          },
          orElse: () {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              InputText(
                label: "Produto",
                hint: "Digite um nome",
                onChanged: (value) => controller.onChange(name: value),
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value.isNotEmpty ? null : "Favor digitar o nome",
              ),
              SizedBox(
                height: 4,
              ),
              InputText(
                label: "Preço",
                hint: "Digite o valor",
                onChanged: (value) => controller.onChange(price: value),
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
                height: 4,
              ),
              InputText(
                  label: "Data da compra",
                  hint: "Digite mm/dd/aaaa",
                  onChanged: (value) => controller.onChange(date: value),
                  keyboardType: TextInputType.datetime,
                  validator: (value) => value.isNotEmpty
                      ? null
                      : "Favor digitar a data da compra",
                  inputFormatters: [MaskedInputFormatter('00/00/0000')]),
              SizedBox(
                height: 2,
              ),
              AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => controller.state.when(
                        loading: () => CircularProgressIndicator(),
                        error: (message, _) => Text(message),
                        orElse: () => Button(
                            label: "Adicionar",
                            onTap: () {
                              controller.create();
                            }),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
