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

@RestController
class ModuleController {

    @Autowired
    private ModuleRepository repository;

    ModuleController(ModuleRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/modules")
    public List<Module> allModules() {
        return this.repository.findAll();
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
