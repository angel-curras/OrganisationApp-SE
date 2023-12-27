package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

import java.time.LocalDate;

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
  @JsonProperty("task_id")
  private long id;

  @JsonProperty("task_name")
  private String name;

  @JsonProperty("priority")
  private int priority = 3;

  @Column(name = "is_done")
  @JsonProperty("is_done")
  private boolean done;

  @JsonProperty("frequency")
  @Enumerated(EnumType.STRING)
  private FrequencyType frequency = FrequencyType.ONCE;

  @OneToOne(mappedBy = "task", cascade = CascadeType.ALL)
  private CalendarEvent calendarEvent;

  @JsonProperty("deadline")
  private LocalDate deadline;


  /* Constructors */
  public Task() {
  } // end of constructor

  public Task(String name) {
    this.name = name;
  } // end of constructor

  public Task(String name, CalendarEvent calendarEvent) {
    this(name);
    this.calendarEvent = calendarEvent;
  } // end of constructor


  /* Getters and Setters */

  /**
   * Getter for id.
   *
   * @return Gets the value of id and returns id.
   */
  @JsonIgnore
  public long getId() {
    return this.id;
  } // end of getId()

  /**
   * Sets the id.
   * You can use getId() to get the value of id.
   */
  public void setId(long id) {
    this.id = id;
  }

  /**
   * Getter for name.
   *
   * @return Gets the value of name and returns name.
   */
  @JsonIgnore
  public String getName() {
    return this.name;
  } // end of getName()

  /**
   * Sets the name.
   * You can use getName() to get the value of name.
   */
  public void setName(String name) {
    this.name = name;
  }

  /**
   * Getter for priority.
   *
   * @return Gets the value of priority and returns priority.
   */
  @JsonIgnore
  public int getPriority() {
    return this.priority;
  } // end of getPriority()

  /**
   * Sets the priority.
   * You can use getPriority() to get the value of priority.
   */
  public void setPriority(int priority) {
    this.priority = priority;
  }

  /**
   * Getter for done.
   *
   * @return Gets the value of done and returns done.
   */
  @JsonIgnore
  public boolean isDone() {
    return this.done;
  } // end of getDone()

  /**
   * Sets the done.
   * You can use getDone() to get the value of done.
   */
  public void setDone(boolean done) {
    this.done = done;
  }

  /**
   * Getter for frequency.
   *
   * @return Gets the value of frequency and returns frequency.
   */
  @JsonIgnore
  public FrequencyType getFrequency() {
    return this.frequency;
  } // end of getFrequency()

  /**
   * Sets the frequency.
   * You can use getFrequency() to get the value of frequency.
   */
  public void setFrequency(FrequencyType frequency) {
    this.frequency = frequency;
  }

  /**
   * Getter for calendarEvent.
   *
   * @return Gets the value of calendarEvent and returns calendarEvent.
   */
  @JsonIgnore
  public CalendarEvent getCalendarEvent() {
    return this.calendarEvent;
  } // end of getCalendarEvent()

  /**
   * Sets the calendarEvent.
   * You can use getCalendarEvent() to get the value of calendarEvent.
   */
  public void setCalendarEvent(CalendarEvent calendarEvent) {
    this.calendarEvent = calendarEvent;
  }

  /**
   * Getter for deadline.
   *
   * @return Gets the value of deadline and returns deadline.
   */
  @JsonIgnore
  public LocalDate getDeadline() {
    return this.deadline;
  } // end of getDeadline()

  /**
   * Sets the deadline.
   * You can use getDeadline() to get the value of deadline.
   */
  public void setDeadline(LocalDate deadline) {
    this.deadline = deadline;
  }

  /* Methods */
  @JsonProperty("date")
  public String getDate() {

    if (this.calendarEvent == null) {
      return null;
    }
    return this.calendarEvent.getDate().toString();
  }


} // end of class Task