import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBUtil {
  static init() async {
    final Database database = await openDatabase(
        join(await getDatabasesPath(), 'node8.db'), onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE NODE2(id INTEGER, name TEXT, question TEXT,image TEXT,pid INTEGER,description TEXT,viewCount INTEGER);",
      );
    }, version: 1);

    final List<Map<String, dynamic>> list = await database.query('NODE2',
        where: null, offset: 0, orderBy: null, limit: 100);
    if (list.length == 0) {
      // init node data
      await DBUtil.insertNode({
        "id": 1,
        "name": "",
        "pid": 0,
        "question": "The plot is about the Great Wall",
        "description":
            "The Great Wall is a great project of ancient China and is one of the most famous and magnificent fortifications in the world. Here are some introductions to the Great Wall:Historical Background",
        "viewCount": 100,
        "image":
            "https://bkimg.cdn.bcebos.com/pic/d043ad4bd11373f0cf7dcfa8a80f4bfbfbed0442",
      }, database);
      await DBUtil.insertNode({
        "id": 2,
        "name": "Learn about history",
        "question": "The Great Wall has a long, long history.",
        "description":
            "Warring States Period (476 BC - 221 BC): During the Warring States Period, China was divided into seven countries that faced each other. In order to defend themselves against nomadic peoples from the north, the countries began to build border fortifications, which can be considered as the prototype of the Great Wall. Among them, the state of Qin had already carried out some construction works during this period.",
        "pid": 1,
        "viewCount": 200,
        "image":
            "https://img2.baidu.com/it/u=3804823432,4264436706&fm=253&fmt=auto&app=138&f=JPG?w=500&h=539",
      }, database);

      await DBUtil.insertNode({
        "id": 4,
        "name": " Qin Dynasty？",
        "question":
            "The Great Wall has been under construction since the first Qin Emperor.",
        "description":
            "After Qin Shi Huang unified the six kingdoms, he ordered that the various border fortifications be connected to form a Great Wall thousands of miles long in order to strengthen the northern defenses. This version of the Great Wall was constructed of masonry and stone and was mainly used to keep out the Xiongnu nomads in the north.",
        "pid": 2,
        "viewCount": 1200,
        "image":
            "https://img0.baidu.com/it/u=1125355073,315159827&fm=253&fmt=auto&app=138&f=JPEG?w=785&h=500",
      }, database);

      await DBUtil.insertNode({
        "id": 5,
        "name": " When did it start?",
        "question":
            "The Great Wall has been under construction since the first Qin Emperor.",
        "description":
            "The history of the Great Wall dates back to ancient China and has undergone a long process of development.",
        "pid": 2,
        "viewCount": 900,
        "image":
            "https://img0.baidu.com/it/u=1125355073,315159827&fm=253&fmt=auto&app=138&f=JPEG?w=785&h=500",
      }, database);

      await DBUtil.insertNode({
        "id": 3,
        "name": "Travel Tips",
        "question": "The Great Wall is a lot of fun.",
        "pid": 1,
        "description":
            "The Great Wall is one of the most famous tourist destinations in China, attracting thousands of visitors to enjoy its magnificent scenery and deep history and culture",
        "viewCount": 300,
        "image":
            "https://img0.baidu.com/it/u=1125355073,315159827&fm=253&fmt=auto&app=138&f=JPEG?w=785&h=500",
      }, database);

      await DBUtil.insertNode({
        "id": 6,
        "name": " where are you going?",
        "question": "Beijing",
        "pid": 3,
        "description":
            "Beijing is the capital of China and one of the largest cities in China, with a long history and rich cultural heritage. With a history of more than 3,000 years, Beijing was one of the capitals during the Six Dynasties of ancient China. During the Yuan, Ming and Qing dynasties, Beijing became the imperial capital of China, leaving behind many magnificent royal buildings and cultural heritage.",
        "viewCount": 1200,
        "image":
            "https://img0.baidu.com/it/u=1125355073,315159827&fm=253&fmt=auto&app=138&f=JPEG?w=785&h=500",
      }, database);

      await DBUtil.insertNode({
        "id": 7,
        "name": " When do we go?",
        "question": "It's best to go in the spring.",
        "description":
            "Spring is a vibrant and beautiful time of year, and there are many benefits to choosing to travel in the spring:Pleasant Weather: With moderate temperatures, clear skies and sunny days, spring is an ideal time for outdoor activities and adventures. Compared to the heat of summer and the cold of winter, spring weather is much more pleasant and enjoyable.",
        "pid": 3,
        "viewCount": 900,
        "image":
            "https://img0.baidu.com/it/u=1125355073,315159827&fm=253&fmt=auto&app=138&f=JPEG?w=785&h=500",
      }, database);
    }

    return database;
  }

  static Future<void> insertNode(Map<String, Object> map, Database db) async {
    // Get a reference to the database.

    // Insert the Node into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'NODE2',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map>> search() async {
    // Get a reference to the database.
    final Database db = await init();
    final List<Map<String, dynamic>> maps = await db.query('NODE2',
        where: null, offset: 0, orderBy: null, limit: 100);

    return List.generate(maps.length, (i) {
      var m = maps[i];
      return {
        "id": m["id"],
        "name": m["name"],
        "pid": m["pid"],
        "question": m["question"],
        "image": m["image"],
        "description": m["description"],
        "viewCount": m["viewCount"],
      };
    });
  }
}
