# openCX-*your module name* Development Report

Welcome to the documentation pages of the Trabalho do Grupo de ESOF of **openCX**!

You can find here detailed about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

Filipe Almeida
Luís Mendes
Luís Oliveira
Miguel Vieira
Pedro ALves

## Product Vision
Our app provides simple and interactive quizzes for both the sponsoring companies of a conference and the people attending it who are looking to connect in a more fun and interesting way.

---
## Elevator Pitch
Our project aims to ease a common trouble among conferences nowadays. We want to give both the users and companies a better and easier way to interact with each other. We want to build an android app that tries to achieve this goal by allowing the various companies that attend a convention to create and share various quizzes with those that visit it.  
The quizzes' main objective, besides making the player curious and actively look for the answers, is for the people to interact directly with the various companies' representatives. To further motivate the attendants to interact with the companies, the quizzes may have certain rewards attached to their completion. These rewards can only be obtained after the attendant speaks with the respective representative of the company.

---
## Requirements

### Use case diagram

(colocar o diagrama)

* **Actor**. Conference participant
* **Description**. Accessing and answering a quiz available through codes in a company's booth. 
* **Preconditions and Postconditions**. The user must get the code and either read is as a QR code or insert the code manually to access the quiz. After answering the quiz the user can review the answers but can't retake it. 

* **Normal Flow**. The user must log in or create account, go to a booth with a code, read the code as QR code or insert it manually(in case QR fails), answer the quiz and submit the answers, get the results. 
* **Alternative Flows and Exceptions**. In the log in the system should detect invalid username/password combinations just as it should detect repeated usernames when creating a new account. The response to these issues should always be asking for a new input. When trying to access a quiz, an invalid code will generate more or less the same response.


* **Actor**. Sponsoring Company
* **Description**. Crete a multiple question quiz to be answered by the conference participants. 
* **Preconditions and Postconditions**. To create an account that has the ability to make quizzes, the companies must insert a special secret code that should be provided by the organizers before the event. After the creation, the account will have the option to remove the quiz. 

* **Normal Flow**. Log in or create a new company account, select the option to create a new quiz, add questions and respective possible answers to the quiz, submiting when all the intended questions have been inserted, receive the code that identifies thue quiz, print ant display the quizz on their respective booth(thisl ast step can also be done by the organizer). 
* **Alternative Flows and Exceptions**. In the log in the system should detect invalid username/password combinations just as it should detect repeated usernames when creating a new account. The response to these issues should always be asking for a new input. The syze of the quiz will probably be limited somehow(between 3 and 10 should be a decent size). The system will not allow the submission of quizzes with a number of questions below the minimum and will stop asking for new ones when the maximum has been hit.


### User stories
* User Stories - <https://trello.com/b/5j9l3GvD/user-stories>


### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.

---

## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts; 
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams or component diagrams (separate or integrated), showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for openCX are, for example, frameworks for mobile applications (Flutter vs ReactNative vs ...), languages to program with microbit, and communication with things (beacons, sensors, etc.).

### Prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation
Regular product increments are a good practice of product management. 

While not necessary, sometimes it might be useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. Since the code should speak by itself, try to keep this section as short and simple as possible.

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

---
## Test

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:
* test plan describing the list of features to be tested and the testing methods and tools;
* test case specifications to verify the functionalities, using unit tests and acceptance tests.
 
A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---
## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Example of tools to do this are:
  * [Trello.com](https://trello.com)
  * [Github Projects](https://github.com/features/project-management/com)
  * [Pivotal Tracker](https://www.pivotaltracker.com)
  * [Jira](https://www.atlassian.com/software/jira)

We recommend to use the simplest tool that can possibly work for the team.
