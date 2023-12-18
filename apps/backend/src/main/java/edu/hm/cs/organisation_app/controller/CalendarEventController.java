package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.service.CalendarEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Represents a CalendarEventController.
 *
 * @author Angel Curras Sanchez
 */
@RestController
@RequestMapping("/calendar-events")
public class CalendarEventController {

  /* Fields */
  CalendarEventService calendarEventService;
  
  /* Constructors */
  @Autowired
  public CalendarEventController(CalendarEventService calendarEventService) {
    this.calendarEventService = calendarEventService;
  }


  /* Getters and Setters */


  /* Methods */


} // end of class CalendarEventController