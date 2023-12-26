package edu.hm.cs.organisation_app.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

/**
 * Represents a CourseTest.
 *
 * @author Angel Curras Sanchez
 */
@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class CourseTest {

  /* Fields */
  Course course;

  /**
   * Tests the default constructor.
   */
  @Test
  void testDefaultConstructor() {
    // Arrange & Act.
    course = new Course();

    // Assert.
    Assertions.assertEquals(0, course.getId());
    Assertions.assertNull(course.getModule());
    Assertions.assertNull(course.getStartDate());
    Assertions.assertNull(course.getEndDate());
    Assertions.assertNull(course.getOwner());
    Assertions.assertNull(course.getTasks());
    Assertions.assertEquals(DayOfWeek.MONDAY, course.getLectureWeekday());
    Assertions.assertEquals(LocalTime.of(0, 0), course.getLectureStartTime());
    Assertions.assertEquals(LocalTime.of(0, 0), course.getLectureEndTime());
    Assertions.assertEquals(DayOfWeek.MONDAY, course.getLabWeekday());
    Assertions.assertEquals(LocalTime.of(0, 0), course.getLabStartTime());
    Assertions.assertEquals(LocalTime.of(0, 0), course.getLabEndTime());

  } // end of testDefaultConstructor

  /**
   * Tests the custom constructor.
   */
  @Test
  void testCustomConstructor() {
    // Arrange.
    long id = 0L;
    Module module = new Module();
    LocalDate startDate = LocalDate.of(2023, 1, 1);
    LocalDate endDate = LocalDate.of(2023, 2, 1);
    AppUser owner = new AppUser();

    DayOfWeek lectureWeekday = DayOfWeek.MONDAY;
    LocalTime lectureStartTime = LocalTime.of(0, 0);
    LocalTime lectureEndTime = LocalTime.of(0, 0);
    DayOfWeek labWeekday = DayOfWeek.MONDAY;
    LocalTime labStartTime = LocalTime.of(0, 0);
    LocalTime labEndTime = LocalTime.of(0, 0);

    // Act.
    course = new Course(module, owner, startDate, endDate);

    // Assert.
    Assertions.assertEquals(id, course.getId());
    Assertions.assertEquals(module, course.getModule());
    Assertions.assertEquals(startDate, course.getStartDate());
    Assertions.assertEquals(endDate, course.getEndDate());
    Assertions.assertSame(owner, course.getOwner());
    Assertions.assertNull(course.getTasks());
    Assertions.assertEquals(lectureWeekday, course.getLectureWeekday());
    Assertions.assertEquals(lectureStartTime, course.getLectureStartTime());
    Assertions.assertEquals(lectureEndTime, course.getLectureEndTime());
    Assertions.assertEquals(labWeekday, course.getLabWeekday());
    Assertions.assertEquals(labStartTime, course.getLabStartTime());
    Assertions.assertEquals(labEndTime, course.getLabEndTime());
  } // end of testCustomConstructor

  @Test
  public void testGettersAndSetters() {

    // Arrange.
    long id = 1L;
    Module module = new Module();
    String moduleName = "TestModule";
    module.setName(moduleName);
    LocalDate startDate = LocalDate.of(2023, 1, 1);
    LocalDate endDate = LocalDate.of(2023, 2, 1);
    AppUser owner = new AppUser();
    List<Task> tasks = new ArrayList<>();
    DayOfWeek lectureWeekday = DayOfWeek.TUESDAY;
    LocalTime lectureStartTime = LocalTime.of(1, 1);
    LocalTime lectureEndTime = LocalTime.of(2, 2);
    DayOfWeek labWeekday = DayOfWeek.WEDNESDAY;
    LocalTime labStartTime = LocalTime.of(3, 3);
    LocalTime labEndTime = LocalTime.of(4, 4);

    // Act.
    course = new Course();
    course.setId(id);
    course.setModule(module);
    course.setStartDate(startDate);
    course.setEndDate(endDate);
    course.setOwner(owner);
    course.setTasks(tasks);
    course.setLectureWeekday(lectureWeekday);
    course.setLectureStartTime(lectureStartTime);
    course.setLectureEndTime(lectureEndTime);
    course.setLabWeekday(labWeekday);
    course.setLabStartTime(labStartTime);
    course.setLabEndTime(labEndTime);

    // Assert.
    Assertions.assertEquals(id, course.getId());
    Assertions.assertEquals(module, course.getModule());
    Assertions.assertEquals(startDate, course.getStartDate());
    Assertions.assertEquals(endDate, course.getEndDate());
    Assertions.assertSame(owner, course.getOwner());
    Assertions.assertSame(tasks, course.getTasks());
    Assertions.assertEquals(lectureWeekday, course.getLectureWeekday());
    Assertions.assertEquals(lectureStartTime, course.getLectureStartTime());
    Assertions.assertEquals(lectureEndTime, course.getLectureEndTime());
    Assertions.assertEquals(labWeekday, course.getLabWeekday());
    Assertions.assertEquals(labStartTime, course.getLabStartTime());
    Assertions.assertEquals(labEndTime, course.getLabEndTime());
    Assertions.assertEquals(moduleName, course.getName());
    Assertions.assertNull(course.getModuleId());

  } // end of testGettersAndSetters


  @Test
  public void testProgressEmptyTasks() {

    // Arrange.
    course = new Course();
    List<Task> tasks = new ArrayList<>();

    // Act.
    course.setTasks(tasks);

    // Assert.
    Assertions.assertEquals(0, course.getProgress());

  } // end of testProgressEmptyTasks


  @Test
  public void testProgressNullTasks() {

    // Arrange & Act.
    course = new Course();

    // Assert.
    Assertions.assertEquals(0, course.getProgress());

  } // end of testProgressNullTasks

  @Test
  public void testProgress0Percent() {

    // Arrange.
    course = new Course();
    List<Task> tasks = new ArrayList<>();
    Task task1 = new Task();
    task1.setDone(false);
    tasks.add(task1);
    Task task2 = new Task();
    task2.setDone(false);
    tasks.add(task2);

    // Act.
    course.setTasks(tasks);

    // Assert.
    Assertions.assertEquals(0, course.getProgress());

  } // end of testProgress0Percent

  @Test
  public void testProgress50Percent() {

    // Arrange.
    course = new Course();
    List<Task> tasks = new ArrayList<>();
    Task task1 = new Task();
    task1.setDone(false);
    tasks.add(task1);
    Task task2 = new Task();
    task2.setDone(true);
    tasks.add(task2);

    // Act.
    course.setTasks(tasks);

    // Assert.
    Assertions.assertEquals(50, course.getProgress());

  } // end of testProgress50Percent

} // end of class CourseTest