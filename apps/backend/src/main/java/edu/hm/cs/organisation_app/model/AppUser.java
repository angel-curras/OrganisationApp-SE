package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

import java.util.List;

/**
 * Represents an AppUser.
 *
 * @author Angel Curras Sanchez
 */
@Entity
@Valid
public class AppUser {

  /* Fields */
  @Id
  @NotNull(message = "Username is mandatory")
  @JsonProperty("user_name")
  @Column(name = "USER_NAME")
  private String userName;

  @NotNull(message = "The full name is mandatory")
  @JsonProperty("full_name")
  @Column(name = "FULL_NAME")
  private String fullName;

  @NotNull(message = "The user type is mandatory")
  @JsonProperty("user_type")
  @Column(name = "USER_TYPE")
  private String userType;

  @OneToMany(mappedBy = "owner")
  private List<Course> courses;

  @OneToMany
  private List<Task> tasks;

  /* Constructors */

  /**
   * Constructor for AppUser.
   */
  public AppUser() {
  } // end of constructor

  /**
   * Constructor for User.
   *
   * @param userName The username.
   * @param fullName The full name.
   * @param userType The user type.
   */
  public AppUser(String userName, String fullName, String userType) {
    this.userName = userName;
    this.fullName = fullName;
    this.userType = userType;
  } // end of constructor

  /* Getters and Setters */

  /**
   * Getter for userName.
   *
   * @return Gets the value of userName and returns userName.
   */
  public String getUserName() {
    return this.userName;
  } // end of getUserName()

  /**
   * Sets the userName.
   * You can use getUserName() to get the value of userName.
   */
  public void setUserName(String userName) {
    this.userName = userName;
  }

  /**
   * Getter for fullName.
   *
   * @return Gets the value of fullName and returns fullName.
   */
  public String getFullName() {
    return this.fullName;
  } // end of getFullName()

  /**
   * Sets the fullName.
   * You can use getFullName() to get the value of fullName.
   */
  public void setFullName(String fullName) {
    this.fullName = fullName;
  }

  /**
   * Getter for userType.
   *
   * @return Gets the value of userType and returns userType.
   */
  public String getUserType() {
    return this.userType;
  } // end of getUserType()

  /**
   * Sets the userType.
   * You can use getUserType() to get the value of userType.
   */
  public void setUserType(String userType) {
    this.userType = userType;
  }

  /**
   * Getter for courses.
   *
   * @return Gets the value of courses and returns courses.
   */
  public List<Course> getCourses() {
    return this.courses;
  } // end of getCourses()

  /**
   * Sets the courses.
   * You can use getCourses() to get the value of courses.
   */
  public void setCourses(List<Course> courses) {
    this.courses = courses;
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

  /* Methods */

  /**
   * Adds a course to the list of courses.
   *
   * @param course The course to be added.
   */
  public void addCourse(Course course) {
    this.courses.add(course);
  } // end of addCourse

  @Override
  public String toString() {
    return "AppUser{" +
            "userName='" + userName + '\'' +
            ", fullName='" + fullName + '\'' +
            ", userType='" + userType + '\'' +
            '}';
  } // end of toString
  
} // end of class User