# Willkommen in das Projekt Organisation App: Software Engineering I!

## Was wird in diesem Projekt gemacht?

Es wird eine studentische App entwickelt, um die Planung des Studiums zu unterstützen und zu vereinfachen.

### Scope der Anwendung

Mithilfe dieser App kann ein Benutzer (in der Regel ein Studierender) sich in das System einloggen und seine Kurse und Aufgaben verwalten. Dafür werden die Module aus ZPA als Basis für die Kurse dienen. Ein Studierender kann somit aus einer Liste von ZPA-Modulen in der App Kurse auswählen und sich für diese anmelden. Diese werden dann in der App angezeigt und verfolgt. Darüber hinaus kann der Benutzer sie so einstellen, dass automatische ToDos für Vorlesungen und Praktika angelegt werden. Basierend auf diese Aufgaben wird ein gesamt Fortschritt im Kurs berechnet. Außerdem ist eine Integration mit bekannten externen Systemen der Hochschule wie Moodle, Primuss und das HM-ChatGPT umgesetzt. Somit kann der Benutzer diese externen Systeme in der App bequem bedienen.

### Stakeholder

Die Stakeholder bei dieser App sind:

- Studenten: sie verwenden die App als Hauptnutzer.
- Lehrpersonal: sie wollen, dass die Modulinformationen stimmen.
- IT-Administratoren: sie warten die Server und die Datenbank.

### Kontextdiagramm

![2024-01-11 19_32_36-Context_diagram_OrganisationApp.drawio.pdf - PDF Annotator.png](uploads/be8fd0af7b440034bb971ebc292a644e/2024-01-11_19_32_36-Context_diagram_OrganisationApp.drawio.pdf_-_PDF_Annotator.png){width="579" height="321"}

(Dieses Diagramm ist ebenfalls unter **\<root\>/docs/requirements** zu finden.)

### Brainstorming

Die Ergebnisse des Brainstormings sind hier zu sehen:

![2024-01-11_16_36_29-Idea_Brainstorming___SE](uploads/0e3807347ebe2428dcf40e7f288d73ea/2024-01-11_16_36_29-Idea_Brainstorming___SE.png){width="344" height="415"}

![2024-01-11_16_43_31-Idea_Brainstorming___SE](uploads/48f77994469c1b7a8dcae8fda2a99c94/2024-01-11_16_43_31-Idea_Brainstorming___SE.png){width="609" height="326"}

Ein Zugang auf dem Mural erfolgt durch den folgenden Link: https://app.mural.co/t/se6496/m/se6496/1698070110369/e8d45276f379b86a4a25b2ea7e2798e338fc90e3?sender=u0ddebf83cf5aa621c9862776

### Wireframes

Die geplanten Wireframes der App sind folgende:

![2024-01-11 17_03_16-Calendar – Figma.png](uploads/7bb3c73629d236f744607ce53a05477a/2024-01-11_17_03_16-Calendar___Figma.png){width="548" height="375"}

![2024-01-11 17_04_00-Calendar – Figma.png](uploads/d505152ba7d7f3b1e0965f7c27d4b569/2024-01-11_17_04_00-Calendar___Figma.png){width="548" height="379"}

![2024-01-11 17_04_15-Calendar – Figma.png](uploads/c738f24681b3b9ea996f37f0a64cfaca/2024-01-11_17_04_15-Calendar___Figma.png){width="547" height="378"}

Ein Zugang auf dem Figma-Modell erfolgt durch den folgenden Link: https://www.figma.com/file/D3ZcJPw4mb0CA0Yh67KRHE/Calendar?type=design&t=DMNf7h6arO1g86ag-6

(Diese sind ebenfalls unter **\<root\>/docs/wireframes** zu finden.)

### Fachliches Datenmodell

Das folgende UML-Datenmodell wird in der App verwendet:

![2024-01-11 17_37_32-Class_diagram.pdf - PDF Annotator.png](uploads/02ecc24ccade03f3779082334d262a91/2024-01-11_17_37_32-Class_diagram.pdf_-_PDF_Annotator.png){width="677" height="396"}

Dieses basiert auf das folgende ER-Modell:

![2024-01-11 17_43_15-ER_Model.pdf - PDF Annotator.png](uploads/43dc1b574573122b4cb91f378745fc94/2024-01-11_17_43_15-ER_Model.pdf_-_PDF_Annotator.png){width="673" height="443"}

(Diese sind unter **\<root\>/docs/data_model** zu finden.)

### Aktivitätsdiagramm

