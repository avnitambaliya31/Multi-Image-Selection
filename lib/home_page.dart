import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// image picker data
  List<XFile> multiImageFile = [];
  final ImagePicker _picker = ImagePicker();

  multiselection() async {
    try {
      final XFile? pickFile =
          await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        multiImageFile.add(pickFile!);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Multi Image Selection",
          style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.blueGrey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                child: const Text(
                  "Selected Image Data",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                  itemCount: multiImageFile.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          Container(
                            child: Image.file(
                              File(multiImageFile[index].path),
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                multiImageFile.removeAt(index);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 102.0),
                              child: Container(
                                  height: 18,
                                  width: double.infinity,
                                  color: Colors.red.withOpacity(0.6),
                                  child: const Center(
                                      child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.blueGrey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: FloatingActionButton.extended(
            onPressed: () {
              multiselection();
              print("image select ma aave che ");
              setState(() {});
            },
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            label: const Text(
              "Select Image",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
