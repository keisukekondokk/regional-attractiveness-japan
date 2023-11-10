# 
# (C) Keisuke Kondo
# Release Date: 2023-11-10
# 
# - global.R
# - ui.R
# - server.R
# 

server <- function(input, output) {
  ####################################
  ## VISUALIZATION
  ## - leaflet: Maps
  ## - Higherchart: Time-Series
  ## 
  ####################################

  #++++++++++++++++++++++++++++++++++++++
  #Maps: map1
  observeEvent(input$buttonMapUpdate, {
  
    #推定結果（地図）
    dfDeltaMap201509 <- dfDelta %>%
      dplyr::filter(
        year == 2015 &
        month == 9 &
        day == input$listMapDay &
        gender == input$listMapGender & 
        age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201510 <- dfDelta %>%
      dplyr::filter(
        year == 2015 &
          month == 10 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201511 <- dfDelta %>%
      dplyr::filter(
        year == 2015 &
          month == 11 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201512 <- dfDelta %>%
      dplyr::filter(
        year == 2015 &
          month == 12 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201601 <- dfDelta %>%
      dplyr::filter(
        year == 2016 &
          month == 1 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201602 <- dfDelta %>%
      dplyr::filter(
        year == 2016 &
          month == 2 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201603 <- dfDelta %>%
      dplyr::filter(
        year == 2016 &
          month == 3 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201604 <- dfDelta %>%
      dplyr::filter(
        year == 2016 &
          month == 4 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201605 <- dfDelta %>%
      dplyr::filter(
        year == 2016 &
          month == 5 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201606 <- dfDelta %>%
      dplyr::filter(
        year == 2016 &
          month == 6 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201607 <- dfDelta %>%
      dplyr::filter(
        year == 2016 &
          month == 7 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #推定結果（地図）
    dfDeltaMap201608 <- dfDelta %>%
      dplyr::filter(
        year == 2016 &
          month == 8 &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #地図ファイルを作成
    sfPoly201509 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201509, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201510 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201510, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201511 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201511, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201512 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201512, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201601 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201601, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name,  starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201602 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201602, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201603 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201603, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201604 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201604, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201605 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201605, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201606 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201606, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201607 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201607, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #地図ファイルを作成
    sfPoly201608 <- sfMuni %>%
      dplyr::left_join(dfDeltaMap201608, by = c( "muni_code" = "code_pref_muni" )) %>%
      dplyr::select(pref_code, pref_name, muni_code, muni_name, starts_with("b_delta")) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total))
    
    #
    output$map1 <- renderLeaflet({
      #TMAP
      tp <-
        tm_shape(sfPoly201509) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          group = "Sep. 2015"
        ) +
        tm_shape(sfPoly201510) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Oct. 2015"
        ) +
        tm_shape(sfPoly201511) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Nov. 2015"
        ) +
        tm_shape(sfPoly201512) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Dec. 2015"
        ) +
        tm_shape(sfPoly201601) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Jan. 2016"
        ) +
        tm_shape(sfPoly201602) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Feb. 2016"
        ) +
        tm_shape(sfPoly201603) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Mar. 2016"
        ) +
        tm_shape(sfPoly201604) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Apr. 2016"
        ) +
        tm_shape(sfPoly201605) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "May. 2016"
        ) +
        tm_shape(sfPoly201606) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Jun. 2016"
        ) +
        #=====
        tm_shape(sfPoly201607) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Jul. 2016"
        ) +
        #=====
        tm_shape(sfPoly201608) +
        tm_basemap(NULL) +
        tm_fill(
          col = "b_delta_total",
          alpha = 0.6,
          palette = "-Oranges",
          n = 9,
          style = "fixed",
          breaks = c(-4.5, -3.5, -2.5, -2.0, -1.75, -1.5, -1.25, -1.0, -0.75, -0.50),
          id = "muni_name",
          popup.vars = c(
            "Prefecture Code: " = "pref_code",
            "Prefecture Name: " = "pref_name",
            "Municipality Code: " = "muni_code",
            "Municipality Name: " = "muni_name",
            "Regional Attractivness Index: " = "b_delta_total"
          ),
          popup.format = list(
            muni_code = list(big.mark = ""),
            muni_name = list(big.mark = ""),
            b_delta_total = list(digits = 4)
          ),
          title = paste("Regional Attractiveness Index", sep = "<br>"),
          legend.show = FALSE,
          group = "Aug. 2016"
        ) +
        tm_borders(lwd = 0.25) +
        tm_shape(sfMuni) +
        tm_basemap(NULL) +
        tm_borders(lwd = 1.0) +
        tm_shape(sfPref) +
        tm_basemap(NULL) +
        tm_borders(lwd = 2.0)
      
      #Leaflet from tmap
      lf <- tmap_leaflet(tp, in.shiny = TRUE)
      lf %>%
        #Tile Layer from Mapbox
        addLayersControl(
          baseGroups = c(
            "Sep. 2015", 
            "Oct. 2015",
            "Nov. 2015",
            "Dec. 2015",
            "Jan. 2016",
            "Feb. 2016",
            "Mar. 2016",
            "Apr. 2016",
            "May. 2016",
            "Jun. 2016",
            "Jul. 2016",
            "Aug. 2016"
          ),
          options = layersControlOptions(collapsed = FALSE)
        ) %>%
        #Tile Layer from Mapbox
        addMapboxGL(accessToken = accessToken,
                    style = styleUrl,
                    setView = FALSE)
      
    })
  }, ignoreNULL = FALSE)
  
  
  #++++++++++++++++++++++++++++++++++++++
  #Time-Series: line1, line2
  observeEvent(input$buttonLineUpdate, {
   
    #Municipality Code
    inputListLineMuni1 <- as.numeric(strsplit(input$listLineMuni1, " ")[[1]][1])
    inputListLineMuni2 <- as.numeric(strsplit(input$listLineMuni2, " ")[[1]][1])
    
    #DataFrame Base1
    dfDeltaLineDay1Base <- dfDelta %>%
      dplyr::filter(
        code_pref_muni == inputListLineMuni1 &
          day == 1 &
          gender == input$listLineGender & 
          age_group == input$listLineAge
      ) %>%
      dplyr::left_join(dfMuni, by = c("code_pref_muni" = "muni_code")) %>%
      dplyr::mutate(time = paste0(year, "-", stringr::str_pad(month, 2, pad = "0"), "-01")) %>%
      dplyr::mutate(ts = as.Date(time, format = "%Y-%m-%d", tz = "Asia/Tokyo"))
    
    #DataFrame Base1
    dfDeltaLineDay2Base <- dfDelta %>%
      dplyr::filter(
        code_pref_muni == inputListLineMuni1 &
          day == 2 &
          gender == input$listLineGender & 
          age_group == input$listLineAge
      ) %>%
      dplyr::left_join(dfMuni, by = c("code_pref_muni" = "muni_code")) %>%
      dplyr::mutate(time = paste0(year, "-", stringr::str_pad(month, 2, pad = "0"), "-01")) %>%
      dplyr::mutate(ts = as.Date(time, format = "%Y-%m-%d"))
    
    #DataFrame Base Day1/2
    dfDeltaLineDayBaseRatio <- dfDeltaLineDay1Base %>%
      dplyr::left_join(dfDeltaLineDay2Base, by = "ts") %>%
      dplyr::mutate(ratio_b_delta_total = b_delta_total.y / b_delta_total.x)

    #DataFrame Comparison
    dfDeltaLineDay1Comp <- dfDelta %>%
      dplyr::filter(
        code_pref_muni == inputListLineMuni2 &
          day == 1 &
          gender == input$listLineGender & 
          age_group == input$listLineAge
      ) %>%
      dplyr::left_join(dfMuni, by = c("code_pref_muni" = "muni_code")) %>%
      dplyr::mutate(time = paste0(year, "-", stringr::str_pad(month, 2, pad = "0"), "-01")) %>%
      dplyr::mutate(ts = as.Date(time, format = "%Y-%m-%d", tz = "Asia/Tokyo"))
    
    #DataFrame Comparison
    dfDeltaLineDay2Comp <- dfDelta %>%
      dplyr::filter(
        code_pref_muni == inputListLineMuni2 &
          day == 2 &
          gender == input$listLineGender & 
          age_group == input$listLineAge
      ) %>%
      dplyr::left_join(dfMuni, by = c("code_pref_muni" = "muni_code")) %>%
      dplyr::mutate(time = paste0(year, "-", stringr::str_pad(month, 2, pad = "0"), "-01")) %>%
      dplyr::mutate(ts = as.Date(time, format = "%Y-%m-%d"))
    
    #DataFrame Comparison Day1/2
    dfDeltaLineDayCompRatio <- dfDeltaLineDay1Comp %>%
      dplyr::left_join(dfDeltaLineDay2Comp, by = "ts") %>%
      dplyr::mutate(ratio_b_delta_total = b_delta_total.y / b_delta_total.x)

    #Highcharts: Value
    output$line1 <- renderHighchart({
    
      hc1 <- highchart() %>%
        hc_add_series(
          data = dfDeltaLineDay1Base,
          hcaes(x = ts, y = b_delta_total),
          type = "line",
          color = "#2F7ED8",
          lineWidth = 2,
          name = paste0(dfDeltaLineDayBaseRatio$muni_name.x[1], " (Weekday)"),
          showInLegend = TRUE,
          dashStyle = "longdash"
        ) %>%
        hc_add_series(
          data = dfDeltaLineDay2Base,
          hcaes(x = ts, y = b_delta_total),
          type = "line",
          color = "#CD5C5C",
          lineWidth = 2,
          name = paste0(dfDeltaLineDayBaseRatio$muni_name.x[1], " (Holiday)"),
          showInLegend = TRUE,
          dashStyle = "longdash"
        ) %>%
        hc_add_series(
          data = dfDeltaLineDay1Comp,
          hcaes(x = ts, y = b_delta_total),
          type = "line",
          color = "#2F7ED8",
          lineWidth = 2,
          name = paste0(dfDeltaLineDayCompRatio$muni_name.x[1], " (Weekday)"),
          showInLegend = TRUE
        ) %>%
        hc_add_series(
          data = dfDeltaLineDay2Comp,
          hcaes(x = ts, y = b_delta_total),
          type = "line",
          color = "#CD5C5C",
          lineWidth = 2,
          name = paste0(dfDeltaLineDayCompRatio$muni_name.x[1], " (Holiday)"),
          showInLegend = TRUE
        ) %>%
        hc_yAxis(
          title = list(text = "Regional Attractiveness Index"),
          allowDecimals = TRUE
        ) %>%
        hc_xAxis(
          type = "datetime", 
          showLastLabel = TRUE,
          dateTimeLabelFormats = list(day = "%d", month = "%b-%Y")
        ) %>%
        hc_tooltip(valueDecimals = 4,
                   pointFormat = "Municipality: {point.series.name} <br> Delta: {point.y}") %>%
        hc_add_theme(hc_theme_flat()) %>%
        hc_credits(enabled = TRUE)
      
      #plot
      hc1
      
    })
    
    #Highcharts: Ratio
    output$line2 <- renderHighchart({
      
      hc2 <- highchart() %>%
        hc_add_series(
          data = dfDeltaLineDayBaseRatio,
          hcaes(x = ts, y = ratio_b_delta_total),
          type = "line",
          color = "#25B086",
          lineWidth = 2,
          name = paste0(dfDeltaLineDayBaseRatio$muni_name.x[1]),
          showInLegend = TRUE,
          dashStyle = "longdash",
          zindex = 1,
        ) %>%
        hc_add_series(
          data = dfDeltaLineDayCompRatio,
          hcaes(x = ts, y = ratio_b_delta_total),
          type = "line",
          color = "#25B086",
          lineWidth = 2,
          name = paste0(dfDeltaLineDayCompRatio$muni_name.x[1]),
          showInLegend = TRUE,
          zindex = 1,
        ) %>%
        hc_yAxis(
          title = list(text = "Weekday-Holiday Ratio of Regional Attractiveness Index"),
          allowDecimals = TRUE,
          plotLines = list(list(
            value = 1,
            color = '#ff0000',
            width = 2,
            zIndex = -10
          ))
        ) %>%
        hc_xAxis(
          type = "datetime", 
          showLastLabel = TRUE,
          dateTimeLabelFormats = list(day = "%d", month = "%b-%Y")
        ) %>%
        hc_tooltip(valueDecimals = 4,
                   pointFormat = "Municipality: {point.series.name} <br> Delta: {point.y}") %>%
        hc_add_theme(hc_theme_flat()) %>%
        hc_credits(enabled = TRUE)
      
      #plot
      hc2
      
    })
    
  }, ignoreNULL = FALSE)
  
}
