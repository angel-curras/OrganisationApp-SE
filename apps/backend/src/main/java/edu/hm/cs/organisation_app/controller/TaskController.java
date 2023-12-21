package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.Task;
import edu.hm.cs.organisation_app.service.TaskService;
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

  /* Fields */
  TaskService service;

  /* Constructors */
  @Autowired
  public TaskController(TaskService service) {
    this.service = service;
  }

  @PostMapping("task")
    public Task createTask(@RequestBody Task newTask) {
        return this.service.createTask(newTask);
    }

    //update task
    @PutMapping("task/{id}")
    public Task updateTask(@RequestBody Task newTask, @PathVariable long id) {
        return this.service.updateTask(newTask, id);
    }

    //delete task
    @DeleteMapping("task/{id}")
    public void deleteTask(@PathVariable long id) {
        this.service.deleteTask(id);
    }
  /* Getters and Setters */


  /* Methods */
  @GetMapping("")
  public List<Task> getAllTasks() {
    return this.service.getAllTasks();
  }


} // end of class TaskController