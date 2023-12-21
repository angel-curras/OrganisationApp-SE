package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.AppointmentGeneratorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Represents a AppointmentGeneratorService.
 *
 * @author Angel Curras Sanchez
 */
@Service
public class AppointmentGeneratorService {

  /* Fields */
  AppointmentGeneratorRepository repository;


  /* Constructors */
  @Autowired
  public AppointmentGeneratorService(AppointmentGeneratorRepository repository) {
    this.repository = repository;
  }


  /* Getters and Setters */


  /* Methods */


} // end of class AppointmentGeneratorService