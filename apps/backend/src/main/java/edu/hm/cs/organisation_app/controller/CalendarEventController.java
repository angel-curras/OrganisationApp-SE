package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.model.CalendarEvent;
import edu.hm.cs.organisation_app.service.CalendarEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Represents a CalendarEventController.
 *
 * @author Angel Curras Sanchez
 */
@RestController
@RequestMapping("/calendar-events")
public class CalendarEventController {

  /* Fields */
  CalendarEventService service;

  /* Constructors */
  @Autowired
  public CalendarEventController(CalendarEventService service) {
    this.service = service;
  }


  /* Getters and Setters */


  /* Methods */

  @GetMapping("")
  public List<CalendarEvent> getAllCalendarEvents() {
    return this.service.getAllCalendarEvents();
  }

} // end of class CalendarEventController