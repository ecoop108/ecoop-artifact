# Artifact for a Language-based version control system

This repository provides the artifact for our submission to Ecoop 2024 titled "A Language-Based Version Control System". It contains a compiler and a VS-Code extension to manage versioned programs.

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)

## Getting started

### Prerequisites
You should have Docker installed on your machine and at least 2GB of free space.

### Installation
Clone this repository locally to your machine and `cd` to its directory:

```bash
git clone https://github.com/ecoop108/ecoop-artifact.git
cd ecoop-artifact
```

Build the Docker image:

```bash
docker build -t vpy:latest .
```

Run the Docker image and bind port `8443` of the container to an available port (e.g. `8080`) on your machine:

```bash
docker run -p 0.0.0.0:8080:8443 vpy:latest
```

## Usage
After the container is running, open your web browser and go to `localhost:8080`. This should open a VS-Code editor with the examples loaded and the extension installed.

Open one of the examples (e.g. `name.py`) and then click on the extension (Version Explorer) on the left sidebar. You may need to click the Refresh icon after opening a new file.

![Version explorer extension](./resources/version-explorer.png)

The extension allows you to manage the version graph:
- You can see replacement versions (commits) and upgrade versions (branches).
- You can add replacement or upgrade versions by right-clicking on a version name.
- You can edit a snapshot of a version by clicking the pencil icon (Edit) next to its name.
- You can project a slice for that version by clicking the document icon (Project slice) next to its name.

You also have the compiler, `vpy`, available system-wide in the container. To check its usage, use the command:

```bash
vpy --help
```
Error reporting is not (yet) integrated into the extension. If you write a program that produces errors, you are unable to see the error in the editor. Instead, you can open the terminal in the editor and run the command:

```bash
vpy -i <file> -t <target>
```

In the terminal you are able to see the errors.

To run the client code (e.g. function `main` in file `name.py`), use the standard python interpreter:

```bash
python3.11 name.py
```