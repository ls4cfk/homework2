import 'package:flutter/material.dart';
import 'package:homework2/logic/metrics_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fromMetric;
  String? toMetric;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _numberController = TextEditingController();
  String result = "";
  double fromNumber = 0;
  final List<String> _metrics = [
    "km",
    "m",
    "cm"
  ];

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (_) => _focusNode.unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text("Metrics Converter",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Column(children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Number: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.indigo),
                  ),
                  SizedBox(
                      height: 60,
                      width: 120,
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _numberController,
                        onChanged: (value) {
                          setState(() {
                            var amount = double.tryParse(value);
                            if (amount != null) {
                              fromNumber = amount;
                            } else {
                              fromNumber = 0;
                            }
                          });
                        },
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            fillColor: Colors.blue,
                            filled: true,
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),),)
                      )),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 360,
                  width: 360,
                  decoration: const BoxDecoration(
                      color: Colors.lightBlue, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 50),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("From:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: fromMetric,
                                    iconEnabledColor: Colors.white,
                                    borderRadius: BorderRadius.circular(35),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    selectedItemBuilder: (_) => _metrics
                                        .map((e) => Center(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(e,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        )))
                                        .toList(),
                                    items: _metrics
                                        .map((metric) =>
                                        DropdownMenuItem<String>(
                                          value: metric,
                                          child: Text(metric),
                                        ))
                                        .toList(),
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        fromMetric = value;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("To:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: toMetric,
                                    iconEnabledColor: Colors.white,
                                    borderRadius: BorderRadius.circular(35),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    selectedItemBuilder: (_) => _metrics
                                        .map((e) => Center(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(e,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        )))
                                        .toList(),
                                    items: _metrics
                                        .map((metric) =>
                                        DropdownMenuItem<String>(
                                          value: metric,
                                          child: Text(metric),
                                        ))
                                        .toList(),
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        toMetric = value;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "result: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.indigo),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      color: Colors.blue,
                      height: 60,
                      width: 120,
                      child: Center(
                          child: Text(result,
                              style: const TextStyle(color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: SizedBox(
                height: 60,
                width: 240,
                child: ElevatedButton.icon(
                    onPressed: () {
                      if (fromMetric == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('choose the metric'),
                          ),
                        );
                      } else if (toMetric == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('choose the metric'),
                          ),
                        );
                      } else {
                        setState(() {
                          result = MetricsHelper()
                              .convert(fromMetric, toMetric, fromNumber)
                              .toString();
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.change_circle,
                    ),
                    label: const Text("CONVERSION")),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: SizedBox(
                height: 60,
                width: 240,
                child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _focusNode.unfocus();
                        fromMetric = null;
                        toMetric = null;
                        _numberController.clear();
                        result = "";
                        fromNumber = 0;
                      });
                    },
                    icon: const Icon(
                      Icons.change_circle,
                    ),
                    label: const Text("RESET")),
              ),
            ),
          ]),
        ));
  }
}