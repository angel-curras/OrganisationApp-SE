package edu.hm.cs.organisation_app;

import jakarta.persistence.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
class ItemController {

    @Autowired
    private ItemRepository repository;

    private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

    @GetMapping("/items")
    List<Item> allItems() {
        logger.info("All items were requested!");
        logger.info("Returning all items!");
        List<Item> items = this.repository.findAll();

        logger.info("Found items: " + items);
        return items;
    }

    @PostMapping("/item")
    Item newItem(@RequestBody Item newItem) {
        logger.info("Creating a new item!");
        logger.info("Received item: " + newItem);
        logger.info("Creating item with id: " + newItem.getId());
        return this.repository.save(newItem);
    }

    @PutMapping("/item")
    void updateItem(@RequestBody Item sentItem) {

        logger.info("Updating items");
        logger.info("Received item: " + sentItem);
        logger.info("Updating item with id: " + sentItem.getId());

        try {
            Item currentItem = this.repository.getReferenceById(sentItem.getId());
            currentItem.setName(sentItem.getName());
            currentItem.setDescription(sentItem.getDescription());
            this.repository.save(currentItem);
        } catch (EntityNotFoundException ex) {
            logger.error("Error updating item: " + ex.getMessage());
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND, "Item not found", ex);
        }

    }

    @DeleteMapping("/item")
    void deleteItem(@RequestBody Item sentItem) {

        logger.info("Deleting items");
        logger.info("Received item: " + sentItem);
        logger.info("Deleting item with id: " + sentItem.getId());
        this.repository.deleteById(sentItem.getId());
    }

}
