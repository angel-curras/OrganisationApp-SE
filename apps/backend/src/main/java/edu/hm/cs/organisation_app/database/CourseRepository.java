package edu.hm.cs.organisation_app.database;

import edu.hm.cs.organisation_app.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface CourseRepository.
 *
 * @author Angel Curras Sanchez
 */
public interface CourseRepository extends JpaRepository<Course, String> {
  
} // end of interface CourseRepository