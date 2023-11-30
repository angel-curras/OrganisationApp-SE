package edu.hm.cs.organisation_app;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.transaction.Transactional;

import java.util.Objects;

@Entity
class Module {
    /**
     * Eindeutige ID des Moduls. Wird bereitgestellt von ZPA.
     */
    private @Id
    Long id;

    /**
     * Name des Moduls.
     */
    private String name;

    /**
     * Anzahl der Sprachen, in denen das Modul angeboten wird.
     */
    private int anzahlSprachen;

    /**
     * Verantwortliche Person für das Modul.
     */
    private String verantwortlich;

    /**
     * Anzahl der Semesterwochenstunden.
     */
    private int sws;

    /**
     * Anzahl der ECTS-Punkte.
     */
    private int ects;

    /**
     * Liste der Sprachen, in denen das Modul angeboten wird.
     */
    private String sprachen;

    /**
     * Lehrform: Seminar, Praktikum, SU mit Praktikum, SU mit Übung, SU, je nach Fach.
     */
    private String lehrform;

    /**
     * Zeitpunkt, zu dem das Modul angeboten wird. (z.B. jedes Semester, jedes Wintersemester, jedes Sommersemester, nach Ankündigung)
     */
    private String angebot;

    /**
     * Aufwand in Stunden.
     */
    @Column(columnDefinition = "TEXT")
    private String aufwand;

    /**
     * Voraussetzungen für das Modul.
     */
    @Column(columnDefinition = "TEXT")
    private String voraussetzungen;

    /**
     * Lernziele des Moduls.
     */
    @Column(columnDefinition = "TEXT")
    private String ziele;

    /**
     * Inhalt des Moduls.
     */
    @Column(columnDefinition = "TEXT")
    private String inhalt;

    /**
     * Medien und Methoden des Moduls.
     */
    @Column(columnDefinition = "TEXT")
    private String medienUndMethoden;

    /**
     * Literatur des Moduls.
     */
    @Column(columnDefinition = "TEXT")
    private String literatur;

    /**
     * ZPA-URL des Moduls.
     */
    private String url;


    /**
     * Default Konstruktor. Wir für die Interaktion mit der Datenbank benötigt.
     */
    public Module() {
    }

    /**
     * Custom Konstruktor für alle Eigenschaften des Moduls.
     *
     * @param id                Eindeutige ID des Moduls. Wird bereitgestellt von ZPA.
     * @param name              Name des Moduls.
     * @param anzahlSprachen    Anzahl der Sprachen, in denen das Modul angeboten wird.
     * @param verantwortlich    Verantwortliche Person für das Modul.
     * @param sws               Anzahl der Semesterwochenstunden.
     * @param ects              Anzahl der ECTS-Punkte.
     * @param sprachen          Liste der Sprachen, in denen das Modul angeboten wird.
     * @param lehrform          Lehrform: Seminar, Praktikum, SU mit Praktikum, SU mit Übung, SU, je nach Fach.
     * @param angebot           Zeitpunkt, zu dem das Modul angeboten wird. (z.B. jedes Semester, jedes Wintersemester, jedes Sommersemester, nach Ankündigung)
     * @param aufwand           Aufwand in Stunden.
     * @param voraussetzungen   Voraussetzungen für das Modul.
     * @param ziele             Lernziele des Moduls.
     * @param inhalt            Inhalt des Moduls.
     * @param medienUndMethoden Medien und Methoden des Moduls.
     * @param literatur         Literatur des Moduls.
     * @param url               ZPA-URL des Moduls.
     */
    public Module(Long id, String name, int anzahlSprachen, String verantwortlich, int sws, int ects, String sprachen, String lehrform, String angebot, String aufwand, String voraussetzungen, String ziele, String inhalt, String medienUndMethoden, String literatur, String url) {
        this.id = id;
        this.name = name;
        this.anzahlSprachen = anzahlSprachen;
        this.verantwortlich = verantwortlich;
        this.sws = sws;
        this.ects = ects;
        this.sprachen = sprachen;
        this.lehrform = lehrform;
        this.angebot = angebot;
        this.aufwand = aufwand;
        this.voraussetzungen = voraussetzungen;
        this.ziele = ziele;
        this.inhalt = inhalt;
        this.medienUndMethoden = medienUndMethoden;
        this.literatur = literatur;
        this.url = url;
    }

