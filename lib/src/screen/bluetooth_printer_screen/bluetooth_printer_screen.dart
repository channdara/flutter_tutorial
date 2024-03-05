import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';

class BluetoothPrinterScreen extends StatefulWidget {
  const BluetoothPrinterScreen({super.key});

  @override
  State<BluetoothPrinterScreen> createState() => _BluetoothPrinterScreenState();
}

class _BluetoothPrinterScreenState extends State<BluetoothPrinterScreen> {
  final BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool connected = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bluetoothPrint.startScan();
    });
    super.initState();
  }

  @override
  void dispose() {
    bluetoothPrint.disconnect();
    bluetoothPrint.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Printer Screen'),
        actions: [
          if (connected)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check_rounded),
            ),
        ],
      ),
      body: StreamBuilder<List<BluetoothDevice>>(
        stream: bluetoothPrint.scanResults,
        initialData: const [],
        builder: (context, snapshot) {
          final List<BluetoothDevice> devices =
              snapshot.data == null ? [] : snapshot.data!;
          return Column(
            children: devices
                .map((device) => ListTile(
                      onTap: () {
                        bluetoothPrint.connect(device).then((value) {
                          setState(() {
                            connected = true;
                          });
                        });
                      },
                      title: Text(device.name ?? ''),
                      subtitle: Text(device.address ?? ''),
                    ))
                .toList(),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            final Map<String, dynamic> config = {};
            final List<LineText> data = [
              LineText(
                content: 'Test printing from Flutter app',
                type: LineText.TYPE_TEXT,
              ),
              LineText(linefeed: 1),
              LineText(linefeed: 1),
              LineText(linefeed: 1),
            ];
            bluetoothPrint.printReceipt(config, data);
          },
          child: const Text('Test Print'),
        ),
      ),
    );
  }
}
