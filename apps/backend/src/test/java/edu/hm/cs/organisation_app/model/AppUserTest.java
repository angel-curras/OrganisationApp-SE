package edu.hm.cs.organisation_app.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

/**
 * Represents a AppUserTest.
 *
 * @author Angel Curras Sanchez
 */
@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class AppUserTest {

  private AppUser user = new AppUser();

  @Test
  void testDefaultConstructor() {
    user = new AppUser();
    Assertions.assertNull(user.getUserName());
    Assertions.assertNull(user.getFullName());
    Assertions.assertNull(user.getUserType());
  }

  @Test
  void testGetUserName() {
    user = new AppUser("user1", "User 1", "user");
    Assertions.assertEquals("user1", user.getUserName());
  }

  @Test
  void testGetFullName() {
    user = new AppUser("user1", "User 1", "user");
    Assertions.assertEquals("User 1", user.getFullName());
  }

  @Test
  void testGetUserType() {
    user = new AppUser("user1", "User 1", "user");
    Assertions.assertEquals("user", user.getUserType());
  }

  @Test
  void testSetUserName() {
    user = new AppUser("user1", "User 1", "user");
    user.setUserName("user2");
    Assertions.assertEquals("user2", user.getUserName());
  }

  @Test
  void testSetFullName() {
    user = new AppUser("user1", "User 1", "user");
    user.setFullName("User 2");
    Assertions.assertEquals("User 2", user.getFullName());
  }

  @Test
  void testSetUserType() {
    user = new AppUser("user1", "User 1", "user");
    user.setUserType("admin");
    Assertions.assertEquals("admin", user.getUserType());
  }

  @Test
  void testToString() {
    user = new AppUser("user1", "User 1", "user");
    Assertions.assertEquals("AppUser{userName='user1', fullName='User 1', userType='user'}", user.toString());
  }


} // end of class AppUserTest