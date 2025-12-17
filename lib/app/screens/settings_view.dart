import 'package:custom_aod/app/services/settings_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          // spacing: 5,
          children: [
            Card(
              child: SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Show seconds',
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                    Obx(() {
                      return Switch(
                        value: settings.value.withSeconds,
                        activeThumbColor: Colors.red,
                        onChanged: (value) {
                          settings.value.withSeconds = !settings.value.withSeconds;
                          SettingsService.save(settings.value);
                          settings.refresh();
                        },
                      );
                    })
                  ],
                ),
              ).paddingAll(15),
            ),
            Card(
              child: SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Make hours outlined',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                        Obx(() {
                          return Switch(
                            value: settings.value.isBorderedHours,
                            activeThumbColor: Colors.red,
                            onChanged: (value) {
                              settings.value.isBorderedHours = !settings.value.isBorderedHours;
                              SettingsService.save(settings.value);
                              settings.refresh();
                            },
                          );
                        })
                      ],
                    ),
                    Divider(
                      color: Colors.grey[700],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Make minutes outlined',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                        Obx(() {
                          return Switch(
                            value: settings.value.isBorderedMinutes,
                            activeThumbColor: Colors.red,
                            onChanged: (value) {
                              settings.value.isBorderedMinutes = !settings.value.isBorderedMinutes;
                              SettingsService.save(settings.value);
                              settings.refresh();
                            },
                          );
                        })
                      ],
                    ),
                    Obx(() {
                      return Visibility(
                        visible: settings.value.withSeconds,
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.grey[700],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Make seconds outlined',
                                    style: context.textTheme.titleMedium,
                                  ),
                                ),
                                Obx(() {
                                  return Switch(
                                    value: settings.value.isBorderedSeconds,
                                    activeThumbColor: Colors.red,
                                    onChanged: (value) {
                                      settings.value.isBorderedSeconds = !settings.value.isBorderedSeconds;
                                      SettingsService.save(settings.value);
                                      settings.refresh();
                                    },
                                  );
                                })
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ).paddingAll(15),
            ),
            Card(
              child: SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Clock opacity',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      return Slider(
                        value: settings.value.clockOpacity + .0,
                        activeColor: Colors.red,
                        divisions: 75,
                        max: 100,
                        min: 25,
                        onChanged: (v) {
                          settings.value.clockOpacity = v;
                          SettingsService.save(settings.value);
                          settings.refresh();
                        },
                      );
                    }),
                  ],
                ),
              ).paddingAll(15),
            ),
            Card(
              child: SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Clock size',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      return Slider(
                        value: settings.value.clockSize + .0,
                        activeColor: Colors.red,
                        divisions: 125,
                        max: 150,
                        min: 25,
                        onChanged: (v) {
                          settings.value.clockSize = v;
                          SettingsService.save(settings.value);
                          settings.refresh();
                        },
                      );
                    }),
                  ],
                ),
              ).paddingAll(15),
            ),
            Card(
              child: SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Save the OLED screen',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                        Obx(() {
                          return Switch(
                            value: settings.value.saveOled,
                            activeThumbColor: Colors.red,
                            onChanged: (value) {
                              settings.value.saveOled = !settings.value.saveOled;
                              SettingsService.save(settings.value);
                              settings.refresh();
                            },
                          );
                        })
                      ],
                    ),
                    Obx(() {
                      return Visibility(
                        visible: settings.value.saveOled,
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.grey[700],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Over protect the OLED screen',
                                    style: context.textTheme.titleMedium,
                                  ),
                                ),
                                Obx(() {
                                  return Switch(
                                    value: settings.value.overProtect,
                                    activeThumbColor: Colors.red,
                                    onChanged: (value) {
                                      settings.value.overProtect = !settings.value.overProtect;
                                      SettingsService.save(settings.value);
                                      settings.refresh();
                                    },
                                  );
                                })
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ).paddingAll(15),
            ),
          ],
        ),
      ),
    );
  }
}