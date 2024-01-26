# 
# (C) Keisuke Kondo
# Release Date: 2023-11-10
# Updated Date: 2024-01-02
# 
# - global.R
# - ui.R
# - server.R
# 

server <- function(input, output, session) {
  ####################################
  ## VISUALIZATION
  ## - leaflet: Maps
  ## - Higherchart: Time-Series
  ## 
  ####################################

  #++++++++++++++++++++++++++++++++++++++
  #Maps: map1
  #++++++++++++++++++++++++++++++++++++++
  
  #Leaflet Output
  observeEvent(input$buttonMapUpdate, {
    
    #Popup
    popup_yearmonth = as.character(format(input$listMapDate, format = "%Y-%m"))
    
    #Popup
    if( input$listMapDay == 1 ){
      popup_day = "平日"
    } 
    else if ( input$listMapDay == 2 ){
      popup_day = "休日"
    }
    
    #Popup
    if( input$listMapGender == 0 ){
      popup_gender = "総数"
    } 
    else if ( input$listMapGender == 1 ){
      popup_gender = "男性"
    }
    else if ( input$listMapGender == 2 ){
      popup_gender = "女性"
    }
    
    #Popup
    if( input$listMapAge == 0 ){
      popup_age = "全体"
    } 
    else if ( input$listMapAge == 1 ){
      popup_age = "15-39歳"
    }
    else if ( input$listMapAge == 2 ){
      popup_age = "40-59歳"
    }
    else if ( input$listMapAge == 3 ){
      popup_age = "60歳以上"
    }
    
    #DataFrame Filtered 
    dfDeltaMap <- dfDelta %>%
      dplyr::filter(
        year == lubridate::year(input$listMapDate) &
          month == lubridate::month(input$listMapDate) &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #Shapefiles
    sfPolyLegend <- sfMuni %>%
      dplyr::left_join(dfDeltaMap, by = c( "cityCode" = "code_pref_muni" )) %>%
      dplyr::select(prefCode, prefName, cityCode, cityName, starts_with("b_delta"), pseudo_r2, obs_nonzero) %>%
      dplyr::mutate(share_nonzero = 100 * obs_nonzero / (nrow(dfDeltaMap) - 1) ) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total)) %>%
      dplyr::mutate(b_delta_color_group = cut(b_delta_total, breaks = breaks, labels = breaks_label)) %>%
      dplyr::mutate(b_delta_color_group = as.character(b_delta_color_group)) %>%
      dplyr::left_join(df_pal, by = c("b_delta_color_group" = "color_label"))%>%
      dplyr::rename(b_delta_color_value = color_value) %>%
      dplyr::mutate(b_delta_color_value = if_else(is.na(b_delta_color_value), "#E5E5E5", b_delta_color_value)) 
    
    #Leaflet Object
    output$map1 <- renderLeaflet({
      leaflet() %>%
        #Tile Layer from Mapbox
        addMapboxGL(
          accessToken = accessToken,
          style = styleUrl,
          setView = FALSE
        ) %>%
        addPolygons(
          data = sfPolyLegend,
          fillColor = ~b_delta_color_value, 
          fillOpacity = 0.5,
          stroke = TRUE,
          color = "#F0F0F0", 
          weight = 0.5, 
          popup = paste0(
            "<b>年月: </b>　", popup_yearmonth, "<br>",
            "<b>平日・休日: </b>　", popup_day, "<br>",
            "<b>性別: </b>　", popup_gender, "<br>",
            "<b>年齢層: </b>　", popup_age, "<br>",
            "<b>市区町村コード: </b>　", sfPolyLegend$cityCode, "<br>",
            "<b>市区町村名: </b>　", sfPolyLegend$prefName, sfPolyLegend$cityName, "<br>",
            "<b>地域魅力度指数: </b>　", round(sfPolyLegend$b_delta_total, 3), "<br>",
            "<b>全市区町村数に占める非ゼロフロー割合 (%): </b>　", round(sfPolyLegend$share_nonzero, 3), "<br>"
          ),
          label = paste0(sfPolyLegend$prefName, sfPolyLegend$cityName),
          group = "地域魅力度指数"
        ) %>%
        addPolygons(
          data = sfPref, 
          fill = FALSE, 
          color = "#303030", 
          weight = 1.5, 
          group = "都道府県境界"
        ) %>%
        addLegend(
          colors = df_pal$color_value,
          labels = df_pal$color_label,
          title = "地域魅力度指数"
        ) %>%
        addLayersControl(
          overlayGroups = c("地域魅力度指数", "都道府県境界"),
          position = "topright",
          options = layersControlOptions(collapsed = TRUE)
        )      
    })
  }, ignoreInit = FALSE, ignoreNULL = FALSE, once = TRUE)
  
  #LeafletProxy
  map1_proxy <- leafletProxy("map1", session)
  
  #Switch Leaflet
  observeEvent(input$buttonMapUpdate, {
    
    #Popup
    popup_yearmonth = as.character(format(input$listMapDate, format = "%Y-%m"))
    
    #Popup
    if( input$listMapDay == 1 ){
      popup_day = "平日"
    } 
    else if ( input$listMapDay == 2 ){
      popup_day = "休日"
    }
    
    #Popup
    if( input$listMapGender == 0 ){
      popup_gender = "総数"
    } 
    else if ( input$listMapGender == 1 ){
      popup_gender = "男性"
    }
    else if ( input$listMapGender == 2 ){
      popup_gender = "女性"
    }
    
    #Popup
    if( input$listMapAge == 0 ){
      popup_age = "全体"
    } 
    else if ( input$listMapAge == 1 ){
      popup_age = "15-39歳"
    }
    else if ( input$listMapAge == 2 ){
      popup_age = "40-59歳"
    }
    else if ( input$listMapAge == 3 ){
      popup_age = "60歳以上"
    }
    
    #DataFrame Filtered 
    dfDeltaMap <- dfDelta %>%
      dplyr::filter(
        year == lubridate::year(input$listMapDate) &
          month == lubridate::month(input$listMapDate) &
          day == input$listMapDay &
          gender == input$listMapGender & 
          age_group == input$listMapAge
      )
    
    #Shapefiles
    sfPolyLegend <- sfMuni %>%
      dplyr::left_join(dfDeltaMap, by = c( "cityCode" = "code_pref_muni" )) %>%
      dplyr::select(prefCode, prefName, cityCode, cityName, starts_with("b_delta"), pseudo_r2, obs_nonzero) %>%
      dplyr::mutate(share_nonzero = 100 * obs_nonzero / (nrow(dfDeltaMap) - 1) ) %>%
      dplyr::mutate(b_delta_total = if_else(b_delta_total > 0, NA_real_, b_delta_total)) %>%
      dplyr::mutate(b_delta_color_group = cut(b_delta_total, breaks = breaks, labels = breaks_label)) %>%
      dplyr::mutate(b_delta_color_group = as.character(b_delta_color_group)) %>%
      dplyr::left_join(df_pal, by = c("b_delta_color_group" = "color_label"))%>%
      dplyr::rename(b_delta_color_value = color_value) %>%
      dplyr::mutate(b_delta_color_value = if_else(is.na(b_delta_color_value), "#E5E5E5", b_delta_color_value)) 
    
    #Leaflet Object
    map1_proxy %>%
      clearShapes() %>%
      clearControls() %>%
      addPolygons(
        data = sfPolyLegend,
        fillColor = ~b_delta_color_value, 
        fillOpacity = 0.5,
        stroke = TRUE,
        weight = 0.5,
        color = "#F0F0F0", 
        popup = paste0(
          "<b>年月: </b>　", popup_yearmonth, "<br>",
          "<b>平日・休日: </b>　", popup_day, "<br>",
          "<b>性別: </b>　", popup_gender, "<br>",
          "<b>年齢層: </b>　", popup_age, "<br>",
          "<b>市区町村コード: </b>　", sfPolyLegend$cityCode, "<br>",
          "<b>市区町村名: </b>　", sfPolyLegend$prefName, sfPolyLegend$cityName, "<br>",
          "<b>地域魅力度指数: </b>　", round(sfPolyLegend$b_delta_total, 3), "<br>",
          "<b>全市区町村数に占める非ゼロフロー割合 (%): </b>　", round(sfPolyLegend$share_nonzero, 3), "<br>"
        ),
        label = paste0(sfPolyLegend$prefName, sfPolyLegend$cityName),
        group = "地域魅力度指数"
      ) %>%
      addPolygons(
        data = sfPref, 
        fill = FALSE, 
        color = "#303030", 
        weight = 1.5, 
        group = "都道府県境界"
      ) %>%
      addLegend(
        colors = df_pal$color_value,
        labels = df_pal$color_label,
        title = "地域魅力度指数"
      ) %>%
      addLayersControl(
        overlayGroups = c("地域魅力度指数", "都道府県境界"),
        position = "topright",
        options = layersControlOptions(collapsed = TRUE)
      )
  }, ignoreInit = TRUE, ignoreNULL = FALSE)
  
  
  #++++++++++++++++++++++++++++++++++++++
  #Time-Series: line1
  #++++++++++++++++++++++++++++++++++++++
  observeEvent(input$buttonLineUpdate, {
   
    #Municipality Code
    inputListLineMuni1 <- as.numeric(strsplit(input$listLineMuni1, " ")[[1]][1])
    inputListLineMuni2 <- as.numeric(strsplit(input$listLineMuni2, " ")[[1]][1])
    
    #DataFrame Base Day1
    dfDeltaTemp <- dfDelta %>%
      dplyr::filter(
        code_pref_muni == inputListLineMuni1 &
          day == 1 &
          gender == input$listLineGender & 
          age_group == input$listLineAge
      ) 
    dfDeltaLineDay1Base <- dfDeltaTemp %>%
      dplyr::left_join(dfMuni, by = c("code_pref_muni" = "cityCode")) %>%
      dplyr::mutate(share_nonzero = 100 * obs_nonzero / (nrow(dfDeltaTemp) - 1)) %>%
      dplyr::mutate(time = paste0(year, "-", stringr::str_pad(month, 2, pad = "0"), "-01")) %>%
      dplyr::mutate(ts = as.Date(time, format = "%Y-%m-%d", tz = "Asia/Tokyo"))
    
    #DataFrame Base Day2
    dfDeltaTemp <- dfDelta %>%
      dplyr::filter(
        code_pref_muni == inputListLineMuni1 &
          day == 2 &
          gender == input$listLineGender & 
          age_group == input$listLineAge
      ) 
    dfDeltaLineDay2Base <- dfDeltaTemp %>%
      dplyr::left_join(dfMuni, by = c("code_pref_muni" = "cityCode")) %>%
      dplyr::mutate(share_nonzero = 100 * obs_nonzero / (nrow(dfDeltaTemp) - 1)) %>%
      dplyr::mutate(time = paste0(year, "-", stringr::str_pad(month, 2, pad = "0"), "-01")) %>%
      dplyr::mutate(ts = as.Date(time, format = "%Y-%m-%d"))

    #DataFrame Comparison Day1
    dfDeltaTemp <- dfDelta %>%
      dplyr::filter(
        code_pref_muni == inputListLineMuni2 &
          day == 1 &
          gender == input$listLineGender & 
          age_group == input$listLineAge
      ) 
    dfDeltaLineDay1Comp <- dfDeltaTemp %>%
      dplyr::left_join(dfMuni, by = c("code_pref_muni" = "cityCode")) %>%
      dplyr::mutate(share_nonzero = 100 * obs_nonzero / (nrow(dfDeltaTemp) - 1)) %>%
      dplyr::mutate(time = paste0(year, "-", stringr::str_pad(month, 2, pad = "0"), "-01")) %>%
      dplyr::mutate(ts = as.Date(time, format = "%Y-%m-%d", tz = "Asia/Tokyo"))
    
    #DataFrame Comparison Day2
    dfDeltaTemp <- dfDelta %>%
      dplyr::filter(
        code_pref_muni == inputListLineMuni2 &
          day == 2 &
          gender == input$listLineGender & 
          age_group == input$listLineAge
      ) 
    dfDeltaLineDay2Comp <-dfDeltaTemp %>%
      dplyr::left_join(dfMuni, by = c("code_pref_muni" = "cityCode")) %>%
      dplyr::mutate(share_nonzero = 100 * obs_nonzero / (nrow(dfDeltaTemp) - 1)) %>%
      dplyr::mutate(time = paste0(year, "-", stringr::str_pad(month, 2, pad = "0"), "-01")) %>%
      dplyr::mutate(ts = as.Date(time, format = "%Y-%m-%d"))
      
    #Highcharts: Value
    output$line1 <- renderHighchart({
    
      hc1 <- highchart() %>%
        hc_add_series(
          data = dfDeltaLineDay1Base,
          hcaes(x = ts, y = b_delta_total),
          type = "line",
          color = "#2F7ED8",
          lineWidth = 2,
          name = paste0(dfDeltaLineDay1Base$cityName[1], "（平日）"),
          showInLegend = TRUE
        ) %>%
        hc_add_series(
          data = dfDeltaLineDay2Base,
          hcaes(x = ts, y = b_delta_total),
          type = "line",
          color = "#CD5C5C",
          lineWidth = 2,
          name = paste0(dfDeltaLineDay2Base$cityName[1], "（休日）"),
          showInLegend = TRUE
        ) %>%
        hc_add_series(
          data = dfDeltaLineDay1Comp,
          hcaes(x = ts, y = b_delta_total),
          type = "line",
          color = "#2F7ED8",
          lineWidth = 2,
          name = paste0(dfDeltaLineDay1Comp$cityName[1], "（平日）"),
          showInLegend = TRUE,
          dashStyle = "longdash"
        ) %>%
        hc_add_series(
          data = dfDeltaLineDay2Comp,
          hcaes(x = ts, y = b_delta_total),
          type = "line",
          color = "#CD5C5C",
          lineWidth = 2,
          name = paste0(dfDeltaLineDay2Comp$cityName[1], "（休日）"),
          showInLegend = TRUE,
          dashStyle = "longdash"
        ) %>%
        hc_yAxis(
          title = list(text = "地域魅力度指数"),
          allowDecimals = TRUE
        ) %>%
        hc_xAxis(
          type = "datetime", 
          showLastLabel = TRUE,
          dateTimeLabelFormats = list(day = "%d", month = "%b-%Y")
        ) %>%
        hc_tooltip(valueDecimals = 4,
                   pointFormat = "市区町村名: {point.series.name} <br> 地域魅力度指数: {point.y}") %>%
        hc_add_theme(hc_theme_flat()) %>%
        hc_credits(enabled = TRUE)
      
      #plot
      hc1
      
    })
    
  }, ignoreNULL = FALSE)
  
  
  
  #++++++++++++++++++++++++++++++++++++++
  #Ranking: Table1
  #++++++++++++++++++++++++++++++++++++++
  
  observeEvent(input$buttonTableUpdate, {

    #DataFrame: Filter by
    dfDeltaTable <- dfDelta %>%
      dplyr::filter(
        year == lubridate::year(input$listTableDate) &
        month == lubridate::month(input$listTableDate) &
        day == input$listTableDay &
        gender == input$listTableGender & 
        age_group == input$listTableAge
      )
  
    #DataTable
    dfDeltaTable <- dfDeltaTable %>%
      dplyr::left_join(dfMuni %>% select(prefCode, prefName) %>% distinct(), by = c("code_pref" = "prefCode")) %>%
      dplyr::left_join(dfMuni %>% select(cityCode, cityName), by = c("code_pref_muni" = "cityCode")) %>%
      dplyr::mutate(share_nonzero = obs_nonzero / (nrow(dfDeltaTable) - 1)) %>%
      dplyr::select(code_pref_muni, prefName, cityName, starts_with("b_delta_total") , share_nonzero) %>%
      dplyr::arrange(desc(b_delta_total), desc(share_nonzero)) %>%
      dplyr::rename(`市区町村コード` = code_pref_muni) %>%
      dplyr::rename(`都道府県名` = prefName) %>%
      dplyr::rename(`市区町村名` = cityName) %>%
      dplyr::rename(`地域魅力度指数` = b_delta_total) %>%
      dplyr::rename(`非ゼロフロー割合` = share_nonzero)    

    #DataTable
    output$tableDeltaTop <- renderDataTable({
      DT::datatable(dfDeltaTable) %>%
        DT::formatRound(columns = c(4:5), digits = 3) %>%
        DT::formatPercentage(columns = 5, digits = 3)
    }, 
      options = list(
        autoWidth = TRUE, 
        scrollX = TRUE
      )
    )
 
  }, ignoreNULL = FALSE)
  
}