    // Getter und Setter für alle Eigenschaften eines Moduls.
    // Werden für die Interaktion mit der Datenbank benötigt.
    public Long getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public int getAnzahlSprachen() {
        return this.anzahlSprachen;
    }

    public String getVerantwortlich() {
        return this.verantwortlich;
    }

    public int getSws() {
        return this.sws;
    }

    public int getEcts() {
        return this.ects;
    }

    public String getSprachen() {
        return this.sprachen;
    }

    public String getLehrform() {
        return this.lehrform;
    }

    public String getAngebot() {
        return this.angebot;
    }

    public String getAufwand() {
        return this.aufwand;
    }

    public String getVoraussetzungen() {
        return this.voraussetzungen;
    }

    public String getZiele() {
        return this.ziele;
    }

    public String getInhalt() {
        return this.inhalt;
    }

    public String getMedienUndMethoden() {
        return this.medienUndMethoden;
    }

    public String getLiteratur() {
        return this.literatur;
    }

    public String getUrl() {
        return this.url;
    }

    @Transactional
    public void setId(Long id) {
        this.id = id;
    }

    @Transactional
    public void setName(String name) {
        this.name = name;
    }

    @Transactional
    public void setAnzahlSprachen(int anzahlSprachen) {
        this.anzahlSprachen = anzahlSprachen;
    }

    @Transactional
    public void setVerantwortlich(String verantwortlich) {
        this.verantwortlich = verantwortlich;
    }

    @Transactional
    public void setSws(int sws) {
        this.sws = sws;
    }

    @Transactional
    public void setEcts(int ects) {
        this.ects = ects;
    }

    @Transactional
    public void setSprachen(String sprachen) {
        this.sprachen = sprachen;
    }

    @Transactional
    public void setLehrform(String lehrform) {
        this.lehrform = lehrform;
    }

    @Transactional
    public void setAngebot(String angebot) {
        this.angebot = angebot;
    }

    @Transactional
    public void setAufwand(String aufwand) {
        this.aufwand = aufwand;
    }

    @Transactional
    public void setVoraussetzungen(String voraussetzungen) {
        this.voraussetzungen = voraussetzungen;
    }

    @Transactional
    public void setZiele(String ziele) {
        this.ziele = ziele;
    }

    @Transactional
    public void setInhalt(String inhalt) {
        this.inhalt = inhalt;
    }

    @Transactional
    public void setMedienUndMethoden(String medienUndMethoden) {
        this.medienUndMethoden = medienUndMethoden;
    }

    @Transactional
    public void setLiteratur(String literatur) {
        this.literatur = literatur;
    }

    @Transactional
    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Module{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", anzahl_sprachen=" + anzahlSprachen +
                ", verantwortlich='" + verantwortlich + '\'' +
                ", sws=" + sws +
                ", ects=" + ects +
                ", sprachen='" + sprachen + '\'' +
                ", lehrform='" + lehrform + '\'' +
                ", angebot='" + angebot + '\'' +
                ", aufwand='" + aufwand + '\'' +
                ", voraussetzungen='" + voraussetzungen + '\'' +
                ", ziele='" + ziele + '\'' +
                ", inhalt='" + inhalt + '\'' +
                ", medien_und_methoden='" + medienUndMethoden + '\'' +
                ", literatur='" + literatur + '\'' +
                ", url='" + url + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (!(o instanceof Module module))
            return false;
        return Objects.equals(this.id, module.id) && Objects.equals(this.name, module.name) && Objects.equals(this.anzahlSprachen, module.anzahlSprachen) && Objects.equals(this.verantwortlich, module.verantwortlich) && Objects.equals(this.sws, module.sws) && Objects.equals(this.ects, module.ects) && Objects.equals(this.sprachen, module.sprachen) && Objects.equals(this.lehrform, module.lehrform) && Objects.equals(this.angebot, module.angebot) && Objects.equals(this.aufwand, module.aufwand) && Objects.equals(this.voraussetzungen, module.voraussetzungen) && Objects.equals(this.ziele, module.ziele) && Objects.equals(this.inhalt, module.inhalt) && Objects.equals(this.medienUndMethoden, module.medienUndMethoden) && Objects.equals(this.literatur, module.literatur) && Objects.equals(this.url, module.url);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id, this.name, this.anzahlSprachen, this.verantwortlich, this.sws, this.ects, this.sprachen, this.lehrform, this.angebot, this.aufwand, this.voraussetzungen, this.ziele, this.inhalt, this.medienUndMethoden, this.literatur, this.url);
    }
}
