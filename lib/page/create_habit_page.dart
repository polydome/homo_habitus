import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateHabitPage extends StatelessWidget {
  CreateHabitPage({Key? key}) : super(key: key);

  final _goalOptionController = OptionController();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('New habit'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: const [
                      IconSelection(),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: SizedBox(
                            height: 32,
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration.collapsed(hintText: "Name"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FormSection("Goal",
                      child: Material(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.onBackground,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48,
                              child: OptionSelector(
                                controller: _goalOptionController,
                                options: [
                                  Option("Counter",
                                      leading: const Icon(
                                        Icons.tag,
                                        size: 16,
                                      )),
                                  Option("Timer",
                                      leading: const Icon(
                                        Icons.timer,
                                        size: 16,
                                      ))
                                ],
                              ),
                            ),
                            ValueListenableBuilder<int>(
                                valueListenable: _goalOptionController.selectedIndex,
                                builder: (context, value, child) =>
                                value == 0
                                    ? Text("30 times")
                                    : Text("for 30 minutes"))
                          ],
                        ),
                      )),
                  FormSection("Repetition",
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          height: 48,
                          child: OptionSelector(
                            options: [
                              Option("Daily"),
                              Option("Weekly"),
                              Option("Monthly")
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
}

class FormSection extends StatelessWidget {
  const FormSection(this.label, {Key? key, required this.child})
      : super(key: key);

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headline5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: child,
          ),
        ],
      ),
    );
  }
}

class OptionSelector extends StatelessWidget {
  OptionSelector(
      {Key? key, required this.options, OptionController? controller})
      : super(key: key) {
    _controller = controller ?? OptionController();
  }

  final List<Option> options;
  late final OptionController _controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onBackground,
      clipBehavior: Clip.hardEdge,
      child: ValueListenableBuilder(
        valueListenable: _controller.selectedIndex,
        builder: (context, selectedIndex, child) => Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: options
              .mapIndexed((option, index) => OptionView(
                    option,
                    selected: index == selectedIndex,
                    onTap: index != selectedIndex
                        ? () {
                            _controller.selectIndex(index);
                          }
                        : null,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class OptionController {
  final int initialIndex;
  final ValueNotifier<int> _selectedIndex;

  ValueListenable<int> get selectedIndex => _selectedIndex;

  void selectIndex(int value) {
    _selectedIndex.value = value;
  }

  OptionController({this.initialIndex = 0})
      : _selectedIndex = ValueNotifier(initialIndex);
}

class Option {
  final String label;
  final Icon? leading;

  Option(this.label, {this.leading});
}

class OptionView extends StatelessWidget {
  const OptionView(this.option, {Key? key, this.selected = false, this.onTap})
      : super(key: key);

  final Option option;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      color:
          selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: option.leading ?? const SizedBox.shrink(),
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                option.label,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class IconSelection extends StatelessWidget {
  const IconSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 64,
      child: Ink(
          decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              shape: const CircleBorder()),
          child: const FractionallySizedBox(
            heightFactor: 0.5,
            widthFactor: 0.5,
            child: Icon(Icons.extension),
          )),
    );
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E element, int index) toElement) {
    var index = 0;
    return map((item) => toElement(item, index++));
  }
}
