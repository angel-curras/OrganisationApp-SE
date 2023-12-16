package edu.hm.cs.organisation_app.service;

import edu.hm.cs.organisation_app.model.Module;
import edu.hm.cs.organisation_app.database.ModuleRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ModuleService {

    private final ModuleRepository repository;

    // Constructor injection is recommended for dependency injection
    public ModuleService(ModuleRepository repository) {
        this.repository = repository;
    }

    public Page<Module> fetchFromSearchQuery(String searchQuery, Pageable pageable) {
        // Implement the search logic here
        return repository.findByNameContainingOrVerantwortlichContaining(searchQuery, searchQuery, pageable);
    }

    public Page<Module> findAll(Pageable pageable) {
        return repository.findAll(pageable);
    }
}
