package edu.hm.cs.organisation_app.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class ModuleTest {
    /* Fields */
    Module module;

    /**
     * Tests the default constructor.
     */
    @Test
    void testDefaultConstructor() {
        // Arrange & Act.
        module = new Module();

        Assertions.assertNull(module.getId());
        Assertions.assertNull(module.getZpaId());
        Assertions.assertNull(module.getName());
        Assertions.assertEquals(0, module.getAnzahlSprachen());
        Assertions.assertNull(module.getVerantwortlich());
        Assertions.assertEquals(0, module.getSws());
        Assertions.assertEquals(0, module.getEcts());
        Assertions.assertNull(module.getSprachen());
        Assertions.assertNull(module.getLehrform());
    }


    @Test
    public void testGettersAndSetters() {
        // Arrange.
        long id = 1L;
        Module module1 = new Module(
                1L,
                "TestModule",
                1,
                "TestResponsible",
                1,
                1,
                "TestLanguage",
                "TestFormOfTeaching",
                "TestOffer",
                "TestWorkload",
                "TestRequirements",
                "TestGoals",
                "TestContent",
                "TestMediaAndMethods",
                "TestLiterature",
                "TestUrl"
        );

        Long zpaId = 1L;
        String moduleName = "TestModule2";
        String moduleResponsible = "TestResponsible2";
        String moduleLanguage = "TestLanguage2";
        String moduleFormOfTeaching = "TestFormOfTeaching2";
        String moduleOffer = "TestOffer2";
        String moduleWorkload = "TestWorkload2";
        String moduleRequirements = "TestRequirements2";
        String moduleGoals = "TestGoals2";
        String moduleContent = "TestContent2";
        String moduleMediaAndMethods = "TestMediaAndMethods2";
        String moduleLiterature = "TestLiterature2";
        String moduleUrl = "TestUrl2";

        module1.setZpaId(zpaId);
        module1.setName(moduleName);
        module1.setVerantwortlich(moduleResponsible);
        module1.setSprachen(moduleLanguage);
        module1.setLehrform(moduleFormOfTeaching);
        module1.setAngebot(moduleOffer);
        module1.setAufwand(moduleWorkload);
        module1.setVoraussetzungen(moduleRequirements);
        module1.setZiele(moduleGoals);
        module1.setInhalt(moduleContent);
        module1.setMedienUndMethoden(moduleMediaAndMethods);
        module1.setLiteratur(moduleLiterature);
        module1.setUrl(moduleUrl);

        Assertions.assertEquals(zpaId, module1.getZpaId());
        Assertions.assertEquals(moduleName, module1.getName());
        Assertions.assertEquals(moduleResponsible, module1.getVerantwortlich());
        Assertions.assertEquals(moduleLanguage, module1.getSprachen());
        Assertions.assertEquals(moduleFormOfTeaching, module1.getLehrform());
        Assertions.assertEquals(moduleOffer, module1.getAngebot());
        Assertions.assertEquals(moduleWorkload, module1.getAufwand());
        Assertions.assertEquals(moduleRequirements, module1.getVoraussetzungen());
        Assertions.assertEquals(moduleGoals, module1.getZiele());
        Assertions.assertEquals(moduleContent, module1.getInhalt());
        Assertions.assertEquals(moduleMediaAndMethods, module1.getMedienUndMethoden());
        Assertions.assertEquals(moduleLiterature, module1.getLiteratur());
        Assertions.assertEquals(moduleUrl, module1.getUrl());

        Assertions.assertNotNull(module1.toString());
        Module module2 = new Module(
                1L,
                "TestModule",
                1,
                "TestResponsible",
                1,
                1,
                "TestLanguage",
                "TestFormOfTeaching",
                "TestOffer",
                "TestWorkload",
                "TestRequirements",
                "TestGoals",
                "TestContent",
                "TestMediaAndMethods",
                "TestLiterature",
                "TestUrl"
        );

        Module moduleCopy = new Module(
                1L,
                "TestModule",
                1,
                "TestResponsible",
                1,
                1,
                "TestLanguage",
                "TestFormOfTeaching",
                "TestOffer",
                "TestWorkload",
                "TestRequirements",
                "TestGoals",
                "TestContent",
                "TestMediaAndMethods",
                "TestLiterature",
                "TestUrl"
        );

        Object notAModule = new Object();
        Assertions.assertFalse(module1.equals(null)); // Test with null
        Assertions.assertFalse(module1.equals(notAModule)); // Test with different class object
        Assertions.assertFalse(module1.equals(module2)); // Test with different module
        Assertions.assertTrue(module1.equals(module1)); // Test with same reference
        Assertions.assertTrue(module2.equals(moduleCopy)); // Test with two equal modules

        // Assert hashCode method
        Assertions.assertEquals(module1.hashCode(), module1.hashCode()); // Consistency check
        Assertions.assertEquals(module2.hashCode(), moduleCopy.hashCode()); // Equal objects have equal hash codes
        Assertions.assertNotEquals(module1.hashCode(), module2.hashCode()); // Unequal objects, likely different hash codes
    }
}
