// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:yaml/yaml.dart';
import 'dart:math';

class Person {
    final String name;
    final int birthYear;
    late final int randomNumber;

    Person(this.name, this.birthYear) {
        randomNumber = _generateRandomNumber();
    }

    int _generateRandomNumber() {
        final random = Random();
        return random.nextInt(63072000); // 生成 0 到 63072000 之间的随机数
    }

    @override
    String toString() {
        return 'Person(name: $name, birthYear: $birthYear, randomNumber: $randomNumber)';
    }
}

late Person person;

void main() {
    final file = File('config.yaml');

    // 如果文件不存在，则创建并初始化配置
    if (!file.existsSync()) {
        // K_24814 配置去掉月份信息，尽量减少隐私信息的泄露
        const config_str = '''
apiKey: your-api-key
username: your-username
birth_year: 1989
randomseed_sec: 4929394
    ''';

        file.writeAsStringSync(config_str);
        print('配置已初始化！');
    }

    // 读取配置文件
    final contents = file.readAsStringSync();
    final config = loadYaml(contents);

    // 使用配置信息
    print('API Key: ${config['apiKey']}');
    print('Username: ${config['username']}');
    print('birth_year: ${config['birth_year']}');
    print('randomseed_sec: ${config['randomseed_sec']}');

    final random = Random();
    int randomInt = random.nextInt(63072001);
    // 修改 randomseed_sec 的值
    config['randomseed_sec'] = randomInt; // 这里设置为你想要的新值

    person = Person(config['username'], config['birth_year']);
    print(person);

    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Countdown Timer',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: CountdownPage(),
        );
    }
}

class CountdownPage extends StatefulWidget {
    @override
    _CountdownPageState createState() => _CountdownPageState();
}

// K_23703 平均年龄数据来源~> https:/zh.wikipedia.org/wiki/中华人民共和国各省级行政区预期寿命列表
// K_23703 广西: 82.34(女)	74.31(男)  还要取一个 正负4年(365天*8的上下限,按秒随机)的随机数
class _CountdownPageState extends State<CountdownPage> {
    late Timer _timer;
    int _days = 10402;
    int _hours = 12;
    int _minutes = 0;
    int _seconds = 0;

    @override
    void initState() {
        super.initState();
        _days = 10402; // 设置初始小时数  1977.02.01   ...   2051.31   ...   28.5 =
        _hours = 12;
        startCountdown();
    }

    void startCountdown() {
        const oneSec = Duration(seconds: 1);
        _timer = Timer.periodic(
            oneSec,
            (Timer timer) => setState(
                () {
                    if (_seconds > 0) {
                        _seconds--;
                    } else {
                        if (_minutes > 0) {
                            _minutes--;
                            _seconds = 59;
                        } else {
                            if (_hours > 0) {
                                _hours--;
                                _minutes = 59;
                                _seconds = 59;
                            } else {
                                if (_days > 0) {
                                    _days--;
                                    _hours = 23;
                                    _minutes = 59;
                                    _seconds = 59;
                                } else {
                                    _timer.cancel();
                                }
                            }
                        }
                    }
                },
            ),
        );
    }

    String getFormattedTime() {
        String days = _days.toString().padLeft(4, '0');
        String hours = _hours.toString().padLeft(2, '0');
        String minutes = _minutes.toString().padLeft(2, '0');
        String seconds = _seconds.toString().padLeft(2, '0');
        return '$days(天)\n$hours:$minutes:$seconds';
    }

    @override
    void dispose() {
        _timer.cancel();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('奇迹'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 64),
                            child: Text(
                                '${person.name}，你是独一无二的。你的所有特点，你所做的每一个选择定义了你，享受这个美丽的世界，像闪亮的流星划过星空。。。',
                                style: TextStyle(fontSize: 32),
                            ),
                        ),
                        SizedBox(height: 32),
                        Text(
                            getFormattedTime().split('\n')[0],
                            style: TextStyle(fontSize: 48),
                        ),
                        SizedBox(height: 16),
                        Text(
                            getFormattedTime().split('\n')[1],
                            style: TextStyle(fontSize: 48),
                        ),
                    ],
                ),
            ),
        );
    }
}
