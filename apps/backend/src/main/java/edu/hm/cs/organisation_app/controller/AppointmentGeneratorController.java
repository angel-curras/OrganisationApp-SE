package edu.hm.cs.organisation_app.controller;

import edu.hm.cs.organisation_app.service.AppointmentGeneratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Represents a AppointmentGeneratorController.
 *
 * @author Angel Curras Sanchez
 */
@RestController
@RequestMapping("/appointment-generators")
public class AppointmentGeneratorController {

  /* Fields */
  AppointmentGeneratorService service;

  /* Constructors */
  @Autowired
  public AppointmentGeneratorController(AppointmentGeneratorService service) {
    this.service = service;
  }

  /* Getters and Setters */


  /* Methods */


} // end of class AppointmentGeneratorController