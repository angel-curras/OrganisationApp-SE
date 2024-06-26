package edu.hm.cs.organisation_app.model;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class ModuleNotFoundException extends RuntimeException {
    public ModuleNotFoundException(Long id) {
        super("Could not find module with id " + id);
    }
}
