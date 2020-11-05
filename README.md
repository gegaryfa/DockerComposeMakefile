# Docker Compose Makefile

[![license](https://img.shields.io/github/license/gegaryfa/DockerComposeMakefile)](https://github.com/gegaryfa/DockerComposeMakefile/blob/master/LICENSE)
![GitHub stars](https://img.shields.io/github/stars/gegaryfa/DockerComposeMakefile)

A docker compose makefile template

## Getting Started

Clone the repo, open a terminal and run 

```bash
make
``` 
to see all the possible actions.

![makefile](img/make.PNG)

### Prerequisites

* [`GNU Make`](https://www.gnu.org/software/make/)

### Usage

Place the `Makefile` and `config.env` files on the same folder as your docker-compose.yml file. This `makefile` uses a `docker-compose.override.yml` file but of course you can rename it[check the `config.env`]

## Sources
Overview of docker-compose CLI: [Docker Compose](https://docs.docker.com/compose/reference/overview/)


## Authors

* **George Garyfallou** - *Initial work* - [gegaryfa](https://github.com/gegaryfa)

## Acknowledgments

* Hat tip to anyone whose code was used
