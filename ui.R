# 
# (C) Keisuke Kondo
# Release Date: 2023-11-10
# 
# - global.R
# - ui.R
# - server.R
# 

dashboardPage(
  skin = "blue",
  #++++++++++++++++++++++++++++++++++++++
  #Header
  dashboardHeader(
    title = "Regional Attractiveness Index",
    titleWidth = 400,
    tags$li(
      actionLink(
        "github",
        label = "",
        icon = icon("github"),
        href = "https://github.com/keisukekondokk/regional-attractiveness-japan",
        onclick = "window.open('https://github.com/keisukekondokk/regional-attractiveness-japan', '_blank')"
      ),
      class = "dropdown"
    )
  ),
  #++++++++++++++++++++++++++++++++++++++
  #SideBar
  dashboardSidebar(width = 200,
                   sidebarMenu(
                     menuItem(
                       "Maps",
                       tabName = "tab_map1",
                       icon = icon("map")),
                     menuItem(
                       "Time-Series",
                       tabName = "tab_line1",
                       icon = icon("chart-line")),
                     menuItem("Readme",
                              tabName = "info",
                              icon = icon("info-circle"))
                   )),
  #++++++++++++++++++++++++++++++++++++++
  #Body
  dashboardBody(
    tags$style(type = "text/css", "html, body {margin: 0; width: 100%; height: 100%}"),
    tags$style(type = "text/css", "h2 {margin-top: 10px}"),
    tags$style(type = "text/css", "h3, h4 {margin-top: 5px}"),
    tags$style(
      type = "text/css",
      "#map1 {margin: 0; height: calc(100vh - 50px) !important;}"
    ),
    tags$style(
      type = "text/css",
      "#panel_map {padding: 5px; background-color: #FFFFFF; opacity: 0.7;}
        #panel_map:hover {opacity: 1;}"
    ),
    tags$style(
      type = "text/css",
      "body {overflow-y: scroll;}"
    ),
    #++++++++++++++++++++++++++++++++++++++
    #Tab
    tabItems(
      #++++++++++++++++++++++++++++++++++++++
      tabItem(
        tabName = "tab_map1",
        fluidRow(
          style = "margin-top: -20px; margin-bottom: -20px;",
          absolutePanel(
            id = "panel_map",
            class = "panel panel-default",
            top = "15vh",
            bottom = "auto",
            left = "auto",
            right = "auto",
            width = 200,
            height = "auto",
            draggable = TRUE,
            style = "z-index:10;",
            radioButtons(
              "listMapDay",
              label = h4(span(icon("calendar"), "Select Day Type:")),
              choices = list(
                "Weekday" = 1,
                "Weekend/Holiday" = 2
              ),
              selected = 1,
              width = "100%"
            ),
            #
            radioButtons(
              "listMapGender",
              label = h4(span(
                icon("user"), "Select Gender Type:"
              )),
              choices = list(
                "Total" = 0,
                "Male" = 1,
                "Female" = 2
              ),
              selected = 0,
              width = "100%"
            ),
            # Slider bar for Infectious State
            radioButtons(
              "listMapAge",
              label = h4(span(icon("users"), "Select Age Gruop:")),
              choices = list(
                "Total" = 0,
                "15-39" = 1,
                "40-59" = 2,
                "60 and over" = 3
              ),
              selected = 0,
              width = "100%"
            ),
            div(
              actionButton(
                inputId = "buttonMapUpdate", 
                label = span(icon("play-circle"), "Update"), 
                width = "100%",
                class = "btn btn-primary"
              )
            )
          ),
          leafletOutput("map1") %>%
            withSpinner(color = getOption("spinner.color", default = "#3C8EBC"))
        )
      ),
      #++++++++++++++++++++++++++++++++++++++
      tabItem(
        tabName = "tab_line1",
        fluidRow(
          style = "margin-top: -20px; margin-bottom: -10px;",
          column(
            width = 12,
              div(style = "margin-top: 10px")
          ),
          column(
            width = 6,
            selectInput(
              "listLineMuni1",
              width = "100%",
              label = h4(span(icon("chart-line"), "Select Municipality for Baseline (Solid Line)")),
              choices = listMuni,
              selected = "28110 兵庫県 神戸市中央区"
            )
          ),
          column(
            width = 6,
            selectInput(
              "listLineMuni2",
              width = "100%",
              label = h4(span(icon("chart-line"), "Select Municipality for Comparison (Dashed Line)")),
              choices = listMuni,
              selected = "27104 大阪府 大阪市此花区"
            )
          ),
          column(
            width = 6,
            radioButtons(
              "listLineGender",
              width = "100%",
              label = h4(span(icon("chart-line"), "Select Gender Type:")),
              choices = list(
                "Total" = 0,
                "Male" = 1,
                "Female" = 2
              ),
              selected = 0,
              inline = TRUE
            )
          ),
          column(
            width = 6,
            radioButtons(
              "listLineAge",
              width = "100%",
              label = h4(span(icon("chart-line"), "Select Age Group:")),
              choices = list(
                "Total" = 0,
                "15-39" = 1,
                "40-59" = 2,
                "60 and over" = 3
              ),
              selected = 0,
              inline = TRUE
            )
          ),
          column(
            width = 12,
            style = "margin-bottom: 20px; color: white;",
            actionButton(
              "buttonLineUpdate", 
              span(icon("play-circle"), "Update"), 
              class = "btn btn-primary",
              width = "100%"
            )
          ),
          box(
            title = "Regional Attractiveness Index",
            width = 12,
            highchartOutput("line1", height = "520px") %>%
              withSpinner(color = getOption("spinner.color", default = "#3C8EBC"))
          )
        )
      ),
      #++++++++++++++++++++++++++++++++++++++
      tabItem(
        tabName = "info",
        fluidRow(
          style = "margin-bottom: -20px; margin-left: -30px; margin-right: -30px;",
          column(
            width = 12,
            box(
              width = NULL,
              title = h2(span(icon("info-circle"), "Readme")),
              solidHeader = TRUE,
              p("Release Date: November 10, 2023", align = "right"),
              #------------------------------------------------------------------
              h3(style = "border-bottom: solid 1px black;", span(icon("fas fa-pen-square"), "Introduction")),
              p("This web app visualizes the regional attractiveness index, estimated from mobility data. The concept is proposed in Kondo (2023)."),
              #------------------------------------------------------------------
              h3(style = "border-bottom: solid 1px black;", span(icon("user-circle"), "Author")),
              p("Keisuke Kondo"),
              p("Senior Fellow, Research Institute of Economy, Trade and Industry (RIETI)"),
              p("Associate Professor, Research Institute for Economics and Business Administration (RIEB), Kobe University"),
              h3(style = "border-bottom: solid 1px black;", span(icon("envelope-open"), "Contact")),
              p("Email: kondo-keisuke@rieti.go.jp"),
              h3(style = "border-bottom: solid 1px black;", span(icon("fas fa-file-alt"), "Terms of Use")),
              p(
                "Users (hereinafter referred to as the User or Users depending on context) of the content on this web site (hereinafter referred to as the Content) are required to conform to the terms of use described herein (hereinafter referred to as the Terms of Use). Furthermore, use of the Content constitutes agreement by the User with the Terms of Use. The content of the Terms of Use is subject to change without prior notice."
              ),
              h4("Copyright"),
              p("The copyright of the developed code belongs to Keisuke Kondo."),
              h4("Copyright of Third Parties"),
              p(
                "Keisuke Kondo developed the Content based on the information on From-To Analysis on the Regional Economy and Society Analyzing System (RESAS), which is freely available using the RESAS API. The original data of From-To Analysis is based on Mobile Spatial Statistics® of NTT DOCOMO. The shapefiles were taken from the Portal Site of Official Statistics of Japan, e-Stat. Users must confirm the terms of use of the RESAS and the e-Stat, prior to using the Content."
              ),
              h4("Licence"),
              p("The developed code is released under the MIT License."),
              h4("Disclaimer"),
              p("(a) Keisuke Kondo makes the utmost effort to maintain, but nevertheless does not guarantee, the accuracy, completeness, integrity, usability, and recency of the Content."),
              p("(b) Keisuke Kondo and any organization to which Keisuke Kondo belongs hereby disclaim responsibility and liability for any loss or damage that may be incurred by Users as a result of using the Content. Keisuke Kondo and any organization to which Keisuke Kondo belongs are neither responsible nor liable for any loss or damage that a User of the Content may cause to any third party as a result of using the Content"),
              p("(c) The Content may be modified, moved or deleted without prior notice."),
              #------------------------------------------------------------------
              h3(style = "border-bottom: solid 1px black;", span(icon("database"), "Data Sources")),
              h4("From-To Analysis: RESAS API"),
              p(
                "URL: ",
                a(
                  href = "https://opendata.resas-portal.go.jp/docs/api/v1/partner/docomo/destination.html",
                  "https://opendata.resas-portal.go.jp/docs/api/v1/partner/docomo/destination.html",
                  .noWS = "outside"
                ),
                .noWS = c("after-begin", "before-end")
              ), 
              h4("Shapefile of Japanese Prefectures: e-Stat, Portal Site of Official Statistics of Japan"),
              p(
                "URL: ",
                a(
                  href = "https://www.e-stat.go.jp/",
                  "https://www.e-stat.go.jp/",
                  .noWS = "outside"
                ),
                .noWS = c("after-begin", "before-end")
              ),
              #------------------------------------------------------------------
              h3(style = "border-bottom: solid 1px black;", span(icon("book"), "Reference")),
              p(
                "Kondo, Keisuke (2023) Measuring the Attractiveness of Trip Destinations: A Study of the Kansai Region, RIEB Discussion Paper Series No.2023-07"
              ),
              p(
                "URL: ",
                a(
                  href = "https://www.rieb.kobe-u.ac.jp/academic/ra/dp/English/dp2023-07.html",
                  "https://www.rieb.kobe-u.ac.jp/academic/ra/dp/English/dp2023-07.html",
                  .noWS = "outside"
                ),
                .noWS = c("after-begin", "before-end")
              )
            )
          )
        )
      )
    )
  )
)
