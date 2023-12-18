package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.CalendarEventRepository;
import edu.hm.cs.organisation_app.model.CalendarEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Represents a CalendarEventService.
 *
 * @author Angel Curras Sanchez
 */
@Service
public class CalendarEventService {


  /* Fields */
  CalendarEventRepository repository;

  /* Constructors */
  @Autowired
  public CalendarEventService(CalendarEventRepository repository) {
    this.repository = repository;
  }

  /* Getters and Setters */


  /* Methods */
  public List<CalendarEvent> getAllCalendarEvents() {
    return this.repository.findAll();
  }


} // end of class CalendarEventService