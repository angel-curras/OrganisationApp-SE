package edu.hm.cs.organisation_app.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import java.time.LocalDate;
import java.time.LocalTime;

import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

/**
 * Represents a CalendarEventTest.
 *
 * @author Angel Curras Sanchez
 */
@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class CalendarEventTest {

  /* Fields */
  private CalendarEvent calendarEvent;

  /**
   * Tests the default constructor.
   */
  @Test
  void testDefaultConstructor() {

    // Arrange & Act
    calendarEvent = new CalendarEvent();

    // Assert
    Assertions.assertEquals(0, calendarEvent.getId());
    Assertions.assertNull(calendarEvent.getTitle());
    Assertions.assertNull(calendarEvent.getDate());
    Assertions.assertNull(calendarEvent.getStartTime());
    Assertions.assertNull(calendarEvent.getEndTime());
    Assertions.assertNull(calendarEvent.getTask());
  } // end of testDefaultConstructor()

  /**
   * Tests the custom constructor.
   */
  @Test
  void testCustomConstructor() {

    // Arrange.
    String title = "Event Title";
    LocalDate date = LocalDate.of(2023, 1, 1);
    LocalTime startTime = LocalTime.of(10, 0);
    LocalTime endTime = LocalTime.of(11, 0);
    Task task = new Task("Task Title");

    // Act.
    calendarEvent = new CalendarEvent(title, date, startTime, endTime, task);

    // Assert.
    Assertions.assertEquals(0, calendarEvent.getId());
    Assertions.assertEquals(title, calendarEvent.getTitle());
    Assertions.assertEquals(date, calendarEvent.getDate());
    Assertions.assertEquals(startTime, calendarEvent.getStartTime());
    Assertions.assertEquals(endTime, calendarEvent.getEndTime());
    Assertions.assertEquals(task, calendarEvent.getTask());
  } // end of testCustomConstructor()

 
  /**
   * Tests the setters.
   */
  @Test
  public void testSetters() {

    // Arrange.
    calendarEvent = new CalendarEvent();
    int id = 1;
    String title = "Event Title";
    LocalDate date = LocalDate.of(2023, 1, 1);
    LocalTime startTime = LocalTime.of(10, 0);
    LocalTime endTime = LocalTime.of(11, 0);
    Task task = new Task("Task Title");

    // Act.
    calendarEvent.setId(id);
    calendarEvent.setTitle(title);
    calendarEvent.setDate(date);
    calendarEvent.setStartTime(startTime);
    calendarEvent.setEndTime(endTime);
    calendarEvent.setTask(task);

    // Assert.
    Assertions.assertEquals(id, calendarEvent.getId());
    Assertions.assertEquals(title, calendarEvent.getTitle());
    Assertions.assertEquals(date, calendarEvent.getDate());
    Assertions.assertEquals(startTime, calendarEvent.getStartTime());
    Assertions.assertEquals(endTime, calendarEvent.getEndTime());
    Assertions.assertEquals(task, calendarEvent.getTask());

  } // end of testSetters()


} // end of class CalendarEventTest