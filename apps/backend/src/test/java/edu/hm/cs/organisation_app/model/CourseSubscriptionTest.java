package edu.hm.cs.organisation_app.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;

import static org.springframework.test.annotation.DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD;

/**
 * Represents a CourseSubscriptionTest.
 *
 * @author Angel Curras Sanchez
 */
@SpringBootTest
@DirtiesContext(classMode = BEFORE_EACH_TEST_METHOD)
public class CourseSubscriptionTest {

  CourseSubscription courseSubscription;

  /**
   * Test the default constructor.
   */
  @Test
  void testDefaultConstructor() {
    // Arrange & Act.
    courseSubscription = new CourseSubscription();

    // Assert.
    Assertions.assertNull(courseSubscription.getModuleId());
    Assertions.assertNull(courseSubscription.getUserName());

  } // end of testDefaultConstructor

  /**
   * Test the custom constructor.
   */
  @Test
  void testCustomConstructor() {
    // Arrange.
    Long moduleId = 1L;
    String userName = "user1";

    // Act.
    courseSubscription = new CourseSubscription(moduleId, userName);
    
    // Assert.
    Assertions.assertEquals(moduleId, courseSubscription.getModuleId());
    Assertions.assertEquals(userName, courseSubscription.getUserName());
  } // end of testCustomConstructor


} // end of class CourseSubscriptionTest