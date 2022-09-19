import 'package:canteenplan/cubit/canteen_search_cubit.dart';
import 'package:canteenplan/models/canteen.dart';
import 'package:canteenplan/models/canteen_search_result.dart';
import 'package:canteenplan/view/dialog_add_canteen/color_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/canteen_color.dart';

class AddCanteenDialog extends StatefulWidget {
  const AddCanteenDialog({super.key});

  @override
  State<AddCanteenDialog> createState() => _AddCanteenDialogState();
}

class _AddCanteenDialogState extends State<AddCanteenDialog> {
  TextEditingController nameController = TextEditingController();
  String canteenName = '';
  CanteenColor canteenColor = CanteenColor.pink;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CanteenSearchCubit>(context).getCanteens();

    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            margin: const EdgeInsets.all(16),
            child: BlocBuilder<CanteenSearchCubit, CanteenSearchState>(
                builder: (context, state) {
              List<Widget> widgets = [];

              widgets.add(Text(
                "Mensa hinzufügen",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ));

              if (state is CanteenSearchInitial) {
                widgets.add(const CircularProgressIndicator());
              } else {
                final canteens = (state as CanteenSearchResultsLoaded).canteens;

                widgets.addAll(_buildDialogContent(canteens));
              }

              return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widgets
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: e,
                        ),
                      )
                      .toList());
            })));
  }

  List<Widget> _buildDialogContent(List<CanteenSearchResult> canteens) {
    return [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Name oder Stadt suchen",
            style: Theme.of(context).textTheme.subtitle1,
          )),
      Autocomplete(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.length < 2) {
              return const Iterable<String>.empty();
            } else {
              List<String> matches = <String>[];
              matches.addAll(canteens.map((e) => e.name));

              matches.retainWhere((s) {
                return s
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
              return matches;
            }
          },
          onSelected: (String option) => setState(() {
                canteenName = option;
              })),
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Farbe auswählen",
            style: Theme.of(context).textTheme.subtitle1,
          )),
      ColorSelection(
        selectedColor: canteenColor,
        onColorClick: (CanteenColor newColor) {
          setState(() {
            canteenColor = newColor;
          });
        },
      ),
      Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Abbrechen")),
              TextButton(
                  onPressed: canteenName.isEmpty
                      ? null
                      : () {
                          final canteenResult = canteens.where((s) {
                            return s.name
                                .toLowerCase()
                                .contains(canteenName.toLowerCase());
                          }).first;
                          BlocProvider.of<CanteenSearchCubit>(context)
                              .addNewCanteen(Canteen(
                                  canteenResult.id,
                                  canteenResult.name,
                                  canteenColor.value,
                                  true));
                          Navigator.of(context).pop();
                        },
                  child: const Text("Hinzufügen"))
            ],
          ))
    ];
  }
}
