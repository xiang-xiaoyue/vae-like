class Login {
  String email;
  String password;
  Login({
    this.email = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

// 注册
class Register {
  String name;
  String email;
  String password;
  String repeatPassword;
  Register({
    this.name = '',
    this.email = '',
    this.password = '',
    this.repeatPassword = '',
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "repeat_password": repeatPassword,
      };
}
