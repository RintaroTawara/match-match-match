class AuthenticationError {
  // ログイン時の日本語エラーメッセージ
  loginErrorMsg(String errorCode){

    String errorMsg;

    if(errorCode == 'invalid-email'){
      errorMsg = '有効なメールアドレスを入力してください。';

    }else if (errorCode == 'user-not-found'){
      // 入力されたメールアドレスが登録されていない場合
      errorMsg = 'メールアドレスかパスワードが間違っています。';

    }else if (errorCode == 'wrong-password'){
      // 入力されたパスワードが間違っている場合
      errorMsg = 'メールアドレスかパスワードが間違っています。';

    }else if (errorCode == 'error'){
      // メールアドレスかパスワードがEmpty or Nullの場合
      errorMsg = 'メールアドレスとパスワードを入力してください。';

    }else{
      errorMsg = errorCode;
    }

    return errorMsg;
  }


  // アカウント登録時の日本語エラーメッセージ
  registerErrorMsg(String errorCode){

    String errorMsg;

    if(errorCode == 'invalid-email'){
      errorMsg = '有効なメールアドレスを入力してください。';

    } else if (errorCode == 'error') {
      // メールアドレスかパスワードがEmpty or Nullの場合
      errorMsg = 'メールアドレスとパスワードを入力してください。';
    } else if (errorCode == 'weak-password') {
      errorMsg = 'パスワードは6文字以上です';
    } else if (errorCode == 'email-already-in-use') {
      errorMsg = 'メールアドレスは既に使用されています';
    } else{
      errorMsg = errorCode;
    }

    return errorMsg;
  }
}