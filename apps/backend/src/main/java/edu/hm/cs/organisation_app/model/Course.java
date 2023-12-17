package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import jakarta.validation.Valid;

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
  private Module module;

  @ManyToOne
  @JoinColumn(name = "user_name", referencedColumnName = "user_name", nullable = false)
  private AppUser owner;

  @OneToMany
  @JoinColumn(name = "course_id")
  private List<Task> tasks;

  /* Constructors */
  public Course() {
  } // end of constructor

  public Course(Module module, AppUser owner) {
    this.module = module;
    this.owner = owner;
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
  /* Methods */


} // end of class Course