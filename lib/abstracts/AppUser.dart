class AppUser {
  String _userName;
  String _userMail;
  String _userPicUrl;

  AppUser.anonymous() {
    _userName = 'Anonymous user';
    _userMail = '';
    _userPicUrl =
        'https://img.itch.zone/aW1nLzI1NjA3MTkucG5n/original/kdaCNO.png';
  }
  AppUser(this._userName, this._userMail, this._userPicUrl);

  String get userName => _userName;
  set userName(String value) {
    _userName = value;
  }

  String get userMail => _userMail;
  set userMail(String value) {
    _userMail = value;
  }

  String get userPicUrl => _userPicUrl;
  set userPicUrl(String value) {
    _userPicUrl = value;
  }
}
