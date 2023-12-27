package edu.hm.cs.organisation_app;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class OrganisationAppApplicationTests {

  /**
   * Tests if the context loads.
   */
  @Test
  void contextLoads() {
    // Do nothing.

  } // end of testContextLoads()

  /**
   * Tests if the main application runs.
   */
  @Test
  void testMainApplication() {
    OrganisationApplication.main(new String[]{});
  } // end of testMainApplication()

} // end of class OrganisationAppApplicationTests
