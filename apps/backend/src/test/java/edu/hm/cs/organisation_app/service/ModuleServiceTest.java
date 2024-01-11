package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.database.ModuleRepository;
import edu.hm.cs.organisation_app.model.Module;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

public class ModuleServiceTest {

    @Mock
    private ModuleRepository moduleRepository;

    @InjectMocks
    private ModuleService moduleService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testFetchFromSearchQuery() {
        // Arrange
        String searchQuery = "Test";
        Module testModule = new Module(
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
        List<Module> modules = Collections.singletonList(testModule);
        Page<Module> expectedPage = new PageImpl<>(modules);
        when(moduleRepository.findByNameContainingOrVerantwortlichContaining(anyString(), anyString(), any(Pageable.class)))
                .thenReturn(expectedPage);

        // Act
        Page<Module> result = moduleService.fetchFromSearchQuery(searchQuery, Pageable.unpaged());

        // Assert
        assertEquals(expectedPage, result);
    }

    @Test
    public void testFindAll() {
        // Arrange
        Module testModule = new Module(
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
        List<Module> modules = Collections.singletonList(testModule);
        Page<Module> expectedPage = new PageImpl<>(modules);
        when(moduleRepository.findAll(any(Pageable.class))).thenReturn(expectedPage);

        // Act
        Page<Module> result = moduleService.findAll(Pageable.unpaged());

        // Assert
        assertEquals(expectedPage, result);
    }
}
