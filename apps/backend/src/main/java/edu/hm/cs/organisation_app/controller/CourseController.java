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
  @Autowired
  public CourseController(CourseService service) {
    log.info("Creating the course controller...");
    this.service = service;
  }

  /* Methods */
  @GetMapping("")
  @ResponseStatus(HttpStatus.OK)
  public List<Course> getAllCourses() {
    log.info("Getting all the courses stored...");
    List<Course> courses = service.getAllCourses();
    log.info("Courses found: " + courses);
    return courses;
  }

  @GetMapping("/{courseId}")
  @ResponseStatus(HttpStatus.OK)
  public Course getCourseById(@PathVariable Long courseId) {
    log.info("Getting requested course from id: " + courseId);
    Course course = service.getCourseById(courseId);
    log.info("Course found: " + course);
    return course;
  }

  @GetMapping("/user/{userName}")
  @ResponseStatus(HttpStatus.OK)
  public List<Course> getAllCoursesForUser(@PathVariable String userName) {
    log.info("Getting all courses requested for user: " + userName);
    List<Course> courses = service.getAllCoursesForUser(userName);
    log.info("Courses found: " + courses);
    return courses;
  }

  @PostMapping("")
  @ResponseStatus(HttpStatus.CREATED)
  public Course createCourse(@RequestBody CourseSubscription courseSubscription) {
    log.info("Creating course from: " + courseSubscription);
    Course createdCourse = service.createCourse(courseSubscription);
    log.info("Course created: " + createdCourse);
    return createdCourse;
  }

  @PutMapping("/{courseId}")
  @ResponseStatus(HttpStatus.OK)
  public Course updateCourse(@PathVariable Long courseId, @RequestBody Course course) {
    log.info("Updating course with from new infos: " + course);
    Course updatedCourse = service.updateCourseById(courseId, course);
    log.info("Course updated: " + updatedCourse);
    return updatedCourse;
  }

  @DeleteMapping("/{courseId}")
  @ResponseStatus(HttpStatus.OK)
  public void deleteCourse(@PathVariable Long courseId) {
    log.info("Deleting course with id: " + courseId);
    service.deleteCourseById(courseId);
    log.info("Course deleted with id: " + courseId);
  }

  @GetMapping("/{courseId}/tasks")
  @ResponseStatus(HttpStatus.OK)
  public List<Task> getAllTasksForCourse(@PathVariable Long courseId) {
    log.info("Getting all tasks requested for course: " + courseId);
    List<Task> tasks = service.getAllTasksForCourse(courseId);
    log.info("Tasks found: " + tasks);
    return tasks;
  }


} // end of class CourseController