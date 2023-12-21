package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.UserRepository;
import edu.hm.cs.organisation_app.model.AppUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;


import java.util.List;

/**
 * Represents a UserService.
 *
 * @author Angel Curras Sanchez
 */
@Service
public class UserService {

  /* Fields */
  UserRepository repository;


  /* Constructors */
  @Autowired
  public UserService(UserRepository repository) {
    this.repository = repository;
  }

  /* Getters and Setters */


  /* Methods */
  public List<AppUser> getAllUsers() {
    return repository.findAll();
  }

  public AppUser getUserInfoByUsername(String username) {
    return repository.findById(username)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found."));
  }

  public List<String> getAllUsernames() {
    return repository.findAll().stream().map(AppUser::getUserName).collect(java.util.stream.Collectors.toList());
  }
  public AppUser createUser(AppUser user) {
    return repository.save(user);
  }

  public void deleteAll() {
    repository.deleteAll();
  }

} // end of class UserService