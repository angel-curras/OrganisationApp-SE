package edu.hm.cs.organisation_app.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import java.util.ArrayList;
import java.util.List;

import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

/**
 * Represents an AppUserTest.
 *
 * @author Angel Curras Sanchez
 */
@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class AppUserTest {

  private AppUser user;

  /**
   * Constructor for AppUserTest.
   */
  @Test
  void testDefaultConstructor() {
    // Arrange & Act.
    user = new AppUser();

    // Assert.
    Assertions.assertNull(user.getUserName());
    Assertions.assertNull(user.getFullName());
    Assertions.assertNull(user.getUserType());
    Assertions.assertNull(user.getCourses());
    Assertions.assertNull(user.getTasks());
  } // end of testDefaultConstructor

  /**
   * Test the custom constructor.
   */
  @Test
  void testCustomConstructor() {

    // Arrange.
    String userName = "user1";
    String fullName = "User 1";
    String userType = "user";

    // Act.
    user = new AppUser(userName, fullName, userType);

    // Assert.
    Assertions.assertEquals(userName, user.getUserName());
    Assertions.assertEquals(fullName, user.getFullName());
    Assertions.assertEquals(userType, user.getUserType());
    Assertions.assertNull(user.getCourses());
    Assertions.assertNull(user.getTasks());
  } // end of testCustomConstructor


  @Test
  public void testGettersAndSetters() {
    // Arrange.
    String userName = "user1";
    String fullName = "User 1";
    String userType = "user";
    List<Task> tasks = new ArrayList<>();
    List<Course> courses = new ArrayList<>();

    // Act.
    user = new AppUser();
    user.setUserName(userName);
    user.setFullName(fullName);
    user.setUserType(userType);
    user.setTasks(tasks);
    user.setCourses(courses);

    // Assert.
    Assertions.assertEquals(userName, user.getUserName());
    Assertions.assertEquals(fullName, user.getFullName());
    Assertions.assertEquals(userType, user.getUserType());
    Assertions.assertEquals(tasks, user.getTasks());
    Assertions.assertEquals(courses, user.getCourses());
  } // end of testGettersAndSetters

  @Test
  public void testAddCourse() {
    // Arrange.
    String userName = "user1";
    String fullName = "User 1";
    String userType = "user";
    List<Task> tasks = new ArrayList<>();
    List<Course> courses = new ArrayList<>();

    user = new AppUser();
    user.setUserName(userName);
    user.setFullName(fullName);
    user.setUserType(userType);
    user.setTasks(tasks);
    user.setCourses(courses);

    // Act.
    Course course = new Course();
    user.addCourse(course);

    // Assert.
    Assertions.assertEquals(1, user.getCourses().size());
    Assertions.assertEquals(course, user.getCourses().getFirst());

  } // end of testAddCourse


  /**
   * Tests the to string method.
   */
  @Test
  void testToString() {
    user = new AppUser("user1", "User 1", "user");
    Assertions.assertEquals("AppUser{userName='user1', fullName='User 1', userType='user'}", user.toString());
  } // end of testToString

} // end of class AppUserTest