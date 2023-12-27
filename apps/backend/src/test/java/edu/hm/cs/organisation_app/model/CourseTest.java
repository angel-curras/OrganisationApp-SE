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
    Assertions.assertNull(course.getLectureWeekday());
    Assertions.assertNull(course.getLectureStartTime());
    Assertions.assertNull(course.getLectureEndTime());
    Assertions.assertNull(course.getLabWeekday());
    Assertions.assertNull(course.getLabStartTime());
    Assertions.assertNull(course.getLabEndTime());

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

    // Act.
    course = new Course(module, owner, startDate, endDate);

    // Assert.
    Assertions.assertEquals(id, course.getId());
    Assertions.assertEquals(module, course.getModule());
    Assertions.assertEquals(startDate, course.getStartDate());
    Assertions.assertEquals(endDate, course.getEndDate());
    Assertions.assertSame(owner, course.getOwner());
    Assertions.assertNull(course.getTasks());
    Assertions.assertNull(course.getLectureWeekday());
    Assertions.assertNull(course.getLectureStartTime());
    Assertions.assertNull(course.getLectureEndTime());
    Assertions.assertNull(course.getLabWeekday());
    Assertions.assertNull(course.getLabStartTime());
    Assertions.assertNull(course.getLabEndTime());
  } // end of testCustomConstructor

  @Test
  public void testGettersAndSetters() {

    // Arrange.
    long id = 1L;
    Module module = new Module();
    String moduleName = "TestModule";
    String moduleResponsible = "TestResponsible";
    module.setName(moduleName);
    module.setVerantwortlich(moduleResponsible);
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
    Assertions.assertEquals(moduleResponsible, course.getResponsible());
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


  /**
   * Tests the toString method.
   */
  @Test
  void testToString() {
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
    String expectedModule = "Module{id=" + module.getId() + ", name='" + moduleName + "', " +
            "verantwortlich='" + module.getVerantwortlich() + "'}";

    Assertions.assertEquals("Course{" +
            "id=" + id +
            ", module=" + expectedModule +
            ", startDate=" + startDate +
            ", endDate=" + endDate +
            ", owner=" + owner +
            ", lectureWeekday=" + lectureWeekday +
            ", lectureStartTime=" + lectureStartTime +
            ", lectureEndTime=" + lectureEndTime +
            ", labWeekday=" + labWeekday +
            ", labStartTime=" + labStartTime +
            ", labEndTime=" + labEndTime +
            '}', course.toString());
  } // end of testToString


  /**
   * Tests the toString method with module null.
   */
  @Test
  void testToStringModuleNull() {
    // Arrange.
    long id = 1L;
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
    Assertions.assertEquals("Course{" +
            "id=" + id +
            ", module=null" +
            ", startDate=" + startDate +
            ", endDate=" + endDate +
            ", owner=" + owner +
            ", lectureWeekday=" + lectureWeekday +
            ", lectureStartTime=" + lectureStartTime +
            ", lectureEndTime=" + lectureEndTime +
            ", labWeekday=" + labWeekday +
            ", labStartTime=" + labStartTime +
            ", labEndTime=" + labEndTime +
            '}', course.toString());
  } // end of testToString


  /**
   * Tests the starting date from a weekday
   */
  @Test
  void testGetStartingDateFromWeekday() {
    // Arrange.
    course = new Course();
    LocalDate startDate = LocalDate.of(2023, 12, 25);

    // Act.
    LocalDate startingDate1 = course.getStartDateFromWeekday(startDate, DayOfWeek.MONDAY);
    LocalDate startingDate2 = course.getStartDateFromWeekday(startDate, DayOfWeek.TUESDAY);
    LocalDate startingDate3 = course.getStartDateFromWeekday(startDate, DayOfWeek.WEDNESDAY);
    LocalDate startingDate4 = course.getStartDateFromWeekday(startDate, DayOfWeek.THURSDAY);
    LocalDate startingDate5 = course.getStartDateFromWeekday(startDate, DayOfWeek.FRIDAY);
    LocalDate startingDate6 = course.getStartDateFromWeekday(startDate, DayOfWeek.SATURDAY);
    LocalDate startingDate7 = course.getStartDateFromWeekday(startDate, DayOfWeek.SUNDAY);

    // Assert.
    Assertions.assertEquals(LocalDate.of(2023, 12, 25), startingDate1);
    Assertions.assertEquals(LocalDate.of(2023, 12, 26), startingDate2);
    Assertions.assertEquals(LocalDate.of(2023, 12, 27), startingDate3);
    Assertions.assertEquals(LocalDate.of(2023, 12, 28), startingDate4);
    Assertions.assertEquals(LocalDate.of(2023, 12, 29), startingDate5);
    Assertions.assertEquals(LocalDate.of(2023, 12, 30), startingDate6);
    Assertions.assertEquals(LocalDate.of(2023, 12, 31), startingDate7);

  } // end of testGetStartingDateFromWeekday


  /**
   * Tests the generation of tasks from null dates.
   */
  @Test
  void testGenerateTaskNullDates() {

    // Arrange.
    course = new Course();
    course.setStartDate(LocalDate.of(2023, 12, 5));
    course.setEndDate(LocalDate.of(2023, 12, 20));
    List<Task> tasks;

    // Act.
    tasks = course.generateTasksForEventName("Name", DayOfWeek.WEDNESDAY,
            LocalTime.now(), null);
    // Assert.
    Assertions.assertEquals(0, tasks.size());

    // Act.
    tasks = course.generateTasksForEventName("Name", DayOfWeek.WEDNESDAY,
            null, null);
    // Assert.
    Assertions.assertEquals(0, tasks.size());

    // Act.
    tasks = course.generateTasksForEventName("Name", null,
            null, null);
    // Assert.
    Assertions.assertEquals(0, tasks.size());

    // Act.
    course.setEndDate(null);
    tasks = course.generateTasksForEventName("Name", null,
            null, null);
    // Assert.
    Assertions.assertEquals(0, tasks.size());

    // Act.
    course.setStartDate(null);
    tasks = course.generateTasksForEventName("Name", null,
            null, null);
    // Assert.
    Assertions.assertEquals(0, tasks.size());

  } // end of testGenerateTaskNullDates


  /**
   * Tests the generation of tasks.
   */
  @Test
  void testGenerateTask() {

    // Arrange.
    course = new Course();
    course.setStartDate(LocalDate.of(2023, 12, 5));
    course.setEndDate(LocalDate.of(2023, 12, 20));

    // Act.
    List<Task> tasks = course.generateTasksForEventName("Name", DayOfWeek.WEDNESDAY,
            LocalTime.of(1, 2), LocalTime.of(3, 4));

    // Assert.
    Assertions.assertEquals(2, tasks.size());
    Assertions.assertEquals("Name [2023-12-06]", tasks.get(0).getName());
    Assertions.assertEquals(DayOfWeek.WEDNESDAY, tasks.get(0).getCalendarEvent().getDate().getDayOfWeek());
    Assertions.assertEquals(LocalTime.of(1, 2), tasks.get(0).getCalendarEvent().getStartTime());
    Assertions.assertEquals(LocalTime.of(3, 4), tasks.get(0).getCalendarEvent().getEndTime());
    Assertions.assertEquals("Name [2023-12-13]", tasks.get(1).getName());
    Assertions.assertEquals(DayOfWeek.WEDNESDAY, tasks.get(1).getCalendarEvent().getDate().getDayOfWeek());
    Assertions.assertEquals(LocalTime.of(1, 2), tasks.get(1).getCalendarEvent().getStartTime());
    Assertions.assertEquals(LocalTime.of(3, 4), tasks.get(1).getCalendarEvent().getEndTime());

  } // end of testGenerateTask


} // end of class CourseTest