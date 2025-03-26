import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_super_parameters
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежитие №20',
      theme: ThemeData(
        primarySwatch: Colors.green, // Зелёная тема
      ),
      home: const HostelPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HostelPage extends StatefulWidget {
  // ignore: use_super_parameters
  const HostelPage({Key? key}) : super(key: key);

  @override
  State<HostelPage> createState() => _HostelPageState();
}

class _HostelPageState extends State<HostelPage> {
  bool isLiked = false;
  int likesCount = 27;

  /// Нажатие на сердечко
  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      // Если хотите менять количество лайков:
      // isLiked ? likesCount++ : likesCount--;
    });
  }

  /// Запуск звонка
  Future<void> _callNumber() async {
    final Uri callUri = Uri(scheme: 'tel', path: '+7 000 000 0000');
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      // Обработка ошибки
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось запустить телефонный звонок.'),
        ),
      );
    }
  }

  /// Открытие маршрута в картах
  Future<void> _openMap() async {
    // Пример: откроем адрес в Google Maps
    final Uri mapUri = Uri.parse(
      'https://www.google.com/maps/place/%D0%9E%D0%B1%D1%89%D0%B5%D0%B6%D0%B8%D1%82%D0%B8%D0%B5+20/@45.0493073,38.9160795,15.75z/data=!4m9!1m2!2m1!1z0YPQu9C40YbQsCDQmtCw0LvQuNC90LjQvdCwIDEzLCDQmtGA0LDRgdC90L7QtNCw0YAsINCg0L7RgdGB0LjRjw!3m5!1s0x40f04f3737bffbff:0x384537772b6bf12d!8m2!3d45.0502933!4d38.9207626!16s%2Fg%2F11bwqqb83z?entry=ttu&g_ep=EgoyMDI1MDMxOS4yIKXMDSoASAFQAw%3D%3D',
    );
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    } else {
      // Обработка ошибки
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть карту.')),
      );
    }
  }

  /// Поделиться информацией
  void _shareInfo() {
    Share.share('Рекомендую Общежитие №20 в КУБГАУ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Общежитие №20'),
        actions: [
          // Пример иконки в AppBar
          IconButton(icon: const Icon(Icons.home), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Картинка (можно использовать NetworkImage или AssetImage)
            // Здесь для примера используем заглушку
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPbRFXi8J4DAthtQHxZQBe7ZqGDGk-bkOcKienZSYDxJnog5Rg_aQcDk7ow_A5DXPAkig&usqp=CAU',
              height: 200,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),

            // Заголовок + сердечко с количеством
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Общежитие №20',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: _toggleLike,
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text('$likesCount'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Адрес
            const Text(
              'Краснодар, ул. Калинина, 13',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            // Кнопки: Позвонить, Маршрут, Поделиться
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _callNumber,
                  icon: const Icon(Icons.call),
                  label: const Text('Позвонить'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _openMap,
                  icon: const Icon(Icons.map),
                  label: const Text('Маршрут'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _shareInfo,
                  icon: const Icon(Icons.share),
                  label: const Text('Поделиться'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Длинный текст
            const Text(
              '''Студенческий городок или так называемый кампус Кубанского ГАУ состоит
из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях
университета, при поселении между администрацией и студентами заключается
договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия
асоциальных явлений в молодежной среде. Условия проживания в общежитиях
университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и
наглядной агитации. С целью улучшения условий быта студентов активно работает
система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.''',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
