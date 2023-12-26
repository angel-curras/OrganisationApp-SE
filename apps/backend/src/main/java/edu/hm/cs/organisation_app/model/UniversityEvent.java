package edu.hm.cs.organisation_app.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Represents a UniversityEvent.
 *
 * @author Angel Curras Sanchez
 */
@Entity
public class UniversityEvent {

  /* Fields */
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int id;
  private String name;
  private DayOfWeek dayOfWeek;
  private LocalTime startTime;
  private LocalTime endTime;

  /* Constructors */
  public UniversityEvent() {
  } // end of constructor

  public UniversityEvent(DayOfWeek dayOfWeek, LocalTime startTime, LocalTime endTime) {
    this.dayOfWeek = dayOfWeek;
    this.startTime = startTime;
    this.endTime = endTime;
  } // end of constructor

  /* Getters and Setters */
  public DayOfWeek getDayOfWeek() {
    return dayOfWeek;
  }

  public void setDayOfWeek(DayOfWeek dayOfWeek) {
    this.dayOfWeek = dayOfWeek;
  }

  public LocalTime getStartTime() {
    return startTime;
  }

  public void setStartTime(LocalTime startTime) {
    this.startTime = startTime;
  }

  public LocalTime getEndTime() {
    return endTime;
  }

  public void setEndTime(LocalTime endTime) {
    this.endTime = endTime;
  }

  public float getDurationHours() {
    return (endTime.getHour() - startTime.getHour()) + (float) (endTime.getMinute() - startTime.getMinute()) / 60;
  }

  public List<Task> generateTasks(LocalDate startDate, LocalDate endDate) {

    LocalDate eventDate = getStartDateFromDayOfWeek(startDate);

    return IntStream.range(0, (int) ChronoUnit.WEEKS.between(startDate, endDate))
            .mapToObj(startDate::plusWeeks)
            .map(date -> new CalendarEvent())
            .map(calendarEvent -> new Task(this.name, calendarEvent))
            .collect(Collectors.toList());

  }

  /* Methods */
  public LocalDate getStartDateFromDayOfWeek(LocalDate date) {
    LocalDate startDate = date;
    while (!startDate.getDayOfWeek().equals(dayOfWeek)) {
      startDate = startDate.plusDays(1);
    }
    return startDate;
  }


} // end of class UniversityEvent