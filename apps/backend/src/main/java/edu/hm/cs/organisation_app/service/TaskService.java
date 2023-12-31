package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.TaskRepository;
import edu.hm.cs.organisation_app.database.UserRepository;
import edu.hm.cs.organisation_app.model.AppUser;
import edu.hm.cs.organisation_app.model.Task;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

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
  private final UserRepository userRepository;

  /* Constructors */
  @Autowired
  public TaskService(TaskRepository taskRepository, UserRepository userRepository) {
    this.taskRepository = taskRepository;
    this.userRepository = userRepository;
  }

  //update task
  @Transactional
  public Task updateTask(Task newTask, long id) {
    return taskRepository.findById(id)
            .map(task -> {
              task.setName(newTask.getName());
              task.setPriority(newTask.getPriority());
              task.setDone(newTask.isDone());
              task.setFrequency(newTask.getFrequency());
              task.setCalendarEvent(newTask.getCalendarEvent());
              task.setDeadline(newTask.getDeadline());
              return taskRepository.save(task);
            })
            .orElseGet(() -> {
              newTask.setId(id);
              return taskRepository.save(newTask);
            });
  }

  @Transactional
  public Task createTask(Task task) {
    return taskRepository.save(task);
  }

  @Transactional
  public void deleteTask(long id) {
    Task task = taskRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Task not found."));
    taskRepository.deleteById(id);
  }

  @Transactional
  public void deleteAllTasks() {
    taskRepository.deleteAll();
  }
  /* Getters and Setters */


  /* Methods */
  @Transactional
  public List<Task> getAllTasks() {
    return taskRepository.findAll();
  }

  @Transactional
  public List<Task> getAllTasksForUser(String userName) {

    // Check if the user is authorized to create a course.
    AppUser user =
            userRepository.findById(userName)
                    .orElseThrow(
                            () -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found."));

    // Check if the user is already subscribed to this course.
    return user.getAllTasks();
  }

  @Transactional
  public Task createTaskForUser(Task newTask, String userName) {


    // Check if the user is authorized to create a course.
    AppUser user =
            userRepository.findById(userName)
                    .orElseThrow(
                            () -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found."));

    // Create the task and save it to the database
    Task task = new Task(newTask.getName());
    task.setPriority(newTask.getPriority());
    task.setDone(newTask.isDone());
    task.setFrequency(newTask.getFrequency());
    task.setCalendarEvent(newTask.getCalendarEvent());
    task.setDeadline(newTask.getDeadline());

    task.setAppUser(user);

    return taskRepository.save(task);
  }


} // end of class TaskService