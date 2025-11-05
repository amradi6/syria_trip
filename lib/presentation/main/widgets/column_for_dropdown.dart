import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syri_trip/logic/main/main_cubit.dart';

class ColumnForDropdown extends StatelessWidget {
  const ColumnForDropdown({
    super.key,
    required this.labelText,
    required this.text,
    required this.isFrom,
  });

  final String text;

  final String labelText;

  final bool isFrom;

  static const List<String> cites = [
    "دمشق",
    "حلب",
    "حمص",
    "حماة",
    "اللاذقية",
    "طرطوس",
    "إدلب",
    "درعا",
    "السويداء",
    "دير الزور",
    "الرقة",
    "الحسكة",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<MainCubit>();
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        String? selectedValue = isFrom ? cubit.from : cubit.to;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.0243),
              child: Text(
                text,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(height: size.height * 0.012),
            DropdownButtonFormField2(
              value: selectedValue.isEmpty ? null : selectedValue,
              items: cites.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                prefixIcon: Icon(Icons.location_city),
              ),
              selectedItemBuilder: (context) {
                return cites.map((e) {
                  return Text(
                    e,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  );
                }).toList();
              },
              onChanged: (value) {
                if (value != null) {
                  if (isFrom) {
                    cubit.setFrom(value);
                  } else {
                    cubit.setTo(value);
                  }
                }
              },
              dropdownStyleData: DropdownStyleData(
                maxHeight: size.height * 0.32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              isExpanded: true,
            ),
          ],
        );
      },
    );
  }
}
