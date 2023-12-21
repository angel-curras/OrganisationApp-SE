package edu.hm.cs.organisation_app.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Represents a AppointmentGenerator.
 *
 * @author Angel Curras Sanchez
 */
@Entity
public class AppointmentGenerator {

  /* Fields */
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "appointment_generator_id")
  @JsonProperty("appointment_generator_id")
  private Long id;

  @JsonProperty("name")
  private String name;

  @JsonProperty("frequency")
  private String frequency;

  @JsonProperty("type")
  private String type;

  @JsonProperty("week_day")
  private DayOfWeek dayOfWeek;

  @JsonProperty("start_time")
  private LocalTime startTime;

  @JsonProperty("end_time")
  private LocalTime endTime;

  /* Constructors */
  public AppointmentGenerator() {
  }

  public AppointmentGenerator(String name, String frequency, String type, DayOfWeek dayOfWeek, LocalTime startTime, LocalTime endTime) {
    this.name = name;
    this.frequency = frequency;
    this.type = type;
    this.dayOfWeek = dayOfWeek;
    this.startTime = startTime;
    this.endTime = endTime;
  }


  /* Getters and Setters */


  /* Methods */
  public List<Task> generateTasks(LocalDate startDate, LocalDate endDate) {

    List<Task> tasks;

    if (type.equals("fixed")) {
      tasks = this.generateFixedTasks(startDate, endDate);
    } else {
      tasks = this.generateFlexibleTasks(startDate, endDate);
    }

    return tasks;
  }


  public List<Task> generateFixedTasks(LocalDate startDate, LocalDate endDate) {

    List<Task> tasks = new ArrayList<>();
    LocalDate eventStartDate = this.getStartDateFromDayOfWeek(startDate);

    switch (frequency) {
      case "daily":
        while (eventStartDate.isBefore(endDate)) {
          tasks.add(new Task(name, new CalendarEvent(name, eventStartDate, startTime, endTime)));
          eventStartDate = eventStartDate.plusDays(1);
        }
        break;
      case "weekly":
        while (eventStartDate.isBefore(endDate)) {
          tasks.add(new Task(name, new CalendarEvent(name, eventStartDate, startTime, endTime)));
          eventStartDate = eventStartDate.plusWeeks(1);
        }
        break;
      case "monthly":
        while (eventStartDate.isBefore(endDate)) {
          tasks.add(new Task(name, new CalendarEvent(name, eventStartDate, startTime, endTime)));
          eventStartDate = eventStartDate.plusMonths(1);
        }
        break;
    } // end of switch

    return tasks;
  } // end of generateFixedTasks()


  public List<Task> generateFlexibleTasks(LocalDate startDate, LocalDate endDate) {

    List<Task> tasks = new ArrayList<>();
    LocalDate eventStartDate = this.getStartDateFromDayOfWeek(startDate);

    switch (frequency) {
      case "daily":
        while (eventStartDate.isBefore(endDate)) {
          tasks.add(new Task(name, new CalendarEvent(name, eventStartDate)));
          eventStartDate = eventStartDate.plusDays(1);
        }
        break;
      case "weekly":
        while (eventStartDate.isBefore(endDate)) {
          tasks.add(new Task(name, new CalendarEvent(name, eventStartDate)));
          eventStartDate = eventStartDate.plusWeeks(1);
        }
        break;
      case "monthly":
        while (eventStartDate.isBefore(endDate)) {
          tasks.add(new Task(name, new CalendarEvent(name, eventStartDate)));
          eventStartDate = eventStartDate.plusMonths(1);
        }
        break;
    } // end of switch

    return tasks;
  } // end of generateFlexibleTasks()

  public LocalDate getStartDateFromDayOfWeek(LocalDate date) {
    LocalDate startDate = date;
    while (!startDate.getDayOfWeek().equals(dayOfWeek)) {
      startDate = startDate.plusDays(1);
    }
    return startDate;
  }


} // end of class AppointmentGenerator