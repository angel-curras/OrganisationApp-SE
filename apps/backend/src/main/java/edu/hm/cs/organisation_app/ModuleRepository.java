package edu.hm.cs.organisation_app;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;

interface ModuleRepository extends JpaRepository<Module, Long> {
    Page<Module> findByNameContainingOrVerantwortlichContaining(String name, String verantwortlich, Pageable pageable);
}