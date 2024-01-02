# 
# (C) Keisuke Kondo
# Release Date: 2023-11-10
# Updated Date: 2024-01-02
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
    title = "地域魅力度指数可視化システム",
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
      "#panel_map {padding: 5px; background-color: #FFFFFF; opacity: 0.8;}
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
            airDatepickerInput(
              "listMapDate",
              label = h4(span(icon("calendar"), "年月の選択：")),
              value = "2016-08-01",
              min = "2015-09-01",
              max = "2016-08-01",
              view = "months",
              minView = "months",
              dateFormat = "yyyy-MM",
              autoClose = TRUE,
              language = "ja"
            ),
            radioButtons(
              "listMapDay",
              label = h4(span(icon("business-time"), "平日・休日の選択")),
              choices = list(
                "平日" = 1,
                "休日" = 2
              ),
              selected = 1,
              width = "100%"
            ),
            #
            radioButtons(
              "listMapGender",
              label = h4(span(
                icon("user"), "性別の選択："
              )),
              choices = list(
                "全体" = 0,
                "男性" = 1,
                "女性" = 2
              ),
              selected = 0,
              width = "100%"
            ),
            # Slider bar for Infectious State
            radioButtons(
              "listMapAge",
              label = h4(span(icon("users"), "年齢層の選択：")),
              choices = list(
                "全体" = 0,
                "15-39歳" = 1,
                "40-59歳" = 2,
                "60歳以上" = 3
              ),
              selected = 0,
              width = "100%"
            ),
            div(
              actionButton(
                inputId = "buttonMapUpdate", 
                label = span(icon("play-circle"), "更新"), 
                width = "100%",
                class = "btn btn-primary"
              ),
              p("※更新が反映されるまで少し時間がかかります。")
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
            selectizeInput (
              "listLineMuni1",
              width = "100%",
              label = h4(span(icon("chart-line"), "市区町村１の選択（実線）")),
              choices = listMuni,
              selected = "47201 沖縄県 那覇市",
              options= list(maxOptions = 2000)
            )
          ),
          column(
            width = 6,
            selectizeInput(
              "listLineMuni2",
              width = "100%",
              label = h4(span(icon("chart-line"), "市区町村２の選択（破線）")),
              choices = listMuni,
              selected = "13101 東京都 千代田区",
              options= list(maxOptions = 2000)
            )   
          ),
          column(
            width = 6,
            radioButtons(
              "listLineGender",
              width = "100%",
              label = h4(span(icon("chart-line"), "性別の選択：")),
              choices = list(
                "全体" = 0,
                "男性" = 1,
                "女性" = 2
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
              label = h4(span(icon("chart-line"), "年齢層の選択：")),
              choices = list(
                "全体" = 0,
                "15-39歳" = 1,
                "40-59歳" = 2,
                "60歳以上" = 3
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
              span(icon("play-circle"), "更新"), 
              class = "btn btn-primary",
              width = "100%"
            )
          ),
          box(
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
              h3(style = "border-bottom: solid 1px black;", span(icon("fas fa-pen-square"), "はじめに")),
              p("Kondo (2023)において提案した人流データから推定する地域魅力度指数を可視化しています。"),
              #------------------------------------------------------------------
              h3(style = "border-bottom: solid 1px black;", span(icon("user-circle"), "作成者")),
              p("近藤恵介"),
              p("独立行政法人経済産業研究所・上席研究員"),
              p("神戸大学経済経営研究所・准教授"),
              #------------------------------------------------------------------
              h3(style = "border-bottom: solid 1px black;", span(icon("envelope-open"), "連絡先")),
              p("Email: kondo-keisuke@rieti.go.jp"),
              #------------------------------------------------------------------
              h3(style = "border-bottom: solid 1px black;", span(icon("fas fa-file-alt"), "利用規約")),
              p(
                "当サイトで公開している情報（以下「コンテンツ」）は、どなたでも自由に利用できます。コンテンツ利用に当たっては、本利用規約に同意したものとみなします。本利用規約の内容は、必要に応じて事前の予告なしに変更されることがありますので、必ず最新の利用規約の内容をご確認ください。"
              ),
              h4("著作権"),
              p("本コンテンツの著作権は、近藤恵介に帰属します。"),
              h4("第三者の権利"),
              p(
                "本コンテンツは、「From-To分析（滞在人口）」（RESAS）および「統計地理情報システム」（e-Stat）の情報に基づいて作成しています。「From-To分析（滞在人口）」は「モバイル空間統計®」（NTTドコモ）に基づいたデータであり、RESAS APIを利用して2015年9月から2016年8月までの期間をダウンロードして使用しています。本コンテンツを利用する際は、第三者の権利を侵害しないようにしてください。"
              ),
              h4("免責事項"),
              p("(a) 作成にあたり細心の注意を払っていますが、本サイトの内容の完全性・正確性・有用性等についていかなる保証を行うものでありません。"),
              p("(b) 本サイトを利用したことによるすべての障害・損害・不具合等、作成者および作成者の所属するいかなる団体・組織とも、一切の責任を負いません。"),
              p("(c) 本サイトは、事前の予告なく変更、移転、削除等が行われることがあります。"),
              #------------------------------------------------------------------
              h3(style = "border-bottom: solid 1px black;", span(icon("database"), "データ出所")),
              h4("From-to分析（滞在人口）：RESAS API"),
              p(
                "URL: ",
                a(
                  href = "https://opendata.resas-portal.go.jp/docs/api/v1/partner/docomo/destination.html",
                  "https://opendata.resas-portal.go.jp/docs/api/v1/partner/docomo/destination.html",
                  .noWS = "outside"
                ),
                .noWS = c("after-begin", "before-end")
              ), 
              h4("都道府県・市区町村シェープファイル：統計地理情報システム（e-Stat）"),
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
              h3(style = "border-bottom: solid 1px black;", span(icon("book"), "参考文献")),
              p(
                "Kondo, Keisuke (2023) Measuring the Attractiveness of Trip Destinations: A Study of the Kansai Region of Japan, RIEB Discussion Paper Series No.2023-07"
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
