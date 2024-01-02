# 
# (C) Keisuke Kondo
# Release Date: 2023-11-10
# Updated Date: 2024-01-02
# 
# - global.R
# - ui.R
# - server.R
# 

#==============================================================================
#Global Environment
options(warn = -1)

## SET MAPBOX API
#Mapbox API--------------------------------------------
#Variables are defined on .Renviron
styleUrl <- Sys.getenv("MAPBOX_STYLE")
accessToken <- Sys.getenv("MAPBOX_ACCESS_TOKEN")
#Mapbox API--------------------------------------------

#Packages
if(!require(shiny)) install.packages("shiny")
if(!require(shinydashboard)) install.packages("shinydashboard")
if(!require(shinycssloaders)) install.packages("shinycssloaders")
if(!require(shinyWidgets)) install.packages("shinyWidgets")
if(!require(leaflet)) install.packages("leaflet")
if(!require(leaflet.mapboxgl)) install.packages("leaflet.mapboxgl")
if(!require(sf)) install.packages("sf")
if(!require(tidyverse)) install.packages("tidyverse")
if(!require(haven)) install.packages("haven")
if(!require(highcharter)) install.packages("highcharter")

#市区町村リスト
dfMuni <- readr::read_csv("data/csv/muni_list.csv") 
dfMuni <- dfMuni %>%
  dplyr::filter(bigCityFlag!=2) %>%
  dplyr::arrange(cityCode)

#市区町村リスト
listMuni <- as.list(paste(dfMuni$cityCode, dfMuni$prefName, dfMuni$cityName))

#シェープファイル(市町村単位)
sfMuni <- sf::read_sf("data/shp_polygon/shp_poly_pc2015_muni.geojson") 
sfMuni <- sfMuni %>%
  dplyr::mutate(prefCode = floor(cityCode/1000)) %>%
  dplyr::left_join(dfMuni %>% select(prefCode, prefName) %>% distinct(), by = "prefCode") %>%
  dplyr::left_join(dfMuni %>% select(cityCode, cityName), by = "cityCode")
sfMuni <- st_transform(sfMuni, crs = 4326)

#シェープファイル(都道府県単位)
sfPref <- sf::read_sf("data/shp_polygon/shp_poly_pc2015_pref.geojson")
sfPref <- st_transform(sfPref, crs = 4326)

#推定結果（全体）
dfDelta <- haven::read_dta("data/dta/dta_estimation_delta_pref00.dta")

#Leaflet用の凡例
breaks <- c(-12.0, -5.0, -3.0, -2.75, -2.5, -2.25, -2.0, -1.5, -1.0, 0)
breaks_label <- sapply(1:length(breaks), function(x) { paste0(sprintf("%3.2f", breaks[x-1]), " - ", sprintf("%3.2f", breaks[x])) })[-1]
pal <- leaflet::colorBin("Oranges", domain = 1:10, bins = 9)
color_val <- c(pal(1), pal(2), pal(3), pal(4), pal(5), pal(6), pal(7), pal(8), pal(9))
leg_color_val <- c(color_val, "#E5E5E5")
leg_breaks_label <- c(breaks_label, "NA")
df_pal <- data.frame(color_value = leg_color_val, color_label = leg_breaks_label, stringsAsFactors = F)
