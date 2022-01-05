import 'dart:io';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/dotterd_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class ImagePickerWidget extends StatefulWidget {
  final double width, height;
  final ValueSetter<File>? onFilePicked;
  final String label;
  final bool allowPdf;
  final double? radius;
  Widget? child;
  final bool pickFromGalleryOnly;
  final bool showPreview;
  final List<CropAspectRatioPreset>? cropRatio;
  final String? image_url;

  final showLabel;

  final heroTag = UniqueKey().toString();

  ImagePickerWidget(
      {this.width = 0,
      this.height = 0,
      this.onFilePicked,
      this.label = "",
      this.child,
      this.allowPdf = true,
      this.radius,
      this.image_url,
      this.pickFromGalleryOnly = false,
      this.showPreview = true,
      this.showLabel = true,
      this.cropRatio})
      : super();

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget> {
  File? _image;
  ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.pickFromGalleryOnly
            ? _imgFromGallery()
            : Get.bottomSheet(_showPicker(), isScrollControlled: true);
      },
      child: widget.child != null && (!widget.showPreview || _image == null)
          ? widget.child
          : DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(60.sp),
              padding: EdgeInsets.zero,
              dashPattern: [3, 1],
              color: "#9CA2B8".hexToColor(),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height:
                    widget.radius != null ? widget.radius! * 2 : widget.height,
                width:
                    widget.radius != null ? widget.radius! * 2 : widget.width,
                decoration: BoxDecoration(
                  color: "#EAEEFA".hexToColor(),
                  borderRadius: BorderRadius.circular(60.sp),
                ),
                child: Hero(
                        tag: widget.heroTag,
                        child: _image != null
                            ? Stack(
                                children: [
                                  widget.radius != null
                                      ? CircleAvatar(
                                          child: Image.file(
                                            _image!,
                                            fit: BoxFit.cover,
                                          ),
                                          radius: widget.radius,
                                        )
                                      : Image.file(
                                          _image!,
                                          height: widget.radius != null
                                              ? widget.radius! * 2
                                              : widget.height,
                                          width: widget.radius != null
                                              ? widget.radius! * 2
                                              : widget.width,
                                          fit: BoxFit.cover,
                                        ),
                                  Visibility(
                                      visible: widget.showLabel &&
                                          widget.label.isNotEmpty,
                                      child: Container(
                                        width: double.infinity,
                                        color: ColorUtils.white.withAlpha(200),
                                        child: CustomText(
                                          widget.label,
                                          textAlign: TextAlign.center,
                                        ).paddingSymmetric(vertical: 5),
                                      ).alignTo(Alignment.bottomCenter))
                                ],
                              )
                            : widget.image_url != null &&
                                    widget.image_url!.isNotEmpty
                                ? Stack(
                                    children: [
                                      widget.radius != null
                                          ? CircleAvatar(
                                              child: CustomImage.network(
                                                  widget.image_url!,
                                                  height: widget.radius! * 2,
                                                  width: widget.radius! * 2,
                                                  fit: BoxFit.cover),
                                              radius: widget.radius,
                                            )
                                          : CustomImage.network(
                                              widget.image_url!,
                                              height: widget.radius != null
                                                  ? widget.radius! * 2
                                                  : widget.height,
                                              width: widget.radius != null
                                                  ? widget.radius! * 2
                                                  : widget.width,
                                              fit: BoxFit.cover,
                                            ),
                                      Visibility(
                                        visible: widget.showLabel &&
                                            widget.label.isNotEmpty,
                                        child: Container(
                                            width: double.infinity,
                                            color:
                                                ColorUtils.white.withAlpha(200),
                                            child: CustomText(
                                              widget.label,
                                              textAlign: TextAlign.center,
                                            ).paddingSymmetric(vertical: 5)),
                                      ).alignTo(Alignment.bottomCenter)
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: SvgPicture.asset(
                                          'assets/images/new_images/profile_image/logout.svg',
                                          height: 72.sp,
                                          color: "#9CA2B8".hexToColor(),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ).marginOnly(bottom: 10),
                                      if (widget.showLabel &&
                                          widget.label.isNotEmpty)
                                        CustomText(
                                          widget.label,
                                          style: GoogleFonts.mulish(
                                              color: "#9CA2B8".hexToColor(),
                                              fontWeight: FontWeight.w600),
                                        )
                                    ],
                                  ))
                    .alignTo(Alignment.center),
              )),
    );
  }

  _showPicker() {
    return Container(
      width: Get.width,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              "Pick Image With",
              fontweight: Weight.NORMAL,
              fontSize: 50.sp,
            ).marginOnly(top: 25.sp),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                    child: Card(
                            elevation: 0,
                            margin: EdgeInsets.only(left: 30.sp, right: 15.sp),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                                side:
                                    BorderSide(color: Colors.grey, width: .5)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.photo_library,
                                  color: ColorUtils.textColor,
                                  size: 100.sp,
                                ),
                                new CustomText('Photo Gallery')
                              ],
                            ).marginAll(40.sp))
                        .onClick(() {
                  _imgFromGallery();
                  Get.back();
                })),
                Expanded(
                    child: Card(
                            margin: EdgeInsets.only(right: 30.sp, left: 15.sp),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                                side:
                                    BorderSide(color: Colors.grey, width: .5)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.photo_camera,
                                  color: ColorUtils.textColor,
                                  size: 100.sp,
                                ),
                                new CustomText('Camera')
                              ],
                            ).marginAll(40.sp))
                        .onClick(() {
                  _imgFromCamera();
                  Get.back();
                })),
              ],
            ).marginOnly(bottom: 25.sp),
          ],
        ),
      ),
    );
  }

  /*_pickPdf() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path);
      if (file != null) {
        if (widget.onFilePicked != null) {
          print(result.files.single.path);
          widget.onFilePicked(file);

        }
      }
    }
  }*/

  _imgFromCamera() async {
    PickedFile? pickedImage = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);
    _cropImage(pickedImage);
  }

  _imgFromGallery() async {
    PickedFile? pickedImage = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    _cropImage(pickedImage);
  }

  Future<Null> _cropImage(pickedImage) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: widget.cropRatio ??
            (Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ]),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: ColorUtils.white,
            backgroundColor: Colors.white70,
            toolbarWidgetColor: ColorUtils.orange,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
        ));
    if (croppedFile != null) {
      setState(() {
        _image = File(croppedFile.path);
        if (widget.onFilePicked != null) {
          print(croppedFile.path);
          if (widget.onFilePicked != null) widget.onFilePicked!(_image!);
        }
      });
    }
  }

  showPreview() {
    Get.back();
    Get.to(
        ImagePreview(
            isFile: _image != null,
            imagePath: _image == null ? widget.image_url : _image,
            label: widget.label,
            heroTag: widget.heroTag),
        transition: Transition.fade);
  }
}

class ImagePreview extends StatelessWidget {
  final bool isFile;
  var imagePath;
  final heroTag;
  final label;

  ImagePreview(
      {required this.isFile, required this.imagePath, this.heroTag, this.label})
      : super();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showAppIcon: true,
        title: label,
        body: Container(
          child: Hero(
            tag: heroTag,
            child: PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              enableRotation: true,
              imageProvider: (isFile
                      ? FileImage(imagePath as File)
                      : CachedNetworkImageProvider(imagePath.toString()))
                  as ImageProvider,
            ),
          ),
        ));
  }
}
