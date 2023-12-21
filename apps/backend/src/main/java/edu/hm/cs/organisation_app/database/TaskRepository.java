package edu.hm.cs.organisation_app.database;

import edu.hm.cs.organisation_app.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface TaskRepository.
 *
 * @author Angel Curras Sanchez
 */
public interface TaskRepository extends JpaRepository<Task, Long> {

  /* Fields */

  /* Methods */

} // end of interface TaskRepository