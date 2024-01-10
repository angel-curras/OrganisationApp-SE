package edu.hm.cs.organisation_app.controller;
import edu.hm.cs.organisation_app.model.Task;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

import static edu.hm.cs.organisation_app.model.FrequencyType.*;
import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class TaskControllerTest {

    @Autowired
    private TaskController taskController;
    private void initDB() {
        Task firstTask = new Task();
        Task secondTask = new Task();
        taskController.createTask(firstTask);
        taskController.createTask(secondTask);
    }

    // Delete all tasks from the database
    private void clearDB() {
        taskController.deleteAllTasks();
    }

    // Test that tasks have the correct IDs
    @Test
    void testInitDB(){
        this.clearDB();
        this.initDB();
        List<Task> tasks = taskController.getAllTasks();
        Assertions.assertEquals(1, tasks.getFirst().getId());
        Assertions.assertEquals(2, tasks.getLast().getId());
    }

    // Test that the database is empty
    @Test
    void testGetAllTasksEmpty() {
        this.clearDB();
        List<Task> tasks = taskController.getAllTasks();
        Assertions.assertEquals(0, tasks.size());
    }

    // Test if the database contains all tasks
    @Test
    void testGetAllTasksAdded() {
        this.clearDB();
        this.initDB();
        List<Task> tasks = taskController.getAllTasks();
        Assertions.assertEquals(2, tasks.size());
    }

    // Test task is saved correctly
    @Test
    void testNewTaskDBEmpty() {
        this.clearDB();

        Task newTask = new Task();
        newTask.setName("Task");
        newTask.setPriority(3);
        newTask.setDone(false);
        newTask.setFrequency(ONCE);

        Task createdTask = taskController.createTask(newTask);

        Assertions.assertEquals(newTask.getName(), createdTask.getName());
        Assertions.assertEquals(newTask.getPriority(), createdTask.getPriority());
        Assertions.assertEquals(newTask.isDone(), createdTask.isDone());
        Assertions.assertEquals(newTask.getFrequency(), createdTask.getFrequency());


        Assertions.assertNotNull(createdTask);
    } // end of testNewTaskDBEmpty()

    // Test if task is updated correctly
    @Test
    void testUpdateTask() {
        this.clearDB();
        this.initDB();

        List<Task> tasks = taskController.getAllTasks();
        Task existingTask = tasks.get(0);

        // Change some details of existingTask
         existingTask.setPriority(1);
        Task updatedTask = taskController.updateTask(existingTask, existingTask.getId());
        // Verify the updated details
         Assertions.assertEquals(1, updatedTask.getPriority());

        Assertions.assertNotNull(updatedTask);

        // test saving if the id is not found
        Task updatedTask2 = taskController.updateTask(existingTask, 5);
        List<Task> tasks2 = taskController.getAllTasks();
        Assertions.assertEquals(3, tasks2.size());
    } // end of testUpdateTask()

    // Test if task is deleted correctly
    @Test
    void testDeleteTask() {
        this.clearDB();
        this.initDB();

        List<Task> tasks = taskController.getAllTasks();
        Assertions.assertEquals(2, tasks.size());

        Task taskToDelete = tasks.get(0);
        taskController.deleteTask(taskToDelete.getId()); // Delete task

        List<Task> remainingTasks = taskController.getAllTasks();
        Assertions.assertEquals(1, remainingTasks.size()); // Verify that one task has been deleted
    } // end of testDeleteTask()

    //test for creating a task for a user
    @Test
    void createTaskForUserTest(){
        this.clearDB();

        Task task = new Task();

        taskController.createTaskForUser(task, "test");
        List<Task> tasksForUser = taskController.getAllTasksForUser("test");
        Assertions.assertEquals(1, tasksForUser.size());
    }


    @Test
    void getAllTasksForUser_whenUserNotFound_shouldThrowResponseStatusException() {
        this.clearDB();

        Assertions.assertThrows(ResponseStatusException.class, () -> {
            taskController.getAllTasksForUser("invalidUser");
        });
    }

    @Test
    void createTaskForUser_whenUserNotFound_shouldThrowResponseStatusException() {
        this.clearDB();

        Assertions.assertThrows(ResponseStatusException.class, () -> {
            taskController.createTaskForUser(new Task(), "invalidUser");
        });
    }
} // end of class TaskControllerTest