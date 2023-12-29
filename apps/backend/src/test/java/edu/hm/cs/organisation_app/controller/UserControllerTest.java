package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.AppUser;
import edu.hm.cs.organisation_app.model.UserType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import java.util.List;

import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

/**
 * Represents a UserControllerTest.
 *
 * @author Angel Curras Sanchez
 */
@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class UserControllerTest {

  @Autowired
  private UserController userController;

  private void initDB() {
    userController.postUser(new AppUser("user1", "User 1", UserType.GUEST));
    userController.postUser(new AppUser("user2", "User 2", UserType.GUEST));
  }

  private void clearDB() {
    userController.deleteAllUsers();
  }

  @Test
  void testGetAllUsersEmpty() {
    this.clearDB();
    List<AppUser> users = userController.getUsers();
    Assertions.assertEquals(0, users.size());
  }

  @Test
  void testGetAllUsersAdded() {
    this.clearDB();
    this.initDB();
    List<AppUser> users = userController.getUsers();
    Assertions.assertEquals(2, users.size());

    Assertions.assertEquals("user1", users.get(0).getUserName());
    Assertions.assertEquals("User 1", users.get(0).getFullName());
    Assertions.assertEquals(UserType.GUEST, users.get(0).getUserType());

    Assertions.assertEquals("user2", users.get(1).getUserName());
    Assertions.assertEquals("User 2", users.get(1).getFullName());
    Assertions.assertEquals(UserType.GUEST, users.get(1).getUserType());
  }

  @Test
  void testNewUserDBEmpty() {
    this.clearDB();

    String username = "user1";
    String fullName = "User 1";
    UserType userType = UserType.GUEST;

    AppUser user = new AppUser();
    user.setUserName(username);
    user.setFullName(fullName);
    user.setUserType(userType);

    AppUser createdUser = userController.postUser(user);
    Assertions.assertEquals(username, createdUser.getUserName());
    Assertions.assertEquals(fullName, createdUser.getFullName());
    Assertions.assertEquals(userType, createdUser.getUserType());
  } // end of testNewUserDBEmpty()


  @Test
  void testGetUserInfoByUsername() {
    this.clearDB();
    this.initDB();
    AppUser user = userController.getUser("user1");
    Assertions.assertEquals("user1", user.getUserName());
    Assertions.assertEquals("User 1", user.getFullName());
    Assertions.assertEquals(UserType.GUEST, user.getUserType());
  } // end of testGetUserInfoByUsername()

} // end of class UserControllerTest