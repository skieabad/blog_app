import 'dart:io';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_field_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final List<String> _blogCategories = [
    'Business',
    'Technology',
    'Programming',
    'Travel',
    'Fashion & Beauty',
    'News and Politics',
  ];
  final List<String> _selectedBlogCategories = [];
  final _formKey = GlobalKey<FormState>();
  final _blogTitleController = TextEditingController();
  final _blogContentController = TextEditingController();
  final _blogTitleFocusNode = FocusNode();
  final _blogContentFocusNode = FocusNode();
  File? _selectedImage;

  @override
  void dispose() {
    _blogTitleController.dispose();
    _blogContentController.dispose();
    _blogTitleFocusNode.dispose();
    _blogContentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {
    final selectedImage = await imagePicker();

    if (selectedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.check_mark),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _selectedImage != null
                    ? GestureDetector(
                        onTap: () async => await _selectImage(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 280.0,
                            child: Image.file(
                              fit: BoxFit.cover,
                              _selectedImage ?? File(''),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async => await _selectImage(),
                        child: DottedBorder(
                          radius: const Radius.circular(10.0),
                          borderType: BorderType.RRect,
                          color: AppPallete.borderColor,
                          dashPattern: const [10, 4],
                          strokeWidth: 2,
                          child: const SizedBox(
                            height: 280.0,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.folder_open, size: 60.0),
                                SizedBox(height: 24.0),
                                Text(
                                  'Select your image',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 24.0),
                SingleChildScrollView(
                  physics: const RangeMaintainingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _blogCategories
                        .map((blogCategory) => GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_selectedBlogCategories
                                    .contains(blogCategory)) {
                                  _selectedBlogCategories.remove(blogCategory);
                                  return;
                                }

                                _selectedBlogCategories.add(blogCategory);
                              });
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Chip(
                                    // since we set a default color in the theme data, so we can use null here
                                    color: _selectedBlogCategories
                                            .contains(blogCategory)
                                        ? const MaterialStatePropertyAll(
                                            AppPallete.gradient1)
                                        : null,
                                    label: Text(blogCategory),
                                    elevation: 0.0,
                                    shadowColor: AppPallete.transparentColor,
                                    side: BorderSide(
                                      color: _selectedBlogCategories
                                              .contains(blogCategory)
                                          ? AppPallete.transparentColor
                                          : AppPallete.borderColor,
                                    )))))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BlogFieldWidget(
                        controller: _blogTitleController,
                        focusNode: _blogTitleFocusNode,
                        hintText: 'Blog Title',
                      ),
                      const SizedBox(height: 16.0),
                      BlogFieldWidget(
                        controller: _blogContentController,
                        focusNode: _blogContentFocusNode,
                        hintText: 'Blog Content',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
