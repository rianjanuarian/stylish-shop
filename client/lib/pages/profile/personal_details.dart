import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum Gender { male, female }

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  Gender _gender = Gender.male;
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Widget _nameWithInput() {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Name',
              style: TextStyle(
                color: const Color(0xFFB4B4B4),
                fontSize: 15.sp,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _nameController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFB4B4B4),
                )),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFB4B4B4),
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB4B4B4), width: 2)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _genderWithCheck() {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Gender',
            style: TextStyle(
              color: const Color(0xFFB4B4B4),
              fontSize: 15.sp,
            ),
          ),
          SizedBox(width: 50.w),
          Row(
            children: [
              Material(
                color: _gender == Gender.male ? Colors.black : Colors.white,
                elevation: 4,
                borderRadius: BorderRadius.circular(20.r),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () {
                    setState(() {
                      _gender = Gender.male;
                    });
                  },
                  child: Container(
                    width: 80.w,
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          _gender == Gender.male
                              ? Icons.brightness_1
                              : Icons.brightness_1_outlined,
                          color: _gender == Gender.male
                              ? Colors.white
                              : Colors.black,
                          size: 15.sp,
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                              color: _gender == Gender.male
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Material(
                color: _gender == Gender.male ? Colors.white : Colors.black,
                elevation: 4,
                borderRadius: BorderRadius.circular(20.r),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () {
                    setState(() {
                      _gender = Gender.female;
                    });
                  },
                  child: Container(
                    width: 80.w,
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 5.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          _gender == Gender.male
                              ? Icons.brightness_1_outlined
                              : Icons.brightness_1,
                          color: _gender == Gender.male
                              ? Colors.black
                              : Colors.white,
                          size: 15.sp,
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                              color: _gender == Gender.male
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _birthDate() {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Birth Date',
              style: TextStyle(
                color: const Color(0xFFB4B4B4),
                fontSize: 15.sp,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _birthDateController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2023, 1, 1),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2023));

                if (pickedDate != null) {
                  setState(() {
                    _birthDateController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFB4B4B4),
                )),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFB4B4B4),
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB4B4B4), width: 2)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _phoneNumber() {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Phone',
              style: TextStyle(
                color: const Color(0xFFB4B4B4),
                fontSize: 15.sp,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _phoneController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFB4B4B4),
                )),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFB4B4B4),
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB4B4B4), width: 2)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _addressWithInput() {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Address',
              style: TextStyle(
                color: const Color(0xFFB4B4B4),
                fontSize: 15.sp,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _addressController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              maxLines: 4,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFB4B4B4),
                )),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFB4B4B4),
                )),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB4B4B4), width: 2)),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _saveProfile() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80.w,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          style: IconButton.styleFrom(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  'assets/images/user.png',
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _nameWithInput(),
                    _genderWithCheck(),
                    _birthDate(),
                    _phoneNumber(),
                    _addressWithInput(),
                    Padding(
                      padding: REdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveProfile();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(60.r),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10).r),
                          ),
                          child: const Text('Save')),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
