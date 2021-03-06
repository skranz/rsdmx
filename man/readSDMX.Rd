\name{readSDMX}
\Rdversion{1.1}
\alias{readSDMX}

\title{readSDMX}

\description{\code{readSDMX} is the main function to use to read SDMX data}

\usage{
readSDMX(file, isURL)
}

\arguments{
\item{file}{path to SDMX-ML document that needs to be parsed}
\item{isURL}{a value of class "logical" either the path is an url, and data has to be downloaded from a SDMXweb-repository. Default value is TRUE.}
}

\author{Emmanuel Blondel, \email{emmanuel.blondel1@gmail.com}}
\examples{

# SDMX datasets
#--------------
\donttest{
#using local files
#with SDMX 2.0
tmp <- system.file("extdata","Example_Eurostat_2.0.xml", package="rsdmx")
sdmx4 <- readSDMX(tmp, isURL = FALSE)
stats4 <- as.data.frame(sdmx4)
head(stats4)

#with SDMX 2.1
tmpnew <- system.file("extdata","Example_Eurostat_2.1.xml", package="rsdmx")
sdmx5 <- readSDMX(tmpnew, isURL = FALSE)
stats5 <- as.data.frame(sdmx5)
head(stats5)

#example 1: FAO data
url1 <- paste("http://data.fao.org/sdmx/repository/data/",
              "CROP_PRODUCTION/.156.5312.515./FAO?startPeriod=2008&endPeriod=2008",
              sep = "")
sdmx1 <- readSDMX(url1)
stats1 <- as.data.frame(sdmx1)
head(stats1)

#example 2: OECD data
url2 <- paste("http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/",
              "MIG/TOT.B11.TOT.FRA/OECD?startTime=2011&endTime=2011",
              sep = "")
sdmx2 <- readSDMX(url2)
stats2 <- as.data.frame(sdmx2)
head(stats2)

#example 3: Eurostat data 
#using url (Eurostat REST SDMX 2.1)
url3 <- paste("http://ec.europa.eu/eurostat/SDMX/diss-web/rest/data/",
              "cdh_e_fos/..PC.FOS1.BE/?startperiod=2011&endPeriod=2011",
              sep = "")
sdmx3 <- readSDMX(url3)
stats3 <- as.data.frame(sdmx3)
head(stats3)
}

# SDMX Concepts / ConceptSchemes
#-------------------------------
\donttest{
csUrl <- paste("http://data.fao.org/sdmx/registry/conceptscheme",
               "/FAO/ALL/LATEST/?detail=full&references=none&version=2.1",
               sep = "")
csobj <- readSDMX(csUrl)
csdf <- as.data.frame(csobj)
head(csdf)
}

# SDMX Codelists
#---------------
\donttest{
clUrl <- "http://data.fao.org/sdmx/registry/codelist/FAO/CL_FAO_MAJOR_AREA/0.1"
clobj <- readSDMX(clUrl)
cldf <- as.data.frame(clobj)
head(cldf)
}

# SDMX DataStructureDefinition (DSD)
#-----------------------------------
\donttest{
dsdUrl <- paste("http://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/",
                "WATER_ABSTRACT",
                sep = "")
dsd <- readSDMX(dsdUrl)

#get codelists from DSD
cls <- dsd@codelists
codelists <- sapply(cls@codelists, function(x) x@id) #get list of codelists

#get a codelist
codelist <- as.data.frame(dsd@codelists,
                          codelistId = "CL_WATER_ABSTRACT_SOURCE")

#get concepts from DSD
concepts <- as.data.frame(dsd@concepts)
}
}
