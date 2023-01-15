#If require = pour importer (Installer en cas de besoin) les packages nécessaires pour la bonne exécution de notre projet

if(!require(shiny)) install.packages("shiny", repos = "http://cran.us.r-project.org")
if(!require(shinyWidgets)) install.packages("shinyWidgets", repos = "http://cran.us.r-project.org")
if(!require(shinydashboard)) install.packages("shinydashboard", repos = "http://cran.us.r-project.org")
if(!require(shinythemes)) install.packages("shinythemes", repos = "http://cran.us.r-project.org")
if(!require(shinycssloaders)) install.packages("shinycssloaders", repos = "http://cran.us.r-project.org")
if(!require(magrittr)) install.packages("magrittr", repos = "http://cran.us.r-project.org")
if(!require(rvest)) install.packages("rvest", repos = "http://cran.us.r-project.org")
if(!require(readxl)) install.packages("readxl", repos = "http://cran.us.r-project.org")
if(!require(dplyr)) install.packages("dplyr", repos = "http://cran.us.r-project.org")
if(!require(maps)) install.packages("maps", repos = "http://cran.us.r-project.org")
if(!require(ggplot2)) install.packages("ggplot2", repos = "http://cran.us.r-project.org")
if(!require(reshape2)) install.packages("reshape2", repos = "http://cran.us.r-project.org")
if(!require(ggiraph)) install.packages("ggiraph", repos = "http://cran.us.r-project.org")
if(!require(RColorBrewer)) install.packages("RColorBrewer", repos = "http://cran.us.r-project.org")
if(!require(leaflet)) install.packages("leaflet", repos = "http://cran.us.r-project.org")
if(!require(plotly)) install.packages("plotly", repos = "http://cran.us.r-project.org")
if(!require(geojsonio)) install.packages("geojsonio", repos = "http://cran.us.r-project.org")
library(shinycssloaders)
library(highcharter)
library(tidyr)
library(knitr)
library(tinytex)

#theme_set qui appartient au package 'ggplot2' permet d'avoir des thèmes plus personalisés
theme_set(theme_bw(base_size = 16))

#lire le contenu du fichier excel 'inflation.xls'
inflation <- read_excel("input_data/inflation.xls")
#geojson_read -> Pour récuperer les données spatial du fichier 'geojson 50m'
worldcountry = geojson_read("input_data/50m.geojson", what = "sp")

#Créer un vecteur contient toutes les années du jeu de données
year<-c(1980:2022)
year<-as.character(year)#conversion en type caractère pour l'utiliser plus tard grace à la fonction gather()
inf<-inflation %>% gather(year,key = "Year",value="InflationRate")
inf<-na.omit(inf) #Enlever les données NA de notre nouveau jeu données 'inf'
#Renommer les colonnes du dataset 'inf'
names(inf)<-c("region","year","inflation")
inf$year<-as.integer(inf$year)

#Création d'un vecteur country qui contient tout les pays du dataset 'inf'
country <- c(inf$region)

#Création d'un vecteur unions qui contient les régions économiques du monde
unions<-c("Major advanced economies (G7)","European Union","Emerging and Developing Europe","ASEAN-5","Commonwealth of Independent States",
          "Emerging and Developing Asia","Latin America and the Caribbean",
          "Middle East, North Africa, Afghanistan, and Pakistan")

#Récupération des noms de pays du fichier 50m.geojson correspondant au pays du dataset 'inf'
plot_map <- worldcountry[worldcountry$ADMIN %in% inf$region, ]

#Quelques pré-traitement pour l'affichage d'un graph qui compare des différents taux d'inflations de quelques différentes nations
India<-filter(inf,region=="India")
India$inflation<-as.numeric(India$inflation)
India$year<-as.numeric(India$year)
China<-filter(inf,region=="China, People's Republic of")
Japan<-filter(inf,region=="Japan")
US<-filter(inf,region=="United States")
UK<-filter(inf,region=="United Kingdom")
Fr<-filter(inf,region=="France")
ALG<-filter(inf,region=="Algeria")

