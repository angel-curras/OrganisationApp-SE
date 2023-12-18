package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.CourseRepository;
import edu.hm.cs.organisation_app.database.ModuleRepository;
import edu.hm.cs.organisation_app.database.UserRepository;
import edu.hm.cs.organisation_app.model.AppUser;
import edu.hm.cs.organisation_app.model.Course;
import edu.hm.cs.organisation_app.model.CourseSubscription;
import edu.hm.cs.organisation_app.model.Module;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

/**
 * Represents a CourseService.
 *
 * @author Angel Curras Sanchez
 */
@Service
public class CourseService {

  /* Fields */
  private final CourseRepository courseRepository;
  private final ModuleRepository moduleRepository;
  private final UserRepository userRepository;


  /* Constructors */
  public CourseService(CourseRepository courseRepository, ModuleRepository moduleRepository, UserRepository userRepository) {
    this.courseRepository = courseRepository;
    this.moduleRepository = moduleRepository;
    this.userRepository = userRepository;
  }

  /* Methods */
  public List<Course> getAllCourses() {
    return courseRepository.findAll();
  }

  public Course createCourse(CourseSubscription courseSubscription) {

    // Get the module and user from the database
    Long moduleId = courseSubscription.getModuleId();
    String userName = courseSubscription.getUserName();
    AppUser user =
            userRepository.findById(userName).orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found."));
    Module module =
            moduleRepository.findById(moduleId).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Module not found."));

    // Check if the user is already subscribed to this course.
    List<Course> userCourses = user.getCourses();
    for (Course course : userCourses) {
      if (Objects.equals(course.getModuleId(), moduleId)) {
        throw new ResponseStatusException(HttpStatus.CONFLICT, "User already subscribed to this course.");
      }
    }

    // Create the course and save it to the database
    LocalDate today = LocalDate.now();
    Course course = new Course(module, user, today, today.plusMonths(6));
    user.addCourse(course);
    return courseRepository.save(course);
  }

  public Course getCourseById(Long courseId) {
    return courseRepository.findById(String.valueOf(courseId)).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Course not found."));
  }

  public void deleteCourseById(Long courseId) {
    courseRepository.deleteById(String.valueOf(courseId));
  }

  public Course updateCourseById(Long courseId, CourseSubscription courseSubscription) {
    Course course = courseRepository.findById(String.valueOf(courseId)).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Course not found."));
    Long moduleId = courseSubscription.getModuleId();
    Module module =
            moduleRepository.findById(moduleId).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Module not found."));
    return courseRepository.save(course);
  }


} // end of class CourseService