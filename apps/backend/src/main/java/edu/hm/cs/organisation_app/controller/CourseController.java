package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.Course;
import edu.hm.cs.organisation_app.model.CourseSubscription;
import edu.hm.cs.organisation_app.service.CourseService;
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
  private final CourseService service;


  /* Constructors */
  @Autowired
  public CourseController(CourseService service) {
    this.service = service;
  }

  /* Methods */
  @GetMapping("")
  @ResponseStatus(HttpStatus.OK)
  public List<Course> getAllCourses() {
    return service.getAllCourses();
  }

  @GetMapping("/{courseId}")
  @ResponseStatus(HttpStatus.OK)
  public Course getCourseById(@PathVariable Long courseId) {
    return service.getCourseById(courseId);
  }

  @PostMapping("")
  public Course createCourse(@RequestBody CourseSubscription courseSubscription) {
    return service.createCourse(courseSubscription);
  }

  @PutMapping("/{courseId}")
  @ResponseStatus(HttpStatus.OK)
  public Course updateCourse(@PathVariable Long courseId, @RequestBody CourseSubscription courseSubscription) {
    return service.updateCourseById(courseId, courseSubscription);
  }

  @DeleteMapping("/{courseId}")
  @ResponseStatus(HttpStatus.NO_CONTENT)
  public void deleteCourse(@PathVariable Long courseId) {
    service.deleteCourseById(courseId);
  }


} // end of class CourseController