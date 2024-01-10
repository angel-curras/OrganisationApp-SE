package edu.hm.cs.organisation_app.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import java.time.LocalDate;

import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

/**
 * Represents a TaskTest.
 *
 * @author Angel Curras Sanchez
 */
@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class TaskTest {

  /* Fields */
  Task task;

  /**
   * Tests the default constructor.
   */
  @Test
  void testDefaultConstructor() {
    // Arrange & Act.
    task = new Task();

    // Assert.
    Assertions.assertEquals(0, task.getId());
    Assertions.assertNull(task.getName());
    Assertions.assertEquals(3, task.getPriority());
    Assertions.assertFalse(task.isDone());
    Assertions.assertEquals(FrequencyType.ONCE, task.getFrequency());
    Assertions.assertNull(task.getCalendarEvent());
    Assertions.assertNull(task.getDeadline());

  } // end of testDefaultConstructor

  /**
   * Tests the custom constructor.
   */
  @Test
  void testCustomConstructor() {
    // Arrange.
    String name = "Task";
    CalendarEvent calendarEvent = new CalendarEvent();

    // Act.
    task = new Task(name, calendarEvent);

    // Assert.
    Assertions.assertEquals(0, task.getId());
    Assertions.assertEquals(name, task.getName());
    Assertions.assertEquals(3, task.getPriority());
    Assertions.assertFalse(task.isDone());
    Assertions.assertSame(FrequencyType.ONCE, task.getFrequency());
    Assertions.assertSame(calendarEvent, task.getCalendarEvent());
    Assertions.assertNull(task.getDeadline());

  } // end of testCustomConstructor

  @Test
  public void testGettersAndSetters() {
    // Arrange.
    long id = 1;
    String name = "Task";
    int priority = 2;
    boolean done = true;
    FrequencyType frequency = FrequencyType.DAILY;
    CalendarEvent calendarEvent = new CalendarEvent();
    LocalDate deadline = LocalDate.now();

    // Act.
    task = new Task();
    task.setId(id);
    task.setName(name);
    task.setPriority(priority);
    task.setDone(done);
    task.setFrequency(frequency);
    task.setCalendarEvent(calendarEvent);
    task.setDeadline(deadline);

    // Assert.
    Assertions.assertEquals(id, task.getId());
    Assertions.assertEquals(name, task.getName());
    Assertions.assertEquals(priority, task.getPriority());
    Assertions.assertEquals(done, task.isDone());
    Assertions.assertSame(frequency, task.getFrequency());
    Assertions.assertSame(calendarEvent, task.getCalendarEvent());
    Assertions.assertSame(deadline, task.getDeadline());
  } // end of testGettersAndSetters

  @Test
  void getAppUsertest() {
    // Arrange.
    AppUser appUser = new AppUser();
    Task task = new Task();
    task.setAppUser(appUser);

    // Act.
    AppUser result = task.getAppUser();

    // Assert.
    Assertions.assertEquals(appUser, result);
  } // end of getAppUsertest

  @Test
  void getCourseTest() {
    // Arrange.
    Course course = new Course();
    Task task = new Task();
    task.setCourse(course);

    // Act.
    Course result = task.getCourse();

    // Assert.
    Assertions.assertEquals(course, result);
  } // end of getCourseTest

  @Test
  void getDateTest() {

    // Arrange.
    CalendarEvent calendarEvent = new CalendarEvent();
    calendarEvent.setDate(LocalDate.now());
    Task task = new Task();

    //Assert that the date is null.
    Assertions.assertNull(task.getDate());

    // More Arrange.
    task.setCalendarEvent(calendarEvent);

    // Act.
    String result = task.getDate();

    // Assert.
    Assertions.assertEquals(LocalDate.now().toString(), result);
  } // end of getDateTest
} // end of class TaskTest