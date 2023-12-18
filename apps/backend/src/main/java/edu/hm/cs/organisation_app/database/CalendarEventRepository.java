package edu.hm.cs.organisation_app.database;

import edu.hm.cs.organisation_app.model.CalendarEvent;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface CalendarEventRepository.
 *
 * @author Angel Curras Sanchez
 */
public interface CalendarEventRepository extends JpaRepository<CalendarEvent, Long> {

  /* Fields */

  /* Methods */

} // end of interface CalendarEventRepository