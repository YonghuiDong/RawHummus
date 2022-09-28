# Welcome to RawHummus <img src='https://github.com/YonghuiDong/RawHummus/blob/main/inst/shiny/Gui/mds/pix/logo.png' align="right" height="130"/>

## 1. Introduction

[![CRAN status](http://www.r-pkg.org/badges/version/RawHummus)](https://cran.r-project.org/package=RawHummus) 
[![CRAN downloads](http://cranlogs.r-pkg.org/badges/grand-total/RawHummus)](https://cran.r-project.org/package=RawHummus)


`RawHummus` is an R Shiny app for assessing LC–MS system performance by visualising instrument log files and monitoring raw quality control samples within a project.

## 2. Installation

```
install.packages('RawHummus')
```

## 3. Usage

1. **To run RawHummus locally**

This option is particularly **recommended** when you have a large number of QC samples to test.

Run the following script, the Web App will pop up and you can then enjoy using RawHummus

```
RawHummus::runGui()
```

2. **Use the website**

Alternatively, you can also access RawHummus vis [https://bcdd.shinyapps.io/RawHummus/](https://bcdd.shinyapps.io/RawHummus/). 

> **Note** 
> 
> RawHummus is deployed for free at https://www.shinyapps.io. It allows to use 1024 MB of memory. Therefore, a large numbers of files will not be uploaded and/or analyzed successfully. In this case, please run RawHummus locally.

3. **Demo Data**

A list of demo files have been provided, including log files and raw data files. Please use this [link to download](https://github.com/YonghuiDong/RawHummus_DemoData) the demo data.

## 4. Main Functions

**Figure 1.** Overview of the main functions in RawHummus

<img src="https://github.com/YonghuiDong/RawHummus/blob/main/inst/shiny/Gui/mds/pix/Fig1.png" width = "75%"/>

**Table 1.** Overview of quality metrics used in RawHummus report

| Section      | Metric                                                      | Explanation                                                                                                                                                                                                                                            |
|--------------|-------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Chromatogram** |                                                             |  
|                  | TIC plot                                                    | It is total ion current at each scan plotted as an intensity point for each raw file. Overlaid TIC plot is used for rapid inspection of RT and ion intensity fluctuations.                                                                             
|              | Summed TIC bar plot                                         | It is summed TIC of all scans in a raw file. It is used to check global ion intensity variations among raw files.                                                                                                                                      |                                                                                                                                                                                                                                           
|              | TIC correlation analysis                                    | Pairwise Pearson correlation analysis of raw files. It is used to evaluate chromatogram similarity, i.e., peak shape similarity and RT shift. Pearson correlation coefficient above 0.85 indicates that the two raw files are similar.                                                                                                                                                                                                                                                                                                                                 
|              | Max. mass difference (ppm)                                  | It is maximum m/z variation among each selected mass feature across all the raw files. It is used to evaluate the mass accuracy. If the max. mass difference is over 5 ppm, this value will be highlighted in red.                                     
| **MS1**     |                                                             |                                                                                                                                                                                                                                                        
|              | Max. RT difference (min)                                    | It is maximum retention time variation among each selected mass feature across all the raw files. It used to evaluate RT shifts. If the max. RT difference is over 1 min, this value will be highlighted in red.                                                                                                                                                                                                                                                                                             
|              | Max. intensity fold change                                  | It is the maximum intensity fold change among each selected mass feature across all the raw files. It is used to evaluate ion intensity variation. If max. intensity fold change is over 1.5, this value will be highlighted in red.                   |                                                                                                                                                                                                                                                   
|              | Intensity CV (%)                                            | It is intensity coefficient of variance (or relative standard deviation, RSD) of each selected mass feature across all the raw files. It is used to evaluate intensity variation. If intensity CV is over 30%, this value will be highlighted in red.  |
| **MS2**      |                                                             |                                                                                                                                                                                                                                                        
|              | No. of MS2 events                                           | It is number of triggered MS/MS spectra per file. It is used to evaluate MS2 event                                                                                                                                                                     
|              | Precursor ion distribution across mass plot                 | It is density plot of the precursor ion across mass range based on the triggered MS/MS events.                                                                                                                                                      
|              | Precursor ion distribution across RT plot                   | It is density plot of the precursor ion across RT range based on the triggered MS/MS events.                                                                                                                                                           |
|              | Cosine similarity of precursor ion distribution across mass | It measures the similarity of precursor ion distribution across mass. Cosine similarity score above 0.85 indicates that the precursor distributions across mass are similar between two files.                                                                                                                                                                                                                                                                                                                                                                  
|              | Cosine similarity of precursor ion distribution across RT   | It measures the similarity of precursor ion distribution across mass. Cosine similarity score above 0.85 indicates that the precursor distributions across RT are similar between two files.                                                           

**How QCViewer Works?**

In addition to allowing users to define (threoretically) unlimited numbers of mass features for system evaluation, RawHummus also automatically selects six mass features evenly across the entire RT range for a more unbiased quality check. 

The process for automatically select 6 ions are as following: 

- (1) the entire RT range is evenly sliced into 6 sub-RT ranges. The reason is that system variations are not always the same at different RTs and assessing only specific RT ranges (or ions) may fail to depict the overall system variation. 

- (2) At each sub-RT range, ion with highest ion intensities is selected for further system evaluations. 

- (3) m/z values, RTs, and ion intensities of all the 6 ions are then extracted from each QC samples and are used for system evaluation based on the parameters described in **Table 1**. The rationale behind is that ions with high intensity are less likely to be “random noise”, and their m/z values, RTs, and intensities should be consistent in a stable and well-calibrated LCMS system. Of course, this is not always the case, for instance, LCMS method usually consists of a few-minute conditioning/washing step, where most peaks are noises. It is possible that an ion peak at this RT range will be selected for system evaluation, showing a large LCMS system variation in m/z, RT, or intensity. However, this should not pose a problem in overall system evaluation, because the accompanying plot can always help the users distinguish noise peak from “real” ion signals.



## 5. Docker 

Dockerized RawHummus App is available on [Docker Hub](https://hub.docker.com/r/biodong/rawhummus)

To run this Shiny App on your computer:

```
docker pull biodong/rawhummus
docker run --rm -p 3838:3838 biodong/rawhummus
```

and it will be available at http://0.0.0.0:3838

## 6. How to cite

If you find this shiny App usful, please consider citing it:

- [Dong, Y., Kazachkova, Y., Gou, M., Morgan, L., Wachsman, T., Gazit, E. and Birkler, R.I.D., 2022. RawHummus: an R Shiny App for Automated Raw Data Quality Control in Metabolomics. Bioinformatics.](https://doi.org/10.1093/bioinformatics/btac040)
