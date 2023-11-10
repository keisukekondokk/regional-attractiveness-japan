# 
# (C) Keisuke Kondo
# Release Date: 2023-11-10
# 
# - global.R
# - ui.R
# - server.R
# 

#==============================================================================
#Global Environment

#Packages
if(!require(shiny)) install.packages("shiny")
if(!require(shinydashboard)) install.packages("shinydashboard")
if(!require(shinycssloaders)) install.packages("shinycssloaders")
if(!require(tmap)) install.packages("tmap")
if(!require(leaflet)) install.packages("leaflet")
if(!require(leaflet.mapboxgl)) install.packages("leaflet.mapboxgl")
if(!require(sf)) install.packages("sf")
if(!require(tidyverse)) install.packages("tidyverse")
if(!require(haven)) install.packages("haven")
if(!require(highcharter)) install.packages("highcharter")

#シェープファイル(市町村単位)
sfMuni <- sf::read_sf("data/shp_polygon/shp_poly_kinki_muni.geojson")
sfMuni <- sfMuni %>%
  dplyr::mutate_at(c("pref_code", "muni_code"), as.numeric)

#シェープファイル(都道府県単位)
sfPref <- sf::read_sf("data/shp_polygon/shp_poly_kinki_pref.geojson")
sfPref <- sfPref %>%
  dplyr::mutate_at("pref_code", as.numeric)

#推定結果（全体）
dfDelta <- haven::read_dta("data/dta/dta_estimation_delta_pref00.dta")

#市区町村リスト
dfMuni <- readr::read_csv("data/csv/muni_list.csv") 
dfMuni <- dfMuni %>%
  dplyr::arrange(muni_code)

#市区町村リスト
listMuni <- as.list(paste(dfMuni$muni_code, dfMuni$pref_name, dfMuni$muni_name))

#TMAP
tmap_mode("view")

## SET MAPBOX API
#Mapbox API--------------------------------------------
#Variables are defined on .Renviron``
styleUrl <- Sys.getenv("MAPBOX_STYLE")
accessToken <- Sys.getenv("MAPBOX_ACCESS_TOKEN")
#Mapbox API--------------------------------------------
