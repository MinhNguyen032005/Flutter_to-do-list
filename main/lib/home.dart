import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  String _dropdownvalue = "Monday";
  String _day = DateTime.now().day.toString();
  String _month = DateFormat.MMMM().format(DateTime.now());
  int _quantityTask = 0;
  int _timeADay = 0;
  String _dayString = DateFormat.EEEE('en').format(DateTime.now()); // ➜ "Mon"
  final yesterday = DateTime.now().add(const Duration(days: 1));
  String get _yesterday => DateFormat.EEEE().format(yesterday);
  String _titleTask = "";
  String _timeTask = "";
  bool isChecked = false;
  bool isDisabled = false;

  get tasks => null;
  void _showCompletedDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Thông báo"),
            content: const Text("Công việc đã hoàn thành!"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }

  void _showAddNewTaskDialog() {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Thêm công việc mới"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Tên công việc"),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: "Thời gian"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                String title = _titleController.text.trim();
                String time = _timeController.text.trim();

                if (title.isNotEmpty && time.isNotEmpty) {
                  setState(() {
                    tasks.add({'title': title, 'time': time});
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Thêm"),
            ),
          ],
        );
      },
    );
  }

  void _handleCheckboxChange(bool? value) {
    if (value == true) {
      setState(() {
        isChecked = true;
        isDisabled = true;
      });
      _showCompletedDialog();
    }
  }

  void dropdownCallback(String? value) {
    if (value is String) {
      setState(() {
        _dropdownvalue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 15, 0),
            color: Colors.indigoAccent,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  // tooltip: 'Menu',
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: () {}, // hoặc gán hàm xử lý
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 55, 0),
                    child: Center(
                      child: Text(
                        _day + " " + _month,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: Colors.indigoAccent,
                  height: 140,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 20, 0, 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(117, 20, 30, 10),
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              child: Text(
                                'Add New',
                                style: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: _showAddNewTaskDialog,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text(
                          ("$_quantityTask tasks"),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 120, // Đè lên 20px
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 10,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding:
                                    EdgeInsets.zero, // Xoá padding mặc định
                                backgroundColor:
                                    Colors.transparent, // Nút trong suốt
                                shadowColor:
                                    Colors.transparent, // Không đổ bóng
                                elevation: 0, // Không nâng lên
                                surfaceTintColor: Colors.transparent,
                              ).copyWith(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.indigo.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _day,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      _dayString.substring(0, 3), // ví dụ "May"
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                _timeADay.toString() + ' hour a day',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding:
                                    EdgeInsets.zero, // Xoá padding mặc định
                                backgroundColor:
                                    Colors.transparent, // Nút trong suốt
                                shadowColor:
                                    Colors.transparent, // Không đổ bóng
                                elevation: 0, // Không nâng lên
                                surfaceTintColor: Colors.transparent,
                              ).copyWith(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      yesterday.day.toString(),
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      _yesterday.substring(0, 3), // ví dụ "May"
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics:
                              NeverScrollableScrollPhysics(), // nếu bạn muốn nó vừa khít
                          children: [buildTaskCard('hoc', 'taskTime')],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTaskCard(String taskTitle, String taskTime) {
    bool isChecked = false;
    bool isDisabled = false;

    void handleCheckboxChange(bool? value) {
      if (value == true) {
        isChecked = true;
        isDisabled = true;
        // Gọi lại UI
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text("Thông báo"),
                content: const Text("Công việc đã hoàn thành!"),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      }
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, // Xoá padding mặc định
            backgroundColor: Colors.transparent, // Nút trong suốt
            shadowColor: Colors.transparent, // Không đổ bóng
            elevation: 0, // Không nâng lên
            surfaceTintColor: Colors.transparent,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(taskTime, style: const TextStyle(fontSize: 16)),
                      Checkbox(
                        value: isChecked,
                        onChanged:
                            isDisabled
                                ? null
                                : (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                    if (isChecked) {
                                      isDisabled = true;
                                      handleCheckboxChange(value);
                                    }
                                  });
                                },
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      taskTitle,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
