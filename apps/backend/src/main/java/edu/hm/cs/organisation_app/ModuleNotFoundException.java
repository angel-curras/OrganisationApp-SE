package edu.hm.cs.organisation_app;

public class ModuleNotFoundException extends RuntimeException {
    ModuleNotFoundException(Long id) {
        super("Could not find module with id " + id);
    }
}
