package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.Course;
import edu.hm.cs.organisation_app.model.CourseSubscription;
import edu.hm.cs.organisation_app.model.Task;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

/**
 * Represents a CourseControllerTest.
 *
 * @author Angel Curras Sanchez
 */
@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class CourseControllerTest {

  /* Fields */
  @Autowired
  private CourseController courseController;

  /* Methods */
  private void clearDB() {
    courseController.deleteAllCourses();
  } // end of clearDB()

  private void initDB() {

  } // end of initDB()

  @Test
  public void testGetAllCoursesEmpty() {
    // Arrange.
    this.clearDB();

    // Act.
    List<Course> courses = courseController.getAllCourses();

    // Assert.
    Assertions.assertEquals(0, courses.size());
  } // end of testGetAllCoursesEmpty()


  /**
   * Tests the creation of a course with an unknown user.
   */
  @Test
  public void createCourseUnknownUser() {

    // Arrange.
    CourseSubscription courseSubscription = new CourseSubscription(1L, "unknown");

    // Act & Assert.
    Throwable exception = Assertions.assertThrows(Exception.class, () -> {
      courseController.createCourse(courseSubscription);
    });
    Assertions.assertInstanceOf(ResponseStatusException.class, exception);
    Assertions.assertEquals(HttpStatus.UNAUTHORIZED, ((ResponseStatusException) exception).getStatusCode());

  } // end of createCourseUnknownUser()


  /**
   * Tests the creation of a course with a known user but an unknown module.
   */
  @Test
  public void createCourseKnownUserUnknownModule() {

    // Arrange.
    CourseSubscription courseSubscription = new CourseSubscription(0L, "test");

    // Act & Assert.
    Throwable exception = Assertions.assertThrows(Exception.class, () -> {
      courseController.createCourse(courseSubscription);
    });
    Assertions.assertInstanceOf(ResponseStatusException.class, exception);
    Assertions.assertEquals(HttpStatus.NOT_FOUND, ((ResponseStatusException) exception).getStatusCode());

  } // end of createCourseKnownUserUnknownModule()

  /**
   * Tests the creation of a course with a known user and a known module, but the user is already subscribed to the module.
   */
  @Test
  @Transactional // Otherwise LazyInitializationException
  public void createCourseKnownUserKnownModuleDoubleSubscription() {

    // Arrange.
    CourseSubscription courseSubscription = new CourseSubscription(1L, "test");

    // Act.
    // First subscription.
    Course firstCourse = courseController.createCourse(courseSubscription);

    // Second subscription.
    Throwable exception = Assertions.assertThrows(Exception.class, () -> {
      courseController.createCourse(courseSubscription);
    });

    // Assert.
    Assertions.assertInstanceOf(ResponseStatusException.class, exception);
    Assertions.assertEquals(HttpStatus.CONFLICT, ((ResponseStatusException) exception).getStatusCode());
  } // end of createCourseKnownUserKnownModuleDoubleSubscription()

  /**
   * Tests the creation of a course with a known user and a known module.
   */
  @Test
  @Transactional // Otherwise LazyInitializationException
  public void createCourseKnownUserKnownModule() {

    // Arrange.
    CourseSubscription courseSubscription1 = new CourseSubscription(1L, "test");
    // Act.
    Course course1 = courseController.createCourse(courseSubscription1);
    // Assert.
    Assertions.assertEquals(1L, course1.getModuleId());
    Assertions.assertEquals("test", course1.getOwner().getUserName());

    // Arrange.
    CourseSubscription courseSubscription2 = new CourseSubscription(2L, "test");
    // Act.
    Course course2 = courseController.createCourse(courseSubscription2);
    // Assert.
    Assertions.assertEquals(2L, course2.getModuleId());
    Assertions.assertEquals("test", course2.getOwner().getUserName());

  } // end of createCourseKnownUserKnownModule()

  /**
   * Tests that finding a course by id works.
   */
  @Test
  @Transactional // Otherwise LazyInitializationException
  public void testGetCourseById() {

    // Arrange.
    CourseSubscription courseSubscription = new CourseSubscription(1L, "test");
    Course course = courseController.createCourse(courseSubscription);

    // Act.
    Course foundCourse = courseController.getCourseById(course.getId());

    // Assert.
    Assertions.assertEquals(course.getId(), foundCourse.getId());
    Assertions.assertEquals(course.getModuleId(), foundCourse.getModuleId());
    Assertions.assertEquals(course.getOwner().getUserName(), foundCourse.getOwner().getUserName());
  } // end of testGetCourseById()


  /**
   * Tests that deleting a course by id works.
   */
  @Test
  @Transactional // Otherwise LazyInitializationException
  public void testDeleteCourseById() {

    // Arrange.
    this.clearDB();
    CourseSubscription courseSubscription = new CourseSubscription(1L, "test");
    Course course = courseController.createCourse(courseSubscription);
    Assertions.assertEquals(course.getId(), courseController.getCourseById(course.getId()).getId());
    Assertions.assertEquals(1, courseController.getAllCourses().size());

    // Act.
    courseController.deleteCourse(course.getId());

    // Assert.
    Throwable exception = Assertions.assertThrows(Exception.class, () -> {
      courseController.getCourseById(course.getId());
    });
    Assertions.assertInstanceOf(ResponseStatusException.class, exception);
    Assertions.assertEquals(HttpStatus.NOT_FOUND, ((ResponseStatusException) exception).getStatusCode());
  } // end of testDeleteCourseById()


  /**
   * Get all courses for a user.
   */
  @Test
  @Transactional // Otherwise LazyInitializationException
  public void testGetAllCoursesForUser() {

    // Arrange.
    this.clearDB();
    CourseSubscription courseSubscription1 = new CourseSubscription(1L, "test");
    CourseSubscription courseSubscription2 = new CourseSubscription(2L, "test");
    CourseSubscription courseSubscription3 = new CourseSubscription(3L, "test");

    Course course1 = courseController.createCourse(courseSubscription1);
    Course course2 = courseController.createCourse(courseSubscription2);
    Course course3 = courseController.createCourse(courseSubscription3);

    // Act.
    List<Course> courses = courseController.getAllCoursesForUser("test");

    // Assert.
    Assertions.assertEquals(3, courses.size());
    Assertions.assertEquals(course1.getId(), courses.get(0).getId());
    Assertions.assertEquals(course2.getId(), courses.get(1).getId());
    Assertions.assertEquals(course3.getId(), courses.get(2).getId());
  } // end of testGetAllCoursesForUser()


  /**
   * Tests that updating a course by id works.
   */
  @Test
  @Transactional // Otherwise LazyInitializationException
  public void testUpdateCourseById() {

    // Arrange.
    this.clearDB();
    CourseSubscription courseSubscription = new CourseSubscription(1L, "test");
    Course course = courseController.createCourse(courseSubscription);
    course.setTasks(new ArrayList<>());
    Assertions.assertEquals(course.getId(), courseController.getCourseById(course.getId()).getId());
    Assertions.assertEquals(1, courseController.getAllCourses().size());

    // Act.
    Course newCourse = new Course(course.getModule(), course.getOwner());
    newCourse.setLectureWeekday(DayOfWeek.MONDAY);
    newCourse.setLectureStartTime(LocalTime.of(10, 0));
    newCourse.setLectureEndTime(LocalTime.of(12, 0));
    newCourse.setLabWeekday(DayOfWeek.WEDNESDAY);
    newCourse.setLabStartTime(LocalTime.of(10, 0));
    newCourse.setLabEndTime(LocalTime.of(12, 0));

    Course updatedCourse = courseController.updateCourse(course.getId(), newCourse);

    // Assert.
    Assertions.assertEquals(course.getId(), updatedCourse.getId());
    Assertions.assertEquals(newCourse.getModuleId(), updatedCourse.getModuleId());
    Assertions.assertEquals(newCourse.getOwner().getUserName(), updatedCourse.getOwner().getUserName());
    Assertions.assertEquals(newCourse.getLectureWeekday(), updatedCourse.getLectureWeekday());
    Assertions.assertEquals(newCourse.getLectureStartTime(), updatedCourse.getLectureStartTime());
    Assertions.assertEquals(newCourse.getLectureEndTime(), updatedCourse.getLectureEndTime());
    Assertions.assertEquals(newCourse.getLabWeekday(), updatedCourse.getLabWeekday());
    Assertions.assertEquals(newCourse.getLabStartTime(), updatedCourse.getLabStartTime());
    Assertions.assertEquals(newCourse.getLabEndTime(), updatedCourse.getLabEndTime());

  } // end of testUpdateCourseById()


  /**
   * Tests that all tasks for a course are returned.
   */
  @Test
  @Transactional // Otherwise LazyInitializationException
  public void testGetAllTasksForCourse() {

    // Arrange.
    this.clearDB();

    String userName = "test";
    CourseSubscription courseSubscription = new CourseSubscription(1L, userName);
    Course course = courseController.createCourse(courseSubscription);
    Task task1 = new Task("task1");
    Task task2 = new Task("task2");
    List<Task> tasks = new ArrayList<>();
    tasks.add(task1);
    tasks.add(task2);
    course.setTasks(tasks);

    // Act.
    List<Task> courseTasks = courseController.getAllTasksForCourse(course.getId());

    // Assert.
    Assertions.assertEquals(2, courseTasks.size());
    Assertions.assertEquals(task1.getId(), courseTasks.get(0).getId());
    Assertions.assertEquals(task2.getId(), courseTasks.get(1).getId());
    Assertions.assertEquals(task1.getName(), courseTasks.get(0).getName());
    Assertions.assertEquals(task2.getName(), courseTasks.get(1).getName());

  } // end of testGetAllTasksForCourse()

} // end of class CourseControllerTest