package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

import java.util.Date;

/**
 * Represents a Task.
 *
 * @author Angel Curras Sanchez
 */
@Entity
public class Task {

  /* Fields */
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "task_id")
  private long id;

  @JsonProperty("task_name")
  private String name;

  @JsonProperty("priority")
  private int priority;

  @Column(name = "is_done")
  @JsonProperty("is_done")
  private boolean done;

  @JsonProperty("frequency")
  private String frequency;

  @OneToOne
  private CalendarEvent calendarEvent;

  @JsonProperty("deadline")
  private Date deadline;


  /* Constructors */
  public Task() {
  } // end of constructor

  public Task(String name) {
    this.name = name;
    this.priority = 3;
    this.done = false;
  } // end of constructor

  public Task(String name, CalendarEvent calendarEvent) {
    this(name);
    this.calendarEvent = calendarEvent;
  } // end of constructor

  public long getId() {
    return id;
  }

  /* Getters and Setters */

  public void setId(long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public int getPriority() {
    return priority;
  }

  public void setPriority(int priority) {
    this.priority = priority;
  }

  public String getFrequency() {
    return frequency;
  }

  public void setFrequency(String frequency) {
    this.frequency = frequency;
  }

  public CalendarEvent getCalendarEvent() {
    return calendarEvent;
  }

  public void setCalendarEvent(CalendarEvent calendarEvent) {
    this.calendarEvent = calendarEvent;
  }

  public Date getDeadline() {
    return deadline;
  }

  public void setDeadline(Date deadline) {
    this.deadline = deadline;
  }

  /**
   * Getter for done.
   *
   * @return Gets the value of done and returns done.
   */


  public boolean isDone() {
    return this.done;
  } // end of getDone()

  public void setDone(boolean done) {
    this.done = done;
  }
  /* Methods */


} // end of class Task