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
    UserType userType = UserType.GUEST;

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
    UserType userType = UserType.GUEST;
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
    UserType userType = UserType.GUEST;
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
    user = new AppUser("user1", "User 1", UserType.GUEST);
    Assertions.assertEquals("AppUser{userName='user1', fullName='User 1', userType='GUEST'}",
            user.toString());
  } // end of testToString

  /**
   * Tests that all the tasks are returned properly (empty).
   * .
   */
  @Test
  void testGetAllTasksEmpty() {
    // Arrange.
    String userName = "user1";
    String fullName = "User 1";
    UserType userType = UserType.GUEST;
    List<Task> tasks = new ArrayList<>();
    List<Course> courses = new ArrayList<>();

    user = new AppUser();
    user.setUserName(userName);
    user.setFullName(fullName);
    user.setUserType(userType);
    user.setTasks(tasks);
    user.setCourses(courses);

    // Act.
    List<Task> result = user.getAllTasks();

    // Assert.
    Assertions.assertEquals(0, result.size());

  } // end of testGetAllTasksEmpty


  /**
   * Tests that all the tasks are returned properly (empty).
   * .
   */
  @Test
  void testGetAllTasks() {
    // Arrange.
    String userName = "user1";
    String fullName = "User 1";
    UserType userType = UserType.GUEST;
    List<Task> tasks = new ArrayList<>();
    List<Course> courses = new ArrayList<>();

    // Add a task for the user.
    Task task = new Task("Task User");
    tasks.add(task);

    // Add a task for the course 1.
    Course course1 = new Course();
    Task task1 = new Task("Task Course 1");
    List<Task> course1Tasks = new ArrayList<>();
    course1Tasks.add(task1);
    course1.setTasks(course1Tasks);
    courses.add(course1);

    // Add a task for the course 2.
    Course course2 = new Course();
    Task task2 = new Task("Task Course 2");
    List<Task> course2Tasks = new ArrayList<>();
    course2Tasks.add(task2);
    course2.setTasks(course2Tasks);
    courses.add(course2);

    user = new AppUser();
    user.setUserName(userName);
    user.setFullName(fullName);
    user.setUserType(userType);
    user.setTasks(tasks);
    user.setCourses(courses);

    // Act.
    List<Task> result = user.getAllTasks();

    // Assert.
    Assertions.assertEquals(3, result.size());
    Assertions.assertEquals(task, result.get(0));
    Assertions.assertEquals(task1, result.get(1));
    Assertions.assertEquals(task2, result.get(2));

  } // end of testGetAllTasksEmpty

} // end of class AppUserTest