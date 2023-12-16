package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.database.UserRepository;
import edu.hm.cs.organisation_app.model.AppUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

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
  private final UserRepository repository;

  /* Constructors */
  @Autowired
  public UserController(UserRepository repository) {
    this.repository = repository;
  }

  /* Methods */
  @GetMapping("")
  @ResponseStatus(HttpStatus.OK)
  public List<AppUser> getAllUsers() {
    return repository.findAll();
  }

  @GetMapping("/{username}")
  @ResponseStatus(HttpStatus.OK)
  public AppUser getUserInfoByUsername(@PathVariable String username) {
    return repository.findById(username)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found."));
  }

  @PostMapping("")
  public AppUser createUser(@RequestBody AppUser user) {
    return repository.save(user);
  }

  public void deleteAllUsers() {
    repository.deleteAll();
  }

} // end of class UserController