package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

import java.util.ArrayList;
import java.util.List;

/**
 * Represents a User.
 *
 * @author Angel Curras Sanchez
 */
@Entity
@Valid
public class AppUser {

  @OneToMany(mappedBy = "owner")
  private List<Course> courses;
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

  /* Constructors */

  /**
   * Constructor for User.
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
    this.courses = new ArrayList<>();
  } // end of constructor

  /* Getters and Setters */

  /**
   * Getter for username.
   *
   * @return Gets the value of username and returns username.
   */
  public String getUserName() {
    return this.userName;
  } // end of getUsername()

  /**
   * Sets the username.
   * You can use getUsername() to get the value of username.
   */
  @Transactional
  public void setUserName(String username) {
    this.userName = username;
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
  @Transactional
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
  @Transactional
  public void setUserType(String userType) {
    this.userType = userType;
  }

  /* Methods */
  public void addCourse(Course course) {
    this.courses.add(course);
  }

  public List<Course> getCourses() {
    return this.courses;
  }

  @Override
  public String toString() {
    return "AppUser{" +
            "userName='" + userName + '\'' +
            ", fullName='" + fullName + '\'' +
            ", userType='" + userType + '\'' +
            '}';
  }
} // end of class User