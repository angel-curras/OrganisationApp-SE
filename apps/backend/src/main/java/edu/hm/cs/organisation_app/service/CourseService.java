package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.CourseRepository;
import edu.hm.cs.organisation_app.database.ModuleRepository;
import edu.hm.cs.organisation_app.database.TaskRepository;
import edu.hm.cs.organisation_app.database.UserRepository;
import edu.hm.cs.organisation_app.model.Module;
import edu.hm.cs.organisation_app.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

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
  private final TaskRepository taskRepository;


  /* Constructors */
  @Autowired
  public CourseService(CourseRepository courseRepository, ModuleRepository moduleRepository,
                       UserRepository userRepository, TaskRepository taskRepository) {
    this.courseRepository = courseRepository;
    this.moduleRepository = moduleRepository;
    this.userRepository = userRepository;
    this.taskRepository = taskRepository;
  }

  /* Methods */
  public List<Course> getAllCourses() {
    return courseRepository.findAll();
  }

  public Course createCourse(CourseSubscription courseSubscription) {

    // Get the module and user from the database
    Long moduleId = courseSubscription.getModuleId();
    String userName = courseSubscription.getUserName();

    // Check if the user is authorized to create a course.
    AppUser user =
            userRepository.findById(userName)
                    .orElseThrow(
                            () -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found."));

    // Check if the module exists.
    Module module =
            moduleRepository.findById(moduleId)
                    .orElseThrow(
                            () -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Module not " +
                                    "found."));

    // Check if the user is already subscribed to this course.
    List<Course> userCourses = user.getCourses();
    for (Course course : userCourses) {
      if (Objects.equals(course.getModuleId(), moduleId)) {
        throw new ResponseStatusException(HttpStatus.CONFLICT, "User already subscribed to this course.");
      }
    }

    // Create the course and save it to the database
    Course course = new Course(module, user);
    user.addCourse(course);
    return courseRepository.save(course);
  }

  public Course getCourseById(Long courseId) {
    return courseRepository.findById(String.valueOf(courseId)).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Course not found."));
  }

  public void deleteCourseById(Long courseId) {
    courseRepository.deleteById(String.valueOf(courseId));
  }

  public Course updateCourseById(Long courseId, Course newCourse) {
    Course course = courseRepository.findById(String.valueOf(courseId)).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Course not found."));

    // Update the course.
    course.setStartDate(newCourse.getStartDate());
    course.setEndDate(newCourse.getEndDate());
    course.setLectureWeekday(newCourse.getLectureWeekday());
    course.setLectureStartTime(newCourse.getLectureStartTime());
    course.setLectureEndTime(newCourse.getLectureEndTime());
    course.setLabWeekday(newCourse.getLabWeekday());
    course.setLabStartTime(newCourse.getLabStartTime());
    course.setLabEndTime(newCourse.getLabEndTime());
    course.updateTasks();

    // Save the course to the database.
    return courseRepository.save(course);
  }


  public List<Course> getAllCoursesForUser(String userName) {

    // Check if the user is authorized to create a course.
    AppUser user =
            userRepository.findById(userName)
                    .orElseThrow(
                            () -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found."));

    // Check if the user is already subscribed to this course.
    return user.getCourses();
  }

  public List<Task> getAllTasksForCourse(Long courseId) {
    return courseRepository.findById(String.valueOf(courseId)).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Course not found.")).getTasks();
  }
} // end of class CourseService