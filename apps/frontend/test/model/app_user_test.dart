import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/model/app_user.dart';

void main() {
  group("Empty app user", () {
    test("Empty app user", () {
      AppUser appUser = AppUser();

      expect(appUser, isNotNull);
      expect(appUser.userName, "");
      expect(appUser.fullName, "");
      expect(appUser.userType, UserType.guest);
    }); // end of Empty app user test

    test("Empty app user to JSON Map", () {
      AppUser appUser = AppUser();

      expect(appUser, isNotNull);
      expect(appUser.toJsonMap(), isNotNull);
      expect(appUser.toJsonMap()["user_name"], "");
      expect(appUser.toJsonMap()["full_name"], "");
      expect(appUser.toJsonMap()["user_type"], "GUEST");
    }); // end of Empty app user to json test

    test("Empty app user from JSON Map", () {
      AppUser appUser = AppUser.fromJsonMap({});

      expect(appUser, isNotNull);
      expect(appUser.userName, "");
      expect(appUser.fullName, "");
      expect(appUser.userType, UserType.guest);
    }); // end of Empty app user from json test

    test("Empty app user to JSON String", () {
      AppUser appUser = AppUser();

      expect(appUser, isNotNull);
      expect(appUser.toJsonString(), isNotNull);
      expect(appUser.toJsonString(),
          '{"user_name":"","full_name":"","user_type":"GUEST"}');
    }); // end of Empty app user to json string test

    test("Empty app user from JSON String", () {
      AppUser appUser = AppUser.fromJsonString(
          '{"user_name":"","full_name":"","user_type":"GUEST"}');

      expect(appUser, isNotNull);
      expect(appUser.userName, "");
      expect(appUser.fullName, "");
      expect(appUser.userType, UserType.guest);
    }); // end of Empty app user from json string test
  }); // end of Empty app user

  group("Filled app user", () {
    test("Filled app user", () {
      AppUser appUser = AppUser(
        userName: "test",
        fullName: "Test User",
        userType: UserType.student,
      );

      expect(appUser, isNotNull);
      expect(appUser.userName, "test");
      expect(appUser.fullName, "Test User");
      expect(appUser.userType, UserType.student);
    }); // end of Filled app user test

    test("Filled app user to JSON Map", () {
      AppUser appUser = AppUser(
        userName: "test",
        fullName: "Test User",
        userType: UserType.admin,
      );

      expect(appUser, isNotNull);
      expect(appUser.toJsonMap(), isNotNull);
      expect(appUser.toJsonMap()["user_name"], "test");
      expect(appUser.toJsonMap()["full_name"], "Test User");
      expect(appUser.toJsonMap()["user_type"], "ADMIN");
    }); // end of Filled app user to json test

    test("Filled app user from JSON Map", () {
      AppUser appUser = AppUser.fromJsonMap({
        "user_name": "test",
        "full_name": "Test User",
        "user_type": "STUDENT",
      });

      expect(appUser, isNotNull);
      expect(appUser.userName, "test");
      expect(appUser.fullName, "Test User");
      expect(appUser.userType, UserType.student);
    }); // end of Filled app user from json test

    test("Filled app user to JSON String", () {
      AppUser appUser = AppUser(
        userName: "test",
        fullName: "Test User",
        userType: UserType.student,
      );

      expect(appUser, isNotNull);
      expect(appUser.toJsonString(), isNotNull);
      expect(appUser.toJsonString(),
          '{"user_name":"test","full_name":"Test User","user_type":"STUDENT"}');
    }); // end of Filled app user to json string test

    test("Filled app user from JSON String", () {
      AppUser appUser = AppUser.fromJsonString(
          '{"user_name":"test","full_name":"Test User","user_type":"STUDENT"}');

      expect(appUser, isNotNull);
      expect(appUser.userName, "test");
      expect(appUser.fullName, "Test User");
      expect(appUser.userType, UserType.student);
    }); // end of Filled app user from json string test
  }); // end of Filled app user
} // end of main()