Die Aktivitätsdiagramme pro Hauptkomponente sind:

* MyCourses: [Activity Diagram - MyCourses](https://gitlab.lrz.de/swe1_ws_2324/projects/project_05/-/blob/main/docs/workflow/Activity_diagram_MyCourses.drawio.pdf)
* Modules: [Activity Diagram - Modules](https://gitlab.lrz.de/swe1_ws_2324/projects/project_05/-/blob/main/docs/workflow/Module_swim_lane.drawio.pdf)
* Tasks: [Activity Diagram - Tasks](https://gitlab.lrz.de/swe1_ws_2324/projects/project_05/-/tree/main/docs/workflow/Activity_diagramm_todo.drawio.pdf)

(Diese werden verlinkt, da sie hier teilweise zu groß für ein Bild sind. Diese sind unter **\<root\>/docs/workflow** zu finden.)

### Testplanung

Die Testplanung pro Hauptkomponente ist hier abgelegt:

* MyCourses: [Test Documentation MyCourses - Angel](https://gitlab.lrz.de/swe1_ws_2324/projects/project_05/-/blob/main/docs/test/Testconcept_OrganisationApp_MyCourses_Angel.xlsx)
* Modules: [Test Documentation Modules - Leon](https://gitlab.lrz.de/swe1_ws_2324/projects/project_05/-/blob/main/docs/test/Testconcept_OrganisationApp_Modules_Leon.xlsx)
* Tasks: [Test Documentation Tasks - Jan](https://gitlab.lrz.de/swe1_ws_2324/projects/project_05/-/blob/main/docs/test/Testconcept_OrganisationApp_Tasks_Jan.xlsx)

(Diese werden verlinkt, da sie nicht visualisiert werden können. Diese sind unter **\<root\>/docs/test** zu finden.)

### Aktuelles code coverage

#### Frontend

![frontend_line_coverage_stats.png](uploads/85fc613813fe228e343542ade98289c6/frontend_line_coverage_stats.png){width="692" height="406"}

#### Backend

![Backend_line_coverage_stats.png](uploads/f027cc0332c702e11294d2c942c52506/Backend_line_coverage_stats.png){width="690" height="469"}

## Organisatorisches

### Meetings

- Weekly: Jeden Donnerstag im Praktikum vor Ort
- Update-Termin: Jeden Sonntag um 10 Uhr auf Zoom.

### Kanäle

Kommunikation hauptsächlich im WhatsApp-Chat und vor Ort.

### Rollen

Das Projekt ist Scrum basiert. Allerdings sind wir alle Developers.

### Prozesse

#### Sprints

Jedes Sprint dauer 2 Wochen.

#### Arbeiten mit dem VCS Git

Im Branch "main" liegt die funktionsfähige App. In diesem Branch sind die Releases zu finden. Im Branch "develop" liegt der Prototyp der App mit den neuesten Features und korrigierten Bugs.

Jede Feature und jedes Bug wird eigenständig in einen neuen Branch umgesetzt/korrigiert. Ein Branch für ein Feature hat den Namen "feature/FeatureName". Ein Branch für ein Bug hat den Namen "bug/BugName".

Merges von Feature/Bug-Branches sind von jedem Teilnehmer eigenständig ins "develop" local zu mergen und dann zu pushen. Dafür reicht ein kurzes Feedback von einer der Reviewers.

Ein Release von "develop" zu "main" erfordert die Anwesenheit (wenn möglich) von allen Teilnehmer. Alle Tests müssen erfolgreich sein, um den Release durchzuführen.

## Sonstiges

### Bisherige Erfahrungen in Projekten

#### Was haben wir gemacht?

- Angewandte Mathematik im Rahmen des Studiums.
- Firmenprojekte (als Werkstudent-Tätigkeiten)

#### Was hat gut geklappt?

- Fähige Mitarbeiter.
- Interessierte und motivierte Leute.
- Gute Stimmung und ein eng zusammenarbeitendes Team.

#### Was hat nicht gut geklappt?

- Zu schnelles Onboarding bzw. kein richtiges Onboarding.
- Unklare und sich ändernde Anforderungen.
- Unklare definierte Deadlines.
- Schlechte und nicht ehrliche Kommunikation.
- Aufgaben nicht rechtzeitig bearbeitet.

#### Wie könnte man es besser gestalten?

- Bessere Kommunikation: daily/weekly Austausch.
- Bessere Auswahl an motivierten Mitarbeitenden (sofern es geht).
- Genauere Anforderungen und besseres Anforderungsmanagement.
- Meilensteine setzen.
