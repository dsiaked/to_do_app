import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int count1 = 0;
int count2 = 0;

// 1. 할 일 데이터의 구조를 정의하는 모델 클래스
class TodoItem {
  String task;
  bool isDone;

  TodoItem({required this.task, this.isDone = false});
}

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  // List<String> -> List<TodoItem> 으로 데이터 구조 변경
  final List<TodoItem> _todoList = [];
  final TextEditingController _controller = TextEditingController();

  // 할 일을 리스트에 추가하는 함수
  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        // 문자열이 아닌 TodoItem 객체를 리스트에 추가
        _todoList.add(TodoItem(task: task));
        count2++;
      });
      _controller.clear();
      Navigator.of(context).pop();
    }
  }

  // 2. 체크박스를 눌렀을 때 isDone 상태를 변경하는 함수
  void _toggleDone(int index) {
    setState(() {
      _todoList[index].isDone = !_todoList[index].isDone;
    });
  }

  // 3. 삭제 버튼을 눌렀을 때 해당 아이템을 리스트에서 제거하는 함수
  void _deleteTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
      count1++;
      count2--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 4. AppBar의 뒤로가기 화살표 자동 생성 방지
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 10.0),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.check_circle_rounded),
            ),
            SizedBox(width: 10.0),
            Text(
              'To do List',
              style: GoogleFonts.gothicA1(fontSize: 20.0, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _todoList.length,
            itemBuilder: (context, index) {
              // 현재 아이템 가져오기
              final todoItem = _todoList[index];

              // 5. ListTile을 사용해 UI 구성
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: ListTile(
                  // 5-1. 왼쪽: 체크박스
                  leading: Checkbox(
                    value: todoItem.isDone,
                    onChanged: (bool? value) {
                      _toggleDone(index);
                    },
                  ),
                  // 5-2. 가운데: 할 일 텍스트 (완료 시 취소선)
                  title: Text(
                    todoItem.task,
                    style: GoogleFonts.gothicA1(
                      fontSize: 16,
                      // isDone 상태에 따라 텍스트 스타일 변경
                      decoration: todoItem.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: todoItem.isDone ? Colors.grey : Colors.black,
                    ),
                  ),
                  // 5-3. 오른쪽: 삭제 버튼
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      _deleteTodoItem(index);
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 40.0,
            right: 30.0,
            child: SizedBox(
              height: 80.0,
              width: 80.0,
              child: Tooltip(
                message: '새로운 할 일을 추가합니다.',
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                textStyle: GoogleFonts.dmSerifDisplay(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                preferBelow: false,
                child: FloatingActionButton(
                  onPressed: () {
                    // 팝업을 띄울 때 컨트롤러와 추가 함수를 전달합니다.
                    showPopup(context, _controller, _addTodoItem);
                  },
                  shape: const CircleBorder(),
                  elevation: 12.0,
                  hoverColor: Colors.blue,
                  splashColor: Colors.blue.withValues(alpha: 0.8),
                  child: const Icon(Icons.add, size: 30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showPopup(
  BuildContext context,
  TextEditingController controller,
  Function(String) onAdd,
) {
  showDialog(
    context: context,
    builder: (context) {
      // 1. StatefulBuilder로 Dialog의 자식 위젯을 감쌉니다.
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter dialogSetState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: controller,
                autofocus: true, // 팝업이 뜨면 바로 키보드가 올라오게 설정
                decoration: InputDecoration(
                  hintText: '여기에 새 작업을 입력하세요',
                  hintStyle: GoogleFonts.gothicA1(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    // 4. 컨트롤러의 텍스트가 비어있는지에 따라 색상을 결정합니다.
                    color: controller.text.isNotEmpty
                        ? Colors.blue
                        : Colors.grey,
                    icon: const Icon(Icons.check_circle),
                    // 5. 텍스트가 비어있으면 버튼을 비활성화(onPressed: null)합니다.
                    onPressed: controller.text.isNotEmpty
                        ? () {
                            onAdd(controller.text);
                          }
                        : null,
                  ),
                ),
                cursorColor: Colors.blue,
                onSubmitted: (task) {
                  // 엔터 키를 눌렀을 때도 내용이 있어야만 추가되도록 수정
                  if (task.isNotEmpty) {
                    onAdd(task);
                  }
                },
                // 2. 글자가 변경될 때마다 호출되는 onChanged 콜백
                onChanged: (text) {
                  // 3. dialogSetState를 호출하여 팝업창의 UI만 새로고침합니다.
                  dialogSetState(() {});
                },
              ),
            ),
          );
        },
      );
    },
  );
}
