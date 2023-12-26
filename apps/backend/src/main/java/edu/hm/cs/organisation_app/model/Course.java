package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import jakarta.validation.Valid;

import java.time.LocalDate;
import java.util.List;

/**
 * Represents a Course.
 *
 * @author Angel Curras Sanchez
 */
@Entity
@Valid
public class Course {

  @JsonProperty("start_date")
  LocalDate startDate;

  @JsonProperty("end_date")
  LocalDate endDate;

  /* Fields */
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "course_id")
  @JsonProperty("course_id")
  private long id;

  @ManyToOne
  @JoinColumn(name = "module_id")
  @JsonIgnore
  private Module module;

  @ManyToOne
  @JoinColumn(name = "user_name", referencedColumnName = "user_name", nullable = false)
  @JsonIgnore
  private AppUser owner;

  @OneToMany
  @JoinColumn(name = "course_id")
  @JsonIgnore
  private List<Task> tasks;

  @OneToOne
  @JsonProperty("lecture")
  private UniversityEvent lecture;
  
  @OneToOne
  @JsonProperty("lab")
  private UniversityEvent lab;

  /* Constructors */
  public Course() {
  } // end of constructor

  public Course(Module module, AppUser owner, LocalDate startDate, LocalDate endDate) {
    this.module = module;
    this.owner = owner;
    this.startDate = startDate;
    this.endDate = endDate;
  } // end of constructor

  public Course(Module module, AppUser owner, LocalDate startDate, LocalDate endDate, List<Task> tasks) {
    this(module, owner, startDate, endDate);
    this.tasks = tasks;
  } // end of constructor


  /* Getters and Setters */
  public long getId() {
    return this.id;
  } // end of getId()

  @JsonProperty("course_name")
  public String getName() {
    return this.module.getName();
  } // end of getName()


  @JsonIgnore
  public Long getModuleId() {
    return this.module.getId();
  } // end of getModuleId()

  @JsonIgnore
  public List<Task> getTasks() {
    return this.tasks;
  } // end of getTasks()

  @JsonProperty("progress")
  public int getProgress() {
    int doneTasks = 0;
    for (Task task : this.tasks) {
      if (task.isDone()) {
        doneTasks++;
      } // end of if
    } // end of for
    return (int) ((doneTasks / (double) this.tasks.size()) * 100);
  } // end of getProgress()
  /* Methods */


} // end of class Course