import 'package:flutter/material.dart';

class WidgetTextInput extends StatefulWidget {
  WidgetTextInput(this.onChanged);

  final Function(String) onChanged;

  @override
  State<WidgetTextInput> createState() => _WidgetTextInputState();
}

class _WidgetTextInputState extends State<WidgetTextInput> {
  String username = '';
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {
      FocusScope.of(context).unfocus();
      widget.onChanged(controller.text);
      username = controller.text;
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onSubmitted: (value) => _onChanged(),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(),
          labelText: 'Username',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _onChanged,
          ),
        ));
  }
}
