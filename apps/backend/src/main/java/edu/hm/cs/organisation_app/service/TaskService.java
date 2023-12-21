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


} // end of class TaskService