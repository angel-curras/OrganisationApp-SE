package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import jakarta.validation.Valid;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

/**
 * Represents a Course.
 *
 * @author Angel Curras Sanchez
 */
@Entity
@Valid
public class Course {

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

  @JsonProperty("start_date")
  LocalDate startDate;

  @JsonProperty("end_date")
  LocalDate endDate;

  @ManyToOne
  @JoinColumn(name = "user_name", referencedColumnName = "user_name", nullable = false)
  @JsonIgnore
  private AppUser owner;

  @OneToMany
  @JoinColumn(name = "course_id")
  @JsonIgnore
  private List<Task> tasks;

  private DayOfWeek lectureWeekday = DayOfWeek.MONDAY;
  private LocalTime lectureStartTime = LocalTime.of(0, 0);
  private LocalTime lectureEndTime = LocalTime.of(0, 0);

  private DayOfWeek labWeekday = DayOfWeek.MONDAY;
  private LocalTime labStartTime = LocalTime.of(0, 0);
  private LocalTime labEndTime = LocalTime.of(0, 0);

  /* Constructors */
  public Course() {
  } // end of constructor

  public Course(Module module, AppUser owner, LocalDate startDate, LocalDate endDate) {
    this.module = module;
    this.startDate = startDate;
    this.endDate = endDate;
    this.owner = owner;
  } // end of constructor


  /**
   * Getter for startDate.
   *
   * @return Gets the value of startDate and returns startDate.
   */
  public LocalDate getStartDate() {
    return this.startDate;
  } // end of getStartDate()

  /**
   * Sets the startDate.
   * You can use getStartDate() to get the value of startDate.
   */
  public void setStartDate(LocalDate startDate) {
    this.startDate = startDate;
  }

  /**
   * Getter for endDate.
   *
   * @return Gets the value of endDate and returns endDate.
   */
  public LocalDate getEndDate() {
    return this.endDate;
  } // end of getEndDate()

  /**
   * Sets the endDate.
   * You can use getEndDate() to get the value of endDate.
   */
  public void setEndDate(LocalDate endDate) {
    this.endDate = endDate;
  }

  /**
   * Getter for id.
   *
   * @return Gets the value of id and returns id.
   */
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
   * Getter for module.
   *
   * @return Gets the value of module and returns module.
   */
  public Module getModule() {
    return this.module;
  } // end of getModule()

  /**
   * Sets the module.
   * You can use getModule() to get the value of module.
   */
  public void setModule(Module module) {
    this.module = module;
  }

  /**
   * Getter for owner.
   *
   * @return Gets the value of owner and returns owner.
   */
  public AppUser getOwner() {
    return this.owner;
  } // end of getOwner()

  /**
   * Sets the owner.
   * You can use getOwner() to get the value of owner.
   */
  public void setOwner(AppUser owner) {
    this.owner = owner;
  }

  /**
   * Getter for tasks.
   *
   * @return Gets the value of tasks and returns tasks.
   */
  public List<Task> getTasks() {
    return this.tasks;
  } // end of getTasks()

  /**
   * Sets the tasks.
   * You can use getTasks() to get the value of tasks.
   */
  public void setTasks(List<Task> tasks) {
    this.tasks = tasks;
  }

  /**
   * Getter for lectureWeekday.
   *
   * @return Gets the value of lectureWeekday and returns lectureWeekday.
   */
  public DayOfWeek getLectureWeekday() {
    return this.lectureWeekday;
  } // end of getLectureWeekday()

  /**
   * Sets the lectureWeekday.
   * You can use getLectureWeekday() to get the value of lectureWeekday.
   */
  public void setLectureWeekday(DayOfWeek lectureWeekday) {
    this.lectureWeekday = lectureWeekday;
  }

  /**
   * Getter for lectureStartTime.
   *
   * @return Gets the value of lectureStartTime and returns lectureStartTime.
   */
  public LocalTime getLectureStartTime() {
    return this.lectureStartTime;
  } // end of getLectureStartTime()

  /**
   * Sets the lectureStartTime.
   * You can use getLectureStartTime() to get the value of lectureStartTime.
   */
  public void setLectureStartTime(LocalTime lectureStartTime) {
    this.lectureStartTime = lectureStartTime;
  }

  /**
   * Getter for lectureEndTime.
   *
   * @return Gets the value of lectureEndTime and returns lectureEndTime.
   */
  public LocalTime getLectureEndTime() {
    return this.lectureEndTime;
  } // end of getLectureEndTime()

  /**
   * Sets the lectureEndTime.
   * You can use getLectureEndTime() to get the value of lectureEndTime.
   */
  public void setLectureEndTime(LocalTime lectureEndTime) {
    this.lectureEndTime = lectureEndTime;
  }

  /**
   * Getter for labWeekday.
   *
   * @return Gets the value of labWeekday and returns labWeekday.
   */
  public DayOfWeek getLabWeekday() {
    return this.labWeekday;
  } // end of getLabWeekday()

  /**
   * Sets the labWeekday.
   * You can use getLabWeekday() to get the value of labWeekday.
   */
  public void setLabWeekday(DayOfWeek labWeekday) {
    this.labWeekday = labWeekday;
  }

  /**
   * Getter for labStartTime.
   *
   * @return Gets the value of labStartTime and returns labStartTime.
   */
  public LocalTime getLabStartTime() {
    return this.labStartTime;
  } // end of getLabStartTime()

  /**
   * Sets the labStartTime.
   * You can use getLabStartTime() to get the value of labStartTime.
   */
  public void setLabStartTime(LocalTime labStartTime) {
    this.labStartTime = labStartTime;
  }

  /**
   * Getter for labEndTime.
   *
   * @return Gets the value of labEndTime and returns labEndTime.
   */
  public LocalTime getLabEndTime() {
    return this.labEndTime;
  } // end of getLabEndTime()

  /**
   * Sets the labEndTime.
   * You can use getLabEndTime() to get the value of labEndTime.
   */
  public void setLabEndTime(LocalTime labEndTime) {
    this.labEndTime = labEndTime;
  }

  /**
   * Getter for module id.
   * .
   *
   * @return Gets the value of the module id and returns the module id.
   */
  @JsonIgnore
  public Long getModuleId() {
    return this.module.getId();
  } // end of getModuleId()

  /**
   * Getter for name.
   *
   * @return Gets the value of name and returns name.
   */
  @JsonProperty("course_name")
  public String getName() {
    return this.module.getName();
  } // end of getName()

  /**
   * Getter for progress.
   *
   * @return Gets the value of progress and returns progress.
   */
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