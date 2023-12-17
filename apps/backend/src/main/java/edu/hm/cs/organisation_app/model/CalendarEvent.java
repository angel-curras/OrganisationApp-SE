package edu.hm.cs.organisation_app.model;

import jakarta.persistence.*;

import java.time.LocalTime;
import java.util.Date;

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
  private String title;
  private Date date;

  private LocalTime startTime;
  private LocalTime endTime;

  @OneToOne
  private Task task;

  /* Constructors */
  public CalendarEvent() {
  } // end of constructor


  /* Getters and Setters */


  /* Methods */


} // end of class CalendarEvent