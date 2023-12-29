package edu.hm.cs.organisation_app.controller;
import edu.hm.cs.organisation_app.model.Task;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import java.util.List;

import static edu.hm.cs.organisation_app.model.FrequencyType.*;
import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class TaskControllerTest {

    @Autowired
    private TaskController taskController;
    private void initDB() {
        Task firstTask = new Task(); // Configure task details as required
        Task secondTask = new Task(); // Configure task details as required
        taskController.createTask(firstTask);
        taskController.createTask(secondTask);
    }

    // Delete all tasks from the database
    private void clearDB() {
        taskController.deleteAllTasks();
    }

    @Test
    void testGetAllTasksEmpty() {
        this.clearDB();
        List<Task> tasks = taskController.getAllTasks();
        Assertions.assertEquals(0, tasks.size());
    }

    @Test
    void testGetAllTasksAdded() {
        this.clearDB();
        this.initDB();
        List<Task> tasks = taskController.getAllTasks();
        Assertions.assertEquals(2, tasks.size());
    }

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

        Assertions.assertNotNull(updatedTask); // Assuming success means a non-null task was created
    } // end of testUpdateTask()

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

} // end of class TaskControllerTest