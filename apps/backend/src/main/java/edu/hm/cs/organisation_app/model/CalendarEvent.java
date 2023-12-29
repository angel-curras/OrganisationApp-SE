package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * Represents a CalendarEvent.
 *
 * @author Angel Curras Sanchez
 */
@Entity
public class CalendarEvent {

  /* Fields */
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "CALENDAR_EVENT_ID")
  private long id;

  @JsonProperty("title")
  private String title;

  @JsonProperty("date")
  private LocalDate date;

  @JsonProperty("start_time")
  private LocalTime startTime;

  @JsonProperty("end_time")
  private LocalTime endTime;

  @OneToOne
  private Task task;

  /* Constructors */
  public CalendarEvent() {
  } // end of constructor


  public CalendarEvent(String title, LocalDate date, LocalTime startTime, LocalTime endTime, Task task) {
    this.title = title;
    this.date = date;
    this.startTime = startTime;
    this.endTime = endTime;
    this.task = task;
  } // end of constructor

  /* Getters and Setters */

  /**
   * Getter for id.
   *
   * @return Gets the value of id and returns id.
   */
  public long getId() {
    return id;
  }

  /**
   * Sets the id.
   * You can use getId() to get the value of id.
   */
  public void setId(long id) {
    this.id = id;
  }

  /**
   * Getter for title.
   *
   * @return Gets the value of title and returns title.
   */
  public String getTitle() {
    return this.title;
  } // end of getTitle()

  /**
   * Sets the title.
   * You can use getTitle() to get the value of title.
   */
  public void setTitle(String title) {
    this.title = title;
  }

  /**
   * Getter for date.
   *
   * @return Gets the value of date and returns date.
   */
  public LocalDate getDate() {
    return this.date;
  } // end of getDate()

  /**
   * Sets the date.
   * You can use getDate() to get the value of date.
   */
  public void setDate(LocalDate date) {
    this.date = date;
  }

  /**
   * Getter for startTime.
   *
   * @return Gets the value of startTime and returns startTime.
   */
  public LocalTime getStartTime() {
    return this.startTime;
  } // end of getStartTime()

  /**
   * Sets the startTime.
   * You can use getStartTime() to get the value of startTime.
   */
  public void setStartTime(LocalTime startTime) {
    this.startTime = startTime;
  }

  /**
   * Getter for endTime.
   *
   * @return Gets the value of endTime and returns endTime.
   */
  public LocalTime getEndTime() {
    return this.endTime;
  } // end of getEndTime()

  /**
   * Sets the endTime.
   * You can use getEndTime() to get the value of endTime.
   */
  public void setEndTime(LocalTime endTime) {
    this.endTime = endTime;
  }

  /**
   * Getter for task.
   *
   * @return Gets the value of task and returns task.
   */
  public Task getTask() {
    return this.task;
  } // end of getTask()

  /**
   * Sets the task.
   * You can use getTask() to get the value of task.
   */
  public void setTask(Task task) {
    this.task = task;
  }

  /* Methods */


} // end of class CalendarEvent