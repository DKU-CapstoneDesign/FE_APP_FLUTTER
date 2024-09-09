import 'dart:io';
import 'package:capstonedesign/viewModel/post/createPostPage_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/post_dataSource.dart';
import '../../../model/user.dart';


class CreatePostPage extends StatefulWidget {
  final User user;
  CreatePostPage({required this.user});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {

  //이미지 컨트롤
  File? _imageFile;
  final picker = ImagePicker();
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
  Widget build(BuildContext context) {
    //상태 관리
    return ChangeNotifierProvider(
        create: (_) => CreatePostViewModel(PostDataSource(), widget.user),

      child : Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)
      )
      ),
      //consumer를 이용한 상태 관리
      /*provider 대신 consumer를 사용한 이유??
    => 상태 관리를 더 명확하게 하고, 특정 위젯들만 다시 빌드할 수 있기 때문*/
      body: Consumer<CreatePostViewModel>(
        builder: (context, viewModel, child){
         return Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (value)=> viewModel.title = value,
                decoration: const InputDecoration(
                  hintText: '글 제목',
                ),
              ),
              SizedBox(height: 16.0),

              ////이미지
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
                  onChanged: (value) => viewModel.contents = value,
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
                  viewModel.createPost(context);
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
        )
        );
        }
      )
      )
    );
  }
}
