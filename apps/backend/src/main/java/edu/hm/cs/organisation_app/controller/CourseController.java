package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.Course;
import edu.hm.cs.organisation_app.model.CourseSubscription;
import edu.hm.cs.organisation_app.model.Task;
import edu.hm.cs.organisation_app.service.CourseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Represents a CourseController.
 *
 * @author Angel Curras Sanchez
 */
@RestController
@RequestMapping("/courses")
public class CourseController {

  /* Fields */
  private static final Logger log = LoggerFactory.getLogger(CourseController.class);
  private final CourseService service;


  /* Constructors */

  /**
   * Creates a new CourseController.
   *
   * @param service The course service.
   */
  @Autowired
  public CourseController(CourseService service) {
    log.info("Creating the course controller...");
    this.service = service;
  } // end of CourseController()

  /* Methods */
  /* GET */

  /**
   * Gets all courses for a user.
   *
   * @param userName The username.
   * @return A list of courses.
   */
  @GetMapping("/user/{userName}")
  @ResponseStatus(HttpStatus.OK)
  public List<Course> getAllCoursesForUser(@PathVariable String userName) {
    log.info("Getting all courses requested for user: " + userName);
    List<Course> courses = service.getAllCoursesForUser(userName);
    log.info("Courses found: " + courses);
    return courses;
  } // end of getAllCoursesForUser()

  /**
   * Gets a course by id.
   *
   * @param courseId The course id.
   * @return The course.
   */
  @GetMapping("/{courseId}")
  @ResponseStatus(HttpStatus.OK)
  public Course getCourseById(@PathVariable Long courseId) {
    log.info("Getting requested course from id: " + courseId);
    Course course = service.getCourseById(courseId);
    log.info("Course found: " + course);
    return course;
  } // end of getCourseById()

  /**
   * Gets all tasks for a course.
   *
   * @param courseId The course id.
   * @return A list of tasks.
   */
  @GetMapping("/{courseId}/tasks")
  @ResponseStatus(HttpStatus.OK)
  public List<Task> getAllTasksForCourse(@PathVariable Long courseId) {
    log.info("Getting all tasks requested for course: " + courseId);
    List<Task> tasks = service.getAllTasksForCourse(courseId);
    log.info("Tasks found: " + tasks);
    return tasks;
  } // end of getAllTasksForCourse()


  /* POST */

  /**
   * Creates a course.
   *
   * @param courseSubscription The course subscription.
   * @return The created course.
   */
  @PostMapping("")
  @ResponseStatus(HttpStatus.CREATED)
  public Course createCourse(@RequestBody CourseSubscription courseSubscription) {
    log.info("Creating course from: " + courseSubscription);
    Course createdCourse = service.createCourse(courseSubscription);
    log.info("Course created: " + createdCourse);
    return createdCourse;
  } // end of createCourse()

  /* PUT */

  /**
   * Updates a course.
   *
   * @param courseId The course id.
   * @param course   The course.
   * @return The updated course.
   */
  @PutMapping("/{courseId}")
  @ResponseStatus(HttpStatus.OK)
  public Course updateCourse(@PathVariable Long courseId, @RequestBody Course course) {
    log.info("Updating course with from new infos: " + course);
    Course updatedCourse = service.updateCourseById(courseId, course);
    log.info("Course updated: " + updatedCourse);
    return updatedCourse;
  } // end of updateCourse()

  /* DELETE */

  /**
   * Deletes a course.
   *
   * @param courseId The course id.
   */
  @DeleteMapping("/{courseId}")
  @ResponseStatus(HttpStatus.OK)
  public void deleteCourse(@PathVariable Long courseId) {
    log.info("Deleting course with id: " + courseId);
    service.deleteCourseById(courseId);
    log.info("Course deleted with id: " + courseId);
  } // end of deleteCourse()


  /**
   * Deletes all courses.
   * This method is only for testing purposes.
   */
  public void deleteAllCourses() {
    service.deleteAll();
  } // end of deleteAllCourses()

} // end of class CourseController