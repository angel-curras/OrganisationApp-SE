package edu.hm.cs.organisation_app.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

/**
 * Represents a User.
 *
 * @author Angel Curras Sanchez
 */
@Entity
@Valid
public class AppUser {

  /* Fields */
  @Id
  @NotNull(message = "Username is mandatory")
  private String userName;

  @NotNull(message = "The full name is mandatory")
  private String fullName;

  @NotNull(message = "The user type is mandatory")
  private String userType;

  /* Constructors */


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


} // end of class User