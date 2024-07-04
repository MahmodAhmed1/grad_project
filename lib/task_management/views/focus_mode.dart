import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/shared/constants/colors.dart';
import 'package:pyramend/task_management/shared/constants/icons.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class FocusMode extends StatefulWidget {
  final int initialMinutes; // Parameter for initial minutes

  const FocusMode({Key? key, required this.initialMinutes}) : super(key: key);

  @override
  State<FocusMode> createState() => _FocusModeState();
}

class _FocusModeState extends State<FocusMode> with TickerProviderStateMixin {
  late Duration selectedDuration;
  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification(asAlarm: true, volume: 100);
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDuration = Duration(minutes: widget.initialMinutes);
    controller = AnimationController(
      vsync: this,
      duration: selectedDuration,
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 177, 177, 177),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: blackArrowBackIcon,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(186, 18, 125, 139).withOpacity(.8),
                  const Color.fromARGB(120, 226, 226, 226),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // SizedBox(
                      //   width: 300,
                      //   height: 300,
                      //   child: CircularProgressIndicator(
                      //     color: Color.fromARGB(143, 161, 161, 161),
                      //     value: progress,
                      //     strokeWidth: 12,
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          if (controller.isDismissed) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height: 250,
                                child: CupertinoTimerPicker(
                                  initialTimerDuration: controller.duration!,
                                  onTimerDurationChanged: (time) {
                                    setState(() {
                                      controller.duration = time;
                                    });
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) => Text(
                            countText,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.isAnimating) {
                            controller.stop();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            controller.reverse(
                              from: controller.value == 0
                                  ? 1.0
                                  : controller.value,
                            );
                            setState(() {
                              isPlaying = true;
                            });
                          }
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: mainButtonColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              child: Text(
                                isPlaying == true ? "Break" : "Start",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.reset();
                          setState(() {
                            isPlaying = false;
                          });
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: mainButtonColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              child: Text(
                                "End",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxHeight(20),
              ],
            ),
          ),
        );
      },
    );
  }
}
