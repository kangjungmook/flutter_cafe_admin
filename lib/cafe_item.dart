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
  dynamic body = const Text('Loding...');

  Future<void> getCategory() async {
    setState(() {
      var datas = myCafe.get(collectionName: categoryName);
      body = FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            var datas = snapshot.data?.docs;
            if (datas == null) {
              return const Center(
                child: Text('empty'),
              );
            } else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  var data = datas[index];
                  return ListTile(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CafeItemList(id: data.id),
                        ),
                      );
                    },
                    title: Text(data['categoryName']),
                    trailing: PopupMenuButton(
                      onSelected: (value) async {
                        switch (value) {
                          case 'modify':
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CafeCategoryAddForm(id: data.id),
                              ),
                            );
                            if (result == true) {
                              getCategory();
                            }
                            break;
                          case 'delete':
                            var result = await myCafe.delete(
                                collectionName: categoryName, id: data.id);

                            if (result == true) {
                              getCategory();
                            }
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'modify',
                          child: Text('수정'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('삭제'),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: datas.length,
              );
            }
          } else {
            const Text('불러오는 중');
          }
          return const Center(
            child: Text('결과'),
          );
        },
        future: datas,
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CafeCategoryAddForm(
                  id: null,
                ),
              ));

          if (result == true) {
            getCategory();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CafeCategoryAddForm extends StatefulWidget {
  String? id;
  CafeCategoryAddForm({super.key, required this.id});

  @override
  State<CafeCategoryAddForm> createState() => _CafeCategoryAddFormState();
}

class _CafeCategoryAddFormState extends State<CafeCategoryAddForm> {
  TextEditingController controller = TextEditingController();
  String? id;
  var isUsed = true;

  Future<void> getData({required String id}) async {
    var data = await myCafe.get(
      collectionName: categoryName,
      id: id,
    );

    // data['categoryName']
    // data['isUsed']

    setState(() {
      controller.text = data['categoryName'];
      isUsed = data['isUsed'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    if (id != null) {
      getData(id: id!);
    }
  }

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
                  print(id);

                  var result = id != null
                      ? await myCafe.update(
                          collectionName: categoryName, id: id!, data: data)
                      : await myCafe.insert(
                          collectionName: categoryName, data: data);
                  if (result == true) {
                    Navigator.pop(context, true);
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

class CafeItemList extends StatefulWidget {
  String id;
  CafeItemList({super.key, required this.id});

  @override
  State<CafeItemList> createState() => _CafeItemListState();
}

class _CafeItemListState extends State<CafeItemList> {
  late String id;
  dynamic dropdownMenu = const Text('loading..');
  dynamic itemList = const Text('itemList');

  @override
  void initState() {
    super.initState();
    id = widget.id;
    getCategory(id);
  }

  Future<void> getCategory(String id) async {
    var datas = MyCage().get(collectionName: categoryName);
    List<DropdownMenuEntry> entries = [];
    setState(() {
      dropdownMenu = FutureBuilder(
        future: datas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var datas = snapshot.data.docs;
            for (var data in datas) {
              entries.add(DropdownMenuEntry(
                  value: data.id, label: data['categoryName']));
            }
            return DropdownMenu(
              dropdownMenuEntries: entries,
              initialSelection: id,
              onSelected: (value) {
                print('$value item list');
              },
            );
          }
          return const Text('loding');
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('item list'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CafeItemAddForm(
                      categoryid: id,
                      itemId: null,
                    ),
                  ));
            },
            child: const Text('+item'),
          )
        ],
      ),
      body: Column(
        children: [
          dropdownMenu,
          const Text('list'),
        ],
      ),
    );
  }
}

class CafeItemAddForm extends StatefulWidget {
  String categoryid;
  String? itemId;
  CafeItemAddForm({super.key, required this.categoryid, this.itemId});

  @override
  State<CafeItemAddForm> createState() => _CafeItemAddFormState();
}

class _CafeItemAddFormState extends State<CafeItemAddForm> {
  late String categoryid;
  String? itemId;

  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  bool isSoldOut = false;

  @override
  void initState() {
    super.initState();
    categoryid = widget.categoryid;
    itemId = widget.itemId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('item add form'),
        actions: [
          TextButton(
            onPressed: () async {
              var data = {
                'itemName': controllerTitle.text,
                'itemPrice': int.parse(controllerPrice.text),
                'itemDesc': controllerDesc.text,
                'itemIsSoldOut': isSoldOut
              };
              var result = await myCafe.insert(
                  collectionName: itemCollectionNamee, data: data);
              if (result == true) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Save'),
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('이름')),
            controller: controllerTitle,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('가격')),
            controller: controllerPrice,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('설명')),
            controller: controllerDesc,
          ),
          SwitchListTile(
            value: isSoldOut,
            onChanged: (value) {
              setState(() {
                isSoldOut = value;
              });
            },
            title: const Text('sold out?'),
          )
        ],
      ),
    );
  }
}
