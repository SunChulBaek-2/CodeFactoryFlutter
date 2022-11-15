import 'dart:convert';
import 'dart:io';

import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:codefactory_flutter/common/component/custom_text_form_field.dart';
import 'package:codefactory_flutter/common/layout/default_layout.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    PrettyDioLogger logger = PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90
    );
    final dio = Dio()..interceptors.add(logger);

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(),
                  const SizedBox(height: 16),
                  _SubTitle(),
                  Image.asset(
                    'asset/img/misc/logo.png',
                    width: MediaQuery.of(context).size.width/3*2
                  ),
                  CustomTextFormField(
                    hintText: '이메일을 입력해 주세요',
                    onChanged: (String value) {
                      username = value;
                    }
                  ),
                  const SizedBox(height: 16,),
                  CustomTextFormField(
                    hintText: '비밀번호를 입력해 주세요',
                    obscureText: true,
                    onChanged: (String value) {
                      password = value;
                    }
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: () async {
                      final rawString = '$username:$password';
                      Codec<String, String> stringToBase64 = utf8.fuse(base64);
                      final token = stringToBase64.encode(rawString);
                      final response = await dio.post('http://$ip/auth/login', options: Options(
                        headers: {
                          'authorization' : 'Basic $token'
                        }
                      ));
                      final refreshToken = response.data['refreshToken'];
                      final accessToken = response.data['accessToken'];
                      print('refreshToken = $refreshToken');
                      print('accessToken = $accessToken');
                      await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                      await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RootTab())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR
                    ),
                    child: Text('로그인')
                  ),
                  TextButton(
                    onPressed: () async {

                    },
                    style: TextButton.styleFrom(primary: Colors.black),
                    child: Text('회원가입')
                  )
                ],
              )
          )
        )
      )
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black
      ));
  }
}

class _SubTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
        '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길:)',
        style: TextStyle(
            fontSize: 16,
            color: BODY_TEXT_COLOR
        ));
  }
}