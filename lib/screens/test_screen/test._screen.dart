import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('This is test screen')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: SizedBox(
            width: 820,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      // height: 100,
                      // width: 720,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Increase value"),
                          ),
                          TextField(
                            controller: controller,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
