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


} // end of class CourseSubscription