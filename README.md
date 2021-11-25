# Welcome to RawHummus <img src='https://github.com/YonghuiDong/RawHummus/blob/main/inst/shiny/Gui/mds/pix/logo.png' align="right" height="130"/>

## Introduction

RawHummus is an R Shiny app for Assessing LC–MS system performance by visualising instrument log files and monitoring raw quality control samples within a project.

[![CRAN status](http://www.r-pkg.org/badges/version/RawHummus)](https://cran.r-project.org/package=RawHummus)

## Installation

```
install.packages('RawHummus')
```

## Usage

```
RawHummus::runGui()
```

## Main Functions

<img src="https://github.com/YonghuiDong/RawHummus/blob/main/inst/shiny/Gui/mds/pix/Fig1.png" width = "75%"/>

## Docker 

Dockerized RawHummus App is available on [Docker Hub](https://hub.docker.com/r/biodong/rawhummus)

To run this Shiny App on your computer:

```
docker pull biodong/rawhummus
docker run --rm -p 3838:3838 biodong/rawhummus
```

and it will avaliable at http://0.0.0.0:3838
