import 'dart:io';

import 'package:erb_mobo/ui/auths/bloc/auths_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/core_util_function.dart';

class PickImageWidget extends StatefulWidget {
  final AuthsBloc authsBloc;
  late double cirSize;
  PickImageWidget({Key? key, required this.authsBloc, this.cirSize = 120})
      : super(key: key);

  @override
  _PickImageWidgetState createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  late XFile? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
  late bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.authsBloc,
      listener: (context, state) {
        if (state is SucessUploadImage) {
          setState(() {
            isLoading = false;
          });
        } else if (state is UploaddingImage) {
          setState(() {
            isLoading = true;
          });
        } else if (state is ErrorUploadImage) {
          // show error notify
          setState(() {
            isLoading = false;
          });
        }
      },
      child: GestureDetector(
        onTap: () => _showChoiceDialog(context),
        child: Container(
            height: ScreenUtil().setSp(widget.cirSize),
            width: ScreenUtil().setSp(widget.cirSize),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                !isLoading && _imageFile != null
                    ? CircleAvatar(
                        radius: ScreenUtil().setHeight(widget.cirSize),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(widget.cirSize),
                            child: Image.file(
                              File(_imageFile!.path),
                              height: ScreenUtil().setHeight(widget.cirSize),
                              width: ScreenUtil().setHeight(widget.cirSize),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ))
                    : isLoading
                        ? CorerUtilFunction.getShimmer(const Image(
                            image: AssetImage('assets/images/useric.png'),
                          ))
                        : const Image(
                            image: AssetImage('assets/images/useric.png'),
                          ),
                Positioned(
                  bottom: ScreenUtil().setHeight(-4),
                  right: ScreenUtil().setWidth(-2),
                  child: Icon(
                    Icons.edit,
                    size: ScreenUtil().setSp(30),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _pickImageFrom(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );
      setState(() {
        _imageFile = pickedFile!;
      });
      if (_imageFile != null) {
        widget.authsBloc.add(UploadImage(_imageFile!.path));
        Navigator.pop(context);
      }
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _pickImageFrom(ImageSource.gallery);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _pickImageFrom(ImageSource.camera);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
