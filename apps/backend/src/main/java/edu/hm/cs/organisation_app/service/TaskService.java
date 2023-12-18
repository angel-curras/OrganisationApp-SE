package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.TaskRepository;
import edu.hm.cs.organisation_app.model.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Represents a TaskService.
 *
 * @author Angel Curras Sanchez
 */
@Service
public class TaskService {

  /* Fields */
  private final TaskRepository taskRepository;

  /* Constructors */
  @Autowired
  public TaskService(TaskRepository taskRepository) {
    this.taskRepository = taskRepository;
  }


  /* Getters and Setters */


  /* Methods */
  public List<Task> getAllTasks() {
    return taskRepository.findAll();
  }


} // end of class TaskService