import 'package:flutter/material.dart';
import 'linepainter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

final shapestateProvider = StateProvider<bool>((_) => false);
final pefectshapeProvider = StateProvider<bool>((_) => false);
final pointsProvider = StateProvider<List<Offset>>((_) => []);
final xaxisProvider = StateProvider<double>((_) => 0);
final yaxisProvider = StateProvider<double>((_) => 0);

class _MainAppState extends ConsumerState<MainApp> {
  void _addPoint(Offset point) {
    // setState(() {
    //   _points.add(point);
    //   _points.add(point);
    // });
    ref.read(pointsProvider.notifier).state.add(point);
    ref.read(pointsProvider.notifier).state.add(point);
  }

  @override
  Widget build(BuildContext context) {
    List<Offset> _points = ref.watch(pointsProvider);
    bool shapestate = ref.watch(shapestateProvider);
    bool perfectshape = ref.watch(pefectshapeProvider);
    double xaxis = ref.watch(xaxisProvider);
    double yaxis = ref.watch(yaxisProvider);
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/razmetka.jpg"),
                  fit: BoxFit.none,
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                if (!perfectshape) {
                  if (_points.isEmpty) {
                    _addPoint(details.localPosition);
                  } else {
                    _addPoint(_points[_points.length - 1]);
                  }
                }
              },
              // onPanUpdate: (details) => setState(() {
              //   if (!perfectshape) {
              //     if (_points.isNotEmpty) {
              //       _points[_points.length - 1] += details.delta;
              //     }
              //     xaxis = details.localPosition.dx + 30;
              //     yaxis = details.localPosition.dy + 20;
              //     if (_points.length > 5 && !shapestate) {
              //       if (_points[_points.length - 1].dx - _points[0].dx > -10 &&
              //           _points[_points.length - 1].dx - _points[0].dx < 10) {
              //         if (_points[_points.length - 1].dy - _points[0].dy >
              //                 -10 &&
              //             _points[_points.length - 1].dy - _points[0].dy < 10) {
              //           print("yeah");
              //           _points[_points.length - 1] = _points[0];
              //           shapestate = true;
              //           perfectshape = true;
              //         }
              //       }
              //     }
              //   }
              // }),
              onPanUpdate: (details) => {
                if (!perfectshape)
                  {
                    // print(xaxis),
                    // print(_points),
                    if (_points.isNotEmpty)
                      {
                        ref.read(pointsProvider.notifier).state.removeLast(),
                        ref.read(pointsProvider.notifier).state.add(details.localPosition),
                      },
                      ref.read(xaxisProvider.notifier).update((state) => details.localPosition.dx),
                      ref.read(yaxisProvider.notifier).update((state) => details.localPosition.dy),
                    if (_points.length > 5 && !shapestate)
                      {
                        if (_points[_points.length - 1].dx - _points[0].dx >
                                -10 &&
                            _points[_points.length - 1].dx - _points[0].dx < 10)
                          {
                            if (_points[_points.length - 1].dy - _points[0].dy >
                                    -10 &&
                                _points[_points.length - 1].dy - _points[0].dy <
                                    10)
                              {
                                print("yeah"),
                                _points[_points.length - 1] = _points[0],
                                ref.watch(shapestateProvider.notifier).state =
                                    true,
                                ref.watch(pefectshapeProvider.notifier).state =
                                    true,
                              },
                          },
                      },
                  },
              },
              child: CustomPaint(
                painter: LinePainter(points: _points),
                child: Container(),
              ),
            ),
            Positioned(
              left: xaxis + 30,
              top: yaxis + 20,
              child: _points.isNotEmpty
                  ? Text(
                      '${(_points[_points.length - 1] - _points[_points.length - 2]).distance.floor()}')
                  : Text(''),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.03,
              height: 60,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 110),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: const Text(
                'Нажмите на любую точку экрана, чтобы построить угол',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.03,
              margin: const EdgeInsets.only(bottom: 30),
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 227, 227, 227),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    ref.read(pointsProvider.notifier).state.removeLast();
                    ref.read(pointsProvider.notifier).state.removeLast();
                    ref.read(pefectshapeProvider.notifier).state = false;
                    ref.read(shapestateProvider.notifier).state = false;
                    // setState(() {
                    //   if (_points.isNotEmpty) {
                    //     _points.removeLast();
                    //     _points.removeLast();
                    //     perfectshape = false;
                    //     shapestate = false;
                    //   }
                    // });
                  },
                  child: const Text(
                    'X\nОтменить действие',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 125, 125, 125),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
