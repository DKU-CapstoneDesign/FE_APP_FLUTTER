import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  File? _imageFile;
  final picker = ImagePicker();
  final TextEditingController _contentController = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)
      )
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: '글 제목',
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: getImage,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _imageFile != null
                      ? Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  )
                      : const Center(
                    child: Icon(Icons.add_a_photo),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 510,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: '게시판에 올릴 게시글 내용을 작성해주세요 \n건강한 게시판 문화를 지향합니다:)',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(const Color.fromRGBO(92, 67, 239, 60)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                    ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Text('완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
