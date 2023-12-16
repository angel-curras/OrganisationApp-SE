package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonProperty;
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
  @JsonProperty("user_name")
  private String userName;

  @NotNull(message = "The full name is mandatory")
  @JsonProperty("full_name")
  private String fullName;

  @NotNull(message = "The user type is mandatory")
  @JsonProperty("user_type")
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

  @Override
  public String toString() {
    return "AppUser{" +
            "userName='" + userName + '\'' +
            ", fullName='" + fullName + '\'' +
            ", userType='" + userType + '\'' +
            '}';
  }
} // end of class User