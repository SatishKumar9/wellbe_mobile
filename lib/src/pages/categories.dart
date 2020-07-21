import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final Map categories = {
    'Brain': 'https://img.icons8.com/fluent/40/000000/brain.png',
    'Chest': 'https://img.icons8.com/officel/40/000000/chest.png',
    'Ear': 'https://img.icons8.com/emoji/40/000000/ear-emoji.png',
    'Eye': 'https://img.icons8.com/cute-clipart/40/000000/visible.png',
    // 'Face': 'https://img.icons8.com/ultraviolet/40/000000/shaven-face.png',
    'Hair': 'https://img.icons8.com/officel/40/000000/womans-hair.png',
    'Heart': 'https://img.icons8.com/color/48/000000/medical-heart.png',
    'Kidneys': 'https://img.icons8.com/color/40/000000/kidney.png',
    'Liver': 'https://img.icons8.com/color/40/000000/liver.png',
    'Lungs': 'https://img.icons8.com/fluent/40/000000/lungs.png',
    'Skin': 'https://img.icons8.com/color/40/000000/skin.png',
    'Spine': 'https://img.icons8.com/color/40/000000/spine.png',
    'Stomach': 'https://img.icons8.com/color/48/000000/stomach.png',
    'Teeth': 'https://img.icons8.com/fluent/40/000000/tooth.png'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 3,
              children: <Widget>[
                for (var category in categories.keys)
                  InkWell(
                    onTap: () {
                      print('Selected $category');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(blurRadius: 15, color: Colors.black12)
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(categories[category]),
                          SizedBox(height: 5),
                          Text(
                            category,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
