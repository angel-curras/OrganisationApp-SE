package edu.hm.cs.organisation_app;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

interface ModuleRepository extends JpaRepository<Module, Long> {
    Page<Module> findByNameContainingOrVerantwortlichContaining(String name, String verantwortlich, Pageable pageable);
}
