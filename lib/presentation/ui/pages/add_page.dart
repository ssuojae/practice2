import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/todo_item_model.dart';
import '../../cubit_viewmodel/todo_cubit.dart';
import '../widgets/bar/sliver_appbar.dart';
import '../widgets/button/add_button.dart';
import '../widgets/checkbox/empty_checkbox.dart';

class AddPage extends StatefulWidget {
  final PageController pageController;
  final ITodoCubit todoCubit;
  final VoidCallback onTaskAdded;

  const AddPage({super.key, required this.pageController, required this.todoCubit, required this.onTaskAdded});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final FocusNode _focusNode = FocusNode();
  bool _isKeyboardVisible = false;
  OverlayEntry? _overlayEntry;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    _titleController.addListener(() {
      setState(() {});
    });

    _noteController.addListener(() {
      setState(() {});
      _updateOverlay();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _titleController.dispose();
    _noteController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _isKeyboardVisible = true;
      });
      _showOverlay();
    } else {
      setState(() {
        _isKeyboardVisible = false;
      });
      _overlayEntry?.remove();
    }
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isKeyboardVisible = false;
    });
    _overlayEntry?.remove();
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
    }
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Text(
            '${_noteController.text.split('\n').length}/8 lines',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ),
    );
  }

  void _updateOverlay() {
    if (_isKeyboardVisible) {
      _overlayEntry?.remove();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  Future<void> _saveTask() async {
    String title = _titleController.text;
    String note = _noteController.text;

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty')),
      );
      return;
    }

    final newTask = TodoEntity(
      state: TodoEntityState.empty,
      title: title,
      description: note,
    );

    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 100));

    await widget.todoCubit.saveTodo(newTask);

    // 페이지 전환과 상태 변경
    widget.onTaskAdded();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              titleText: "Create",
              welcomeText: "Create Task",
              highlightText: " Task ",
              endText: "anything you want.",
            ),
            SliverPadding(
              padding: const EdgeInsets.all(30.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: EmptyCheckbox(),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Baseline(
                                baseline: 20.0,
                                baselineType: TextBaseline.alphabetic,
                                child: TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    hintText: "What's in your mind?",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                  ),
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                  cursorColor: Colors.lightBlue,
                                  cursorHeight: 20,
                                  maxLength: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(Icons.edit, color: Colors.grey),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Container(
                                height: 270,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: TextField(
                                        controller: _noteController,
                                        decoration: const InputDecoration(
                                          hintText: "Add a note...",
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                        ),
                                        style: const TextStyle(color: Colors.black, fontSize: 16),
                                        maxLines: 8,
                                        minLines: 1,
                                        cursorColor: Colors.lightBlue,
                                        keyboardType: TextInputType.multiline,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(700), // Optional: limit total characters
                                          LineLimitingTextInputFormatter(8),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Text(
                                        '${_noteController.text.split('\n').length}/8 lines',
                                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
            bottom: _isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 16.0,
          ),
          child: AddButton(
            onPressed: _saveTask,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class LineLimitingTextInputFormatter extends TextInputFormatter {
  final int maxLines;

  LineLimitingTextInputFormatter(this.maxLines);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.split('\n').length > maxLines) {
      return oldValue;
    }
    return newValue;
  }
}
