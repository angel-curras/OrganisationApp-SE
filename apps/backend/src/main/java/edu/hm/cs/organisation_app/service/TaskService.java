package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.TaskRepository;
import edu.hm.cs.organisation_app.database.UserRepository;
import edu.hm.cs.organisation_app.model.AppUser;
import edu.hm.cs.organisation_app.model.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Comparator;
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

  public Task createTask(Task task) {
    return taskRepository.save(task);
  }

  public void deleteTask(long id) {
    taskRepository.deleteById(id);
  }
  /* Getters and Setters */


  /* Methods */
  public List<Task> getAllTasks() {
    return taskRepository.findAll();
  }


  public List<Task> getAllTasksForUser(String userName) {

    // Check if the user is authorized to create a course.
    AppUser user =
            userRepository.findById(userName)
                    .orElseThrow(
                            () -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found."));

    // Check if the user is already subscribed to this course.
    List<Task> userTasks = user.getAllTasks();

    // Sort the tasks by priority, then by date.
    userTasks.sort(Comparator.comparingInt(Task::getPriority));
    userTasks.sort(Comparator.comparing(Task::getDate));
    return user.getAllTasks();
  }
} // end of class TaskService