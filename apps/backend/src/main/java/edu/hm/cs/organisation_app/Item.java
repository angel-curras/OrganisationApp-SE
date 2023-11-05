package edu.hm.cs.organisation_app;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

import java.util.Objects;

@Entity
class Item {

    /**
     * Eindeutige ID des Items. Wird von der Datenbank generiert.
     */
    private @Id
    @GeneratedValue Long id;

    /**
     * Name des Items.
     */
    private String name;

    /**
     * Beschreibung des Items.
     */
    private String description;

    /**
     * Default Konstruktor. Wir für die Interaktion mit der Datenbank benötigt.
     */
    public Item() {
    }

    /**
     * Custom Konstruktor für Name und Beschreibung des Itesm.
     *
     * @param name
     * @param description
     */
    public Item(String name, String description) {
        this.name = name;
        this.description = description;
    }

    // Getter und Setter für alle Eigenschaften eines Items.
    // Werden für die Interaktion mit der Datenbank benötigt.
    public Long getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public String getDescription() {
        return this.description;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Item item = (Item) o;
        return Objects.equals(id, item.id) && Objects.equals(name, item.name) && Objects.equals(description, item.description);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, description);
    }

    @Override
    public String toString() {
        return "Item{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}