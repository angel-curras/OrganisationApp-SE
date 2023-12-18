package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.AppUser;
import edu.hm.cs.organisation_app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Represents a UserController.
 *
 * @author Angel Curras Sanchez
 */
@RestController
@RequestMapping("/users")
public class UserController {

  /* Fields */

  private final UserService service;

  /* Constructors */
  @Autowired
  public UserController(UserService service) {
    this.service = service;
  }

  /* Methods */
  @GetMapping("")
  @ResponseStatus(HttpStatus.OK)
  public List<AppUser> getUsers() {
    return service.getAllUsers();
  }

  @GetMapping("/{username}")
  @ResponseStatus(HttpStatus.OK)
  public AppUser getUser(@PathVariable String username) {
    return service.getUserInfoByUsername(username);
  }

  @PostMapping("")
  public AppUser postUser(@RequestBody AppUser user) {
    return service.createUser(user);
  }

  public void deleteAllUsers() {
    service.deleteAll();
  }

} // end of class UserController