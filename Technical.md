### Technical Notes

_Jupyter notebooks_ have been made to be compatible with Colab. For _Python_, the libraries included are in December 2022:
 
- `Python 3.8.16`
- `matplotlib 3.2.2`
- `librosa 0.8.1`
- `numpy 1.21.6`

and for _R_, the version in the Colab are:

- `R version 4.2.2`
- `tidyverse 1.3.1`
- `ggplot2 3.4.0`

Some R notebooks install extra libraries. Most of the R notebooks require installing `MusicScienceData` library available at https://github.com/tuomaseerola/MusicScienceData. 

In R, this library can be installed:

```{r}
if (!require(devtools)) install.packages("devtools",quiet=TRUE)
devtools::install_github("tuomaseerola/MusicScienceData@main",quiet=TRUE)

library(MusicScienceData)
```
