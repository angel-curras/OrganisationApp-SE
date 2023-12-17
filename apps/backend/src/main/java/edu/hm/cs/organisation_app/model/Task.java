package edu.hm.cs.organisation_app.model;

import jakarta.persistence.*;

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

  private String name;
  private int priority;

  @Column(name = "is_done")
  private boolean isDone;

  @ManyToOne
  @JoinColumn(name = "course_id")
  private Course course;

  @OneToOne
  private CalendarEvent calendarEvent;


  /* Constructors */
  public Task() {
  } // end of constructor


  /* Getters and Setters */


  /* Methods */


} // end of class Task