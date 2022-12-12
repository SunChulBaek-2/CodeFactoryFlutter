import 'dart:convert';
import 'dart:io';

import 'package:codefactory_flutter/common/const/colors.dart';
import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/common/secure_storage/secure_storage.dart';
import 'package:codefactory_flutter/common/view/root_tab.dart';
import 'package:codefactory_flutter/user/model/user_model.dart';
import 'package:codefactory_flutter/user/provider/user_me_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:codefactory_flutter/common/component/custom_text_form_field.dart';
import 'package:codefactory_flutter/common/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => "login";

  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
    final state = ref.watch(userMeProvider);
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
                    onPressed: state is UserModelLoading ? null : () async {
                      ref.read(userMeProvider.notifier)
                          .login(username: username, password: password);
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