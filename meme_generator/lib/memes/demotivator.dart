import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/riverpod/current_values/current_values.dart';

class Demotivator extends ConsumerStatefulWidget {
  final String name = "Basic template";
  const Demotivator({
    super.key,
  });

  @override
  ConsumerState<Demotivator> createState() => _DemotivatorState();
}

class _DemotivatorState extends ConsumerState<Demotivator> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController imageTextController = TextEditingController();

  File? imageFile;
  bool isImageSelected = false;
  bool imageFromGallery = false;

  @override
  void dispose() {
    textEditingController.dispose();
    imageTextController.dispose();
    super.dispose();
  }

  TextStyle demotivationStyle = const TextStyle(
    fontFamily: 'Impact',
    fontSize: 40,
    color: Colors.white,
  );

  _pickImagefromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final globalKey = GlobalKey();

  Future<void> takePicture() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    File imgFile = new File('photo.png');

    imgFile.writeAsBytes(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Column(
      children: [
        RepaintBoundary(
          key: globalKey,
          child: SizedBox(
            width: (MediaQuery.of(context).size.height * 2 / 3) * 1.5,
            child: DecoratedBox(
              decoration: decoration,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('tapped');
                        _pickImagefromGallery();
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 1 / 3,
                        child: DecoratedBox(
                          decoration: decoration,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                              child: imageFromGallery && imageFile != null
                                  ? Image.file(imageFile!)
                                  : Image.network(
                                      ref.watch(currentValuesProvider).when(
                                          data: (texts) => texts[0],
                                          error: (e, t) =>
                                              "https://storage.googleapis.com/pod_public/1300/175426.jpg",
                                          loading: () =>
                                              "https://storage.googleapis.com/pod_public/1300/175426.jpg"),
                                      errorBuilder: (context, e, t) =>
                                          Text("Wrong URI"),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height / 10),
                      width: (MediaQuery.of(context).size.height * 2 / 3) * 1.5,
                      child: FittedBox(
                        child: Text(
                          ref.watch(currentValuesProvider).when(
                              data: (texts) => texts[1],
                              error: (e, t) => throw Exception(e),
                              loading: () => "Loading"),
                          style: TextStyle(
                            fontFamily: 'Impact',
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(onPressed: takePicture, child: Text('')),
        Switch(
          value: imageFromGallery,
          onChanged: (_) => setState(
            () {
              imageFromGallery = _;
            },
          ),
        ),
        TextField(
          controller: imageTextController,
          style: TextStyle(color: Colors.white),
          onChanged: (_) => ref
              .read(currentValuesProvider.notifier)
              .addValue(value: _, index: 0),
        ),
        TextField(
          controller: textEditingController,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          onChanged: (_) => ref
              .read(currentValuesProvider.notifier)
              .addValue(value: _, index: 1),
        ),
      ],
    );
  }
}
