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

  public CalendarEvent(String title, LocalDate date) {
    this.title = title;
    this.date = date;
  } // end of constructor

  public CalendarEvent(String title, LocalDate date, LocalTime startTime, LocalTime endTime) {
    this.title = title;
    this.date = date;
    this.startTime = startTime;
    this.endTime = endTime;
  } // end of constructor

  public CalendarEvent(String title, LocalDate date, LocalTime startTime, LocalTime endTime, Task task) {
    this(title, date, startTime, endTime);
    this.task = task;
  } // end of constructor

  /* Getters and Setters */


  /* Methods */


} // end of class CalendarEvent