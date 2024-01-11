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
        Module module = new Module(
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

        module.setZpaId(zpaId);
        module.setName(moduleName);
        module.setVerantwortlich(moduleResponsible);
        module.setSprachen(moduleLanguage);
        module.setLehrform(moduleFormOfTeaching);
        module.setAngebot(moduleOffer);
        module.setAufwand(moduleWorkload);
        module.setVoraussetzungen(moduleRequirements);
        module.setZiele(moduleGoals);
        module.setInhalt(moduleContent);
        module.setMedienUndMethoden(moduleMediaAndMethods);
        module.setLiteratur(moduleLiterature);
        module.setUrl(moduleUrl);

        Assertions.assertEquals(zpaId, module.getZpaId());
        Assertions.assertEquals(moduleName, module.getName());
        Assertions.assertEquals(moduleResponsible, module.getVerantwortlich());
        Assertions.assertEquals(moduleLanguage, module.getSprachen());
        Assertions.assertEquals(moduleFormOfTeaching, module.getLehrform());
        Assertions.assertEquals(moduleOffer, module.getAngebot());
        Assertions.assertEquals(moduleWorkload, module.getAufwand());
        Assertions.assertEquals(moduleRequirements, module.getVoraussetzungen());
        Assertions.assertEquals(moduleGoals, module.getZiele());
        Assertions.assertEquals(moduleContent, module.getInhalt());
        Assertions.assertEquals(moduleMediaAndMethods, module.getMedienUndMethoden());
        Assertions.assertEquals(moduleLiterature, module.getLiteratur());
        Assertions.assertEquals(moduleUrl, module.getUrl());

        Assertions.assertNotNull(module.toString());
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

        Assertions.assertFalse(module.equals(module2));
        Assertions.assertTrue(module.equals(module));
    }
}
