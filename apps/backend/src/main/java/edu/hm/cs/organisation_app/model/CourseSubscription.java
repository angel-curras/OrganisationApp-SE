package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Represents a CourseSubscription.
 *
 * @author Angel Curras Sanchez
 */
public class CourseSubscription {

  /* Fields */
  @JsonProperty("module_id")
  private Long moduleId;

  @JsonProperty("user_name")
  private String userName;


  /* Constructors */
  public CourseSubscription() {
  } // end of constructor

  public CourseSubscription(Long moduleId, String userName) {
    this.moduleId = moduleId;
    this.userName = userName;
  } // end of constructor

  /* Getters and Setters */

  /**
   * Getter for moduleId.
   *
   * @return Gets the value of moduleId and returns moduleId.
   */
  public Long getModuleId() {
    return this.moduleId;
  } // end of getModuleId()

  /**
   * Getter for userName.
   *
   * @return Gets the value of userName and returns userName.
   */
  public String getUserName() {
    return this.userName;
  } // end of getUserName()

  /* Methods */

  @Override
  public String toString() {
    return "CourseSubscription{" +
            "moduleId=" + moduleId +
            ", userName='" + userName + '\'' +
            '}';
  }
} // end of class CourseSubscription