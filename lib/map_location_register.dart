/*

import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masjit_vendor_app/data/model/place.dart';
import 'package:masjit_vendor_app/data/model/register.dart';
import 'package:masjit_vendor_app/screens/get_location.dart';
import 'package:masjit_vendor_app/screens/home.dart';
import 'package:masjit_vendor_app/utils/constant.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _form = GlobalKey<FormState>();
  final _images = <XFile>[];
  String _address = '';
  final fields = <String, dynamic>{};
  Place? address;
  final ImagePicker _picker = ImagePicker();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController masjidNameController = TextEditingController();
  TextEditingController imamNameController = TextEditingController();
  TextEditingController imamNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text('Email Id'),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                fields['email'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                fields['password'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                label: Text('Masjid Phone No.'),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                fields['phone'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: masjidNameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                label: Text('Masjid Name'),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                fields['masjid_name'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: imamNameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                label: Text('Imam Name'),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                fields['immam_name'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: imamNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                label: Text('Imam Number'),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                fields['immam_contact'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () {
                Future<Place?> result = Navigator.of(context).push<Place>(
                  MaterialPageRoute(
                    builder: (context) => const GetLocation(),
                  ),
                );

                result.then((value) {
                  if (value == null) return;
                  setState(() {
                    address = value;
                    _address =
                    'Area ${address?.subLocality},\n City ${address?.locality}, \n Postal Code ${address?.postalCode},\n State ${address?.administrativeArea}, \n Country ${address?.country}';
                    setState(() {});
                  });
                });
              },
              child: const Text(
                'Select Location',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _address.isNotEmpty
                ? Padding(
              padding: EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: ' Area : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: address?.subLocality,
                          style:
                          TextStyle(fontSize: 9, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' City : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: address?.locality,
                          style:
                          TextStyle(fontSize: 9, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' Postal Code : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: address?.postalCode,
                          style:
                          TextStyle(fontSize: 9, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' Administrative Area : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: address?.administrativeArea,
                          style:
                          TextStyle(fontSize: 9, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' Country : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: address?.country,
                          style:
                          TextStyle(fontSize: 9, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () {
                Future<List<XFile>?> images = _picker.pickMultiImage();

                images.then((value) {
                  if (value == null) return;
                  _images.addAll(value);
                });
              },
              child: const Text(
                'Select Images',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                print("Hi");
                if (address == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please Select Location")));
                  return;
                }
                var resutl = getRegisterVendors();
                resutl.then((value) {
                  value.data?.token;

                  var box = Hive.box("testBox");

                  box.put(kToken, value.data?.token);
                  box.put(kMasjid, value.data?.masjid?.toJson());

                  print(" registrationToken ${box.get("token")}");

                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                });
              },
              child: const Text(
                'Register',
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<RegisterResponseModel> getRegisterVendors() async {
    try {
      final result = await http.post(
          Uri.parse("http://masjid.exportica.in/api/masjid/register"),
          body: {
            "email": emailController.text.trim(),
            "password": phoneNumberController.text.trim(),
            "immam_name": imamNameController.text.trim(),
            "masjid_name": masjidNameController.text.trim(),
            "immam_contact": imamNumberController.text.trim(),
            "lat": address?.lat,
            "long": address?.long,
            "phone": phoneNumberController.text.trim(),
            "street": address?.street,
            "sub_locality": address?.subLocality,
            "locality": address?.locality,
            "postal_code": address?.postalCode,
            "administrative_area": address?.administrativeArea,
            "country": address?.country
          });
      print("new order:" + result.body);

      return registerResponseModelFromJson(result.body);
    } catch (e) {
      throw e;
    }
  }
}
*/
