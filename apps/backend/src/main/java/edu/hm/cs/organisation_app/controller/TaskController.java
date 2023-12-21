package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.Task;
import edu.hm.cs.organisation_app.service.TaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Represents a TaskController.
 *
 * @author Angel Curras Sanchez
 */
@RestController
@RequestMapping("/tasks")
public class TaskController {

  private static final Logger log = LoggerFactory.getLogger(TaskController.class);
  /* Fields */
  TaskService service;

  /* Constructors */
  @Autowired
  public TaskController(TaskService service) {
    this.service = service;
  }


  /* Getters and Setters */


  /* Methods */
  @GetMapping("")
  public List<Task> getAllTasks() {
    return this.service.getAllTasks();
  }


} // end of class TaskController