package edu.hm.cs.organisation_app;

public class ItemNotFoundException extends RuntimeException {
    ItemNotFoundException(Long id) {
        super("Could not find item " + id);
    }
}
