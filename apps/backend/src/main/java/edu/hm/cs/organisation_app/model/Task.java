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
    this.priority = 5;
    this.done = false;
  } // end of constructor

  public Task(String name, CalendarEvent calendarEvent) {
    this(name);
    this.calendarEvent = calendarEvent;
  } // end of constructor

  public void setCalendarEvent(CalendarEvent calendarEvent) {
    this.calendarEvent = calendarEvent;
  }


  /* Getters and Setters */

  public void setId(long id) {
    this.id = id;
  }

  public void setName(String name) {
    this.name = name;
  }

  public void setPriority(int priority) {
    this.priority = priority;
  }

  public void setDone(boolean done) {
    this.done = done;
  }

  public void setFrequency(String frequency) {
    this.frequency = frequency;
  }

  public void setDeadline(Date deadline) {
    this.deadline = deadline;
  }

  public long getId() {
    return id;
  }

  public String getName() {
    return name;
  }

  public int getPriority() {
    return priority;
  }

  public String getFrequency() {
    return frequency;
  }

  public CalendarEvent getCalendarEvent() {
    return calendarEvent;
  }

  public Date getDeadline() {
    return deadline;
  }

  /**
   * Getter for done.
   *
   * @return Gets the value of done and returns done.
   */


  public boolean isDone() {
    return this.done;
  } // end of getDone()
  /* Methods */


} // end of class Task