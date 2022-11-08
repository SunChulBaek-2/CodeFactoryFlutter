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
    const emulatorIp = '10.0.2.2:3000';
    const simulatorIp = '127.0.0.1:3000';
    final ip = Platform.isIOS ? simulatorIp : emulatorIp;
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
                      const refreshToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY2NzM3NDcxMCwiZXhwIjoxNjY3NDYxMTEwfQ.VOiSzYqaqSZYNcfBlzk2g_3iuUOgHgN96mOujSWt9-U';
                      final response = await dio.post('http://$ip/auth/token', options: Options(
                        headers: {
                          'authorization' : 'Bearer $refreshToken'
                        }
                      ));
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