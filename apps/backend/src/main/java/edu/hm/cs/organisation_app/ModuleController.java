package edu.hm.cs.organisation_app;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.MethodArgumentNotValidException;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

@RestController
class ModuleController {

    @Autowired
    private ModuleRepository repository;

    ModuleController(ModuleRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/modules")
    public Page<Module> allModules(@RequestParam(defaultValue = "0") int page,
                                   @RequestParam(defaultValue = "10") int size,
                                   @RequestParam(defaultValue = "name") String sortBy,
                                   @RequestParam(defaultValue = "asc") String sortDir) {
        Sort.Direction direction = sortDir.equalsIgnoreCase("asc") ? Sort.Direction.ASC : Sort.Direction.DESC;
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortBy));
        return this.repository.findAll(pageable);
    }

    @GetMapping("/modules/{id}")
    public Module findModule(@PathVariable Long id) {
        return this.repository.findById(id).orElseThrow(() -> new ModuleNotFoundException(id));
    }

    @PostMapping("/modules")
    public ResponseEntity<Module> newModule(@Valid @RequestBody Module newModule) {
        return ResponseEntity.status(HttpStatus.CREATED).body(this.repository.save(newModule));
    }

    @Transactional
    @PutMapping("/modules/{id}")
    public Module updateModule(@Valid @RequestBody Module sentModule, @PathVariable Long id) {
        Module currentModule = this.repository.findById(id).orElseThrow(() -> new ModuleNotFoundException(sentModule.getId()));
        currentModule.setZpaId(sentModule.getZpaId());
        currentModule.setName(sentModule.getName());
        currentModule.setAnzahlSprachen(sentModule.getAnzahlSprachen());
        currentModule.setVerantwortlich(sentModule.getVerantwortlich());
        currentModule.setSws(sentModule.getSws());
        currentModule.setEcts(sentModule.getEcts());
        currentModule.setSprachen(sentModule.getSprachen());
        currentModule.setLehrform(sentModule.getLehrform());
        currentModule.setAngebot(sentModule.getAngebot());
        currentModule.setAufwand(sentModule.getAufwand());
        currentModule.setVoraussetzungen(sentModule.getVoraussetzungen());
        currentModule.setZiele(sentModule.getZiele());
        currentModule.setInhalt(sentModule.getInhalt());
        currentModule.setMedienUndMethoden(sentModule.getMedienUndMethoden());
        currentModule.setLiteratur(sentModule.getLiteratur());
        currentModule.setUrl(sentModule.getUrl());
        return this.repository.save(currentModule);
    }

    @Transactional
    @DeleteMapping("/modules")
    public void deleteModule(@RequestBody Module sentModule) {
        Module currentModule = this.repository.findById(sentModule.getId()).orElseThrow(() -> new ModuleNotFoundException(sentModule.getId()));
        this.repository.delete(currentModule);
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(
            MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return errors;
    }
}
