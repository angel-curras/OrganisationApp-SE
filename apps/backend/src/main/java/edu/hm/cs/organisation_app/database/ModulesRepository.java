package edu.hm.cs.organisation_app.database;

import edu.hm.cs.organisation_app.model.Module;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ModulesRepository extends JpaRepository<Module, Long> {
    Page<Module> findByNameContainingOrVerantwortlichContaining(String name, String verantwortlich, Pageable pageable);
}
