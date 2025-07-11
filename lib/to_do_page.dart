import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'to_do_provider.dart';

// 1. 할 일 데이터의 구조를 정의하는 모델 클래스
class TodoItem {
  String task;
  bool isDone;

  TodoItem({required this.task, this.isDone = false});
}

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        // 4. AppBar의 뒤로가기 화살표 자동 생성 방지
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const SizedBox(width: 10.0),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.check_circle_rounded),
            ),
            const SizedBox(width: 10.0),
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
            itemCount: provider.todoList.length,
            itemBuilder: (context, index) {
              // 현재 아이템 가져오기
              final todoItem = provider.todoList[index];

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
                      provider.toggleDone(index);
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
                    ), // 조건 ? 값1 : 값2 <- 조건이 true 일 경우 값1이 , false 일 경우 값2가 된다. 즉 만약 true 이면 ? 뒤에 값이 decoration 으로 반환이 된다!
                  ),
                  // 5-3. 오른쪽: 삭제 버튼
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      provider.deleteTodoItem(index);
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
                    showPopup(context, controller, (task) {
                      provider.addTodoItem(task);
                    });
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
