package edu.hm.cs.organisation_app.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.hm.cs.organisation_app.model.Module;
import edu.hm.cs.organisation_app.model.ModuleNotFoundException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import static org.hamcrest.Matchers.is;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class ModuleControllerTest {

  @Autowired
  private MockMvc mockMvc;


  @Autowired
  private ObjectMapper objectMapper;

  @Autowired
  private ResourceLoader resourceLoader;

  /**
   * Reads a JSON file from the resources folder and returns it as a string.
   *
   * @param path The path to the JSON file.
   * @return The JSON file as a string.
   * @throws Exception If the file could not be read.
   */
  private String readJson(String path) throws Exception {
    Resource resource = resourceLoader.getResource("classpath:" + path);
    return new String(Files.readAllBytes(Paths.get(resource.getURI())));
  }

  /**
   * Creates a test module.
   *
   * @return The test module.
   */
  private Module createTestModule() {
    return new Module(
            16L,
            "Analysis",
            2,
            "Prof. Dr. Wolfgang Högele",
            4,
            5,
            "Deutsch, Englisch",
            "SU mit Übung",
            "in jedem Wintersemester",
            "40 Präsenzstunden Vorlesung, 20 Präsenzstunden Übung, 20 Stunden Arbeit am JiTT-Material, 30 Stunden Vor-/Nachbereitung der Übungen, 40 Stunden Nachbereitung der Vorlesung und Prüfungsvorbereitung",
            "Schulkenntnisse Mathematik, wie Sie in der FOS/BOS Technik bzw. der gymnasialen Oberstufe vermittelt werden.",
            "Die Studierenden sind in der Lage,\n\neinfache Sachverhalte in der Sprache der Mathematik zu formulieren (Modellbildungskompetenz)\nmathematische Argumentationen kritisch zu reflektieren\ndie Probleme der eindimensionalen Analysis zu klassifizieren, geeignete Lösungsverfahren auszuwählen und sie sicher, formal korrekt und kreativ einzusetzen\nsicher mit Termen, (Un-)Gleichungen und Funktionen umzugehen\ndie Grundbegriffe der Analysis wie Konvergenz, Stetigkeit, Differenzierbarkeit zu benutzen, miteinander zu verknüpfen und auf andere Bereiche anzuwenden",
            "Grundlegende Konzepte, Methoden und numerische Verfahren der eindimensionalen Analysis für die folgenden Themengebiete\n\nLogische Grundlagen und Beweisverfahren, insbesondere vollständige Induktion\nFunktionen und Modelle (Polynome (Polynominterpolation, Horner-Schema,...), Log-u. Exponetialfkt., trig. Funktionen, Lösung von trigonometrischen Gleichungen und Exponential- und Logarithmusgleichungen, inverse Funktionen,...)\nDifferentiation und ihre Anwendung (Differentiationsregeln, implizite Differentiation, Extremwertaufgaben, L'Hospital, Newton-Verfahren,...)\nIntegration und ihre Anwendung\nReihen (Folgen, Konvergenz unendlicher Reihen, Taylorpolynome und -reihen,...)",
            "Folien bzw. Beamer;\"unvollständiges\" Skript für die Studierenden; Tafel;\nJustin Time Teaching (JiTT); Peer Instruction (PI); Veranschaulichung und Einübung des Gelernten u.a. mit Hilfe von Computeralgebrasystemen;",
            "Thomas, Weir, Hass: Analysis 1, Pearson, ISBN 978-3-86894-170-8\nJames Stewart: Calculus, Cengage Learning, International Metric Edition, ISBN 9780495383628",
            "https://zpa.cs.hm.edu/public/module/16/"
    );
  }

  /**
   * Creates a test module and saves it to the database.
   *
   * @return The test module.
   */
  private ResultActions postModule(Module module) throws Exception {
    String moduleJson = objectMapper.writeValueAsString(module);
    return mockMvc.perform(post("/modules")
            .contentType(MediaType.APPLICATION_JSON)
            .content(moduleJson));
  }


  /**
   * Tests if the endpoint /modules accepts a POST request with a valid module.
   *
   * @throws Exception If the test fails.
   */
  @Test
  public void testPostNewModule() throws Exception {
    Module testModule = createTestModule();
    postModule(testModule).andExpect(status().isCreated());
  }

  /**
   * Tests if the endpoint /modules accepts multiple POST requests with valid modules.
   *
   * @throws Exception If the test fails.
   */
  @Test
  public void testPostMultipleModules() throws Exception {
    // Read the JSON file
    String jsonContent = readJson("mock_modules.json");

    // Parse the JSON content into a list of modules
    List<Module> modules = objectMapper.readValue(jsonContent, new TypeReference<List<Module>>() {
    });

    // Iterate over the list and post each module
    for (Module module : modules) {
      String moduleJson = objectMapper.writeValueAsString(module);

      mockMvc.perform(post("/modules")
                      .contentType(MediaType.APPLICATION_JSON)
                      .content(moduleJson))
              .andExpect(status().isCreated());
    }
  }

  /**
   * Tests if the endpoint /modules returns a list of modules.
   *
   * @throws Exception If the test fails.
   */
  @Test
  public void testGetAllModules() throws Exception {
    mockMvc.perform(get("/modules"))
            .andExpect(status().isOk());
//                .andExpect(jsonPath("$", hasSize(greaterThanOrEqualTo(0))));
  }

  /**
   * Tests if the endpoint /modules/{id} returns a module with the given id.
   *
   * @throws Exception If the test fails.
   */
  @Test
  public void testFindModuleById() throws Exception {
    long validId = 1L; // Replace with a valid ID
    mockMvc.perform(get("/modules/" + validId))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.id", is((int) validId)));

    long invalidId = 999L; // Replace with an invalid ID
    mockMvc.perform(get("/modules/" + invalidId))
            .andExpect(status().isNotFound())
            .andExpect(result -> assertInstanceOf(ModuleNotFoundException.class, result.getResolvedException()))
            .andExpect(result -> assertEquals("Could not find module with id " + invalidId, result.getResolvedException().getMessage()));
  }

  /**
   * Tests if the endpoint /modules can update a module.
   *
   * @throws Exception If the test fails.
   */
  @Test
  public void testUpdateModule() throws Exception {
    // Assuming you have a method to create a test module
    Module testModule = createTestModule();
    MvcResult result = postModule(testModule).andReturn();
    Module savedModule = objectMapper.readValue(result.getResponse().getContentAsString(), Module.class);
    savedModule.setName("Updated Name"); // Change some fields
    savedModule.setAnzahlSprachen(3);

    mockMvc.perform(put("/modules/" + savedModule.getId()) // Use the ID from the saved module
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(savedModule)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.name", is("Updated Name")))
            .andExpect(jsonPath("$.anzahlSprachen", is(3)));
  }

  /**
   * Tests if the endpoint /modules can delete a module.
   *
   * @throws Exception If the test fails.
   */
  @Test
  public void testDeleteModule() throws Exception {
    Module testModule = createTestModule();
    MvcResult result = postModule(testModule).andReturn();
    Module savedModule = objectMapper.readValue(result.getResponse().getContentAsString(), Module.class);

    mockMvc.perform(delete("/modules")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(savedModule)))
            .andExpect(status().isOk());

    mockMvc.perform(get("/modules/" + savedModule.getId()))
            .andExpect(status().isNotFound());
  }

  /**
   * Tests validation of the module.
   *
   * @throws Exception If the test fails.
   */
  @Test
  public void testModuleValidation() throws Exception {
    Module invalidModule = new Module();

    mockMvc.perform(post("/modules")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(invalidModule)))
            .andExpect(status().isBadRequest());
  }
}
