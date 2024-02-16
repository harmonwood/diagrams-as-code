# Diagrams as Code
Diagrams and graphs are important visual aids in any development lifecycle. This project aims at making ability to generate, change, and collaberate on these artifacts as easy as we do with code.

The power to keep track of diagram source material. The freedom for new project members to edit them freely with oversite of pier review. Helping keep documentation and code growing togeather.

There are two major ways of using this repository:
1. As a Container Compose task
2. In a pipeline through Make files and a container runner


>[!NOTE]
This is a major fork of [Nosahama's Diagrams as Code](https://github.com/nosahama/docker-c4-uml-diagrams) work. Special thanks to their foundational work.

## Tools

The project includes ability to generate diagrams from code using:

- Python - [diagrams](https://diagrams.mingrammer.com/). Generates architecture diagrams from python code.
- Uml - [plantuml](https://plantuml.com/). Generates any uml diagram.
- C4 Model - [c4-plantuml](https://github.com/plantuml-stdlib/C4-PlantUML). Generates diagrams from uml code with C4 resources available.
- Docker - To run and containerize the tools.

## Example Outputs (`png`)

### C4

![test_c4](https://user-images.githubusercontent.com/16656207/179087128-b4fe4921-abfd-42ce-9c03-fb7b382d366c.png)

### Uml

![test](https://user-images.githubusercontent.com/16656207/179087059-f841f2fb-699a-4466-821e-ef8bd519477d.png)

### Python

![consumer](https://user-images.githubusercontent.com/16656207/179086957-85fffea6-bd55-4d88-9598-a69f5a4d0302.png)

## 1. Run as task

### TLDR;
Simply use the DockerHub pre-compiled image by adding the following to a compose file:
```
version: '3.4'

services:
  diagram-builder-task:
    image: harmonwood/diagrams-as-code:latest
    container_name: diagram-builder-task
    environment:
      - RUN_AS_TASK=true
    volumes:
      - ./diagrams:/opt/diagrams
      - ./output:/opt/output
```

That's it! The next time you run `docker compose up` or `docker compose restart diagram-builder-task` in your project. The `output` folder will have the newly built images.

>[!NOTE]
This container does exit after completion. If you are looking for a more persistant service try the [offical PlantUML Server](https://plantuml.com/server)

### Details of task
Set the envirionment variable:
```
RUN_ASK_TASK=true
```

This will automaticly build everything mounted in the /opt/diagrams directory

### Diagrams directory

The `/opt/diagrams` directory is flat so that all the umls, pumls, or py files can be read and run at the same time.

Volume mount to this directory to provide diagram files to the container for parsing.

### Output

Any volume mount at `/opt/output` will get the resulting png files.

## 2. CI/CD Workflow w/Make

`make help`

#### Run container

`make run-container`

- builds the docker image and runs the container

#### Generate Diagrams

##### C4 Model

`filename=test_c4 inputext=puml outputext=png make diagrams-uml`

##### UML

`filename=test inputext=uml outputext=png make diagrams-uml`

##### Python

`filename=consumer inputext=py outputext=png make diagrams-py`

#### Stop container

`make stop-container`

## plantuml.jar

You can change the version of the PlantUML binary during an image rebuild via the environemt variable `PLANTUML_VERSION`

example:
```
docker build -e PLANTUML_VERSION=1.2024.0 diagrams-as-code
```
