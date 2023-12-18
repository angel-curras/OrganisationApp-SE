package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Represents a TaskController.
 *
 * @author Angel Curras Sanchez
 */
@RestController
@RequestMapping("/tasks")
public class TaskController {

  /* Fields */
  TaskService taskService;

  /* Constructors */
  @Autowired
  public TaskController(TaskService taskService) {
    this.taskService = taskService;
  }


  /* Getters and Setters */


  /* Methods */


} // end of class TaskController