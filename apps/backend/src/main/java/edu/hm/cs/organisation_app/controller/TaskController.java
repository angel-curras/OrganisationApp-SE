package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.Task;
import edu.hm.cs.organisation_app.service.TaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    log.info("Creating the task controller...");
    this.service = service;
  }

  @PostMapping("")
  public Task createTask(@RequestBody Task newTask) {
    log.info("Creating a new task: " + newTask);
    Task createdTask = this.service.createTask(newTask);
    log.info("Task created: " + createdTask);
    return createdTask;
  }

  //update task
  @PutMapping("/{id}")
  public Task updateTask(@RequestBody Task newTask, @PathVariable long id) {
    return this.service.updateTask(newTask, id);
  }

  //delete task
  @DeleteMapping("/{id}")
  public void deleteTask(@PathVariable long id) {
    this.service.deleteTask(id);
  }

  // delete all tasks
    @DeleteMapping("/deleteAll")
    public void deleteAllTasks() {
        this.service.deleteAllTasks();
    }
  /* Getters and Setters */


  /* Methods */
  @GetMapping("")
  public List<Task> getAllTasks() {
    System.out.println(this.service.getAllTasks().getFirst().getId());
    return this.service.getAllTasks();
  }

  @GetMapping("/{username}")
  public List<Task> getAllTasksForUser(@PathVariable String username) {
    return this.service.getAllTasksForUser(username);
  }


} // end of class TaskController