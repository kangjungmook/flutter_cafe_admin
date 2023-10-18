import 'package:flutter/material.dart';
import 'package:flutter_cafe_admin/my_cafe.dart';

MyCage myCafe = MyCage();
String categoryName = 'cafe-category';
String itemCollectionNamee = 'cafe-item';

class CafeItem extends StatefulWidget {
  const CafeItem({super.key});

  @override
  State<CafeItem> createState() => _CafeItemState();
}

class _CafeItemState extends State<CafeItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('hi'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CafeCategoryAddForm(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CafeCategoryAddForm extends StatefulWidget {
  const CafeCategoryAddForm({super.key});

  @override
  State<CafeCategoryAddForm> createState() => _CafeCategoryAddFormState();
}

class _CafeCategoryAddFormState extends State<CafeCategoryAddForm> {
  TextEditingController controller = TextEditingController();

  var isUsed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('category add'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  var data = {
                    'categoryName': controller.text,
                    'isUsed': isUsed
                  };
                  var result = await myCafe.insert(
                      collectionName: categoryName, data: data);
                  print(result);
                  if (result == true) {
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text(
                'save',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('category name'),
                border: OutlineInputBorder(),
              ),
              controller: controller,
            ),
            SwitchListTile(
                title: const Text('used?'),
                value: isUsed,
                onChanged: (value) {
                  setState(() {
                    isUsed = value;
                  });
                })
          ],
        ));
  }
}
