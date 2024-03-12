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
    titleWidth = 350,
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
                       "地図による可視化",
                       tabName = "tab_map1",
                       icon = icon("map")),
                     menuItem(
                       "時系列による可視化",
                       tabName = "tab_line1",
                       icon = icon("chart-line")),
                     menuItem(
                       "表による可視化",
                       tabName = "tab_table1",
                       icon = icon("table")),
                     menuItem("解説",
                              tabName = "exp",
                              icon = icon("book-open")),
                     menuItem("はじめに",
                              tabName = "info",
                              icon = icon("info-circle"))
                   )),
  #++++++++++++++++++++++++++++++++++++++
  #Body
  dashboardBody(
    tags$head(tags$link(rel = "shortcut icon", href = "favicon.ico")),
    tags$style(type = "text/css", "html, body {margin: 0; width: 100%; height: 100%;}"),
    tags$style(type = "text/css", "h2 {font-weight: bold; margin-top: 20px;}"),
    tags$style(type = "text/css", "h3 {font-weight: bold; margin-top: 15px;}"),
    tags$style(type = "text/css", "h4, h5 {font-weight: bold; text-decoration: underline; margin-top: 10px;}"),
    tags$style(
      type = "text/css",
      "#map1 {margin: 0; height: calc(100vh - 50px) !important;}"
    ),
    tags$style(
      type = "text/css",
      "#panel_map {padding: 5px; background-color: #FFFFFF; opacity: 1;}
        #panel_map:hover {opacity: 1;}"
    ),
    tags$style(
      type = "text/css",
      "#buttonMapUpdate, #buttonLineUpdate, #buttonTableUpdate {color: #FFFFFF;}"
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
            width = 150,
            height = "auto",
            draggable = TRUE,
            style = "z-index:10;",
            #選択
            airDatepickerInput(
              "listMapDate",
              label = p(span(icon("calendar"), "年月の選択：")),
              value = "2016-08-01",
              min = "2015-09-01",
              max = "2016-08-01",
              view = "months",
              minView = "months",
              dateFormat = "yyyy-MM",
              autoClose = TRUE,
              language = "ja"
            ),
            #選択
            radioButtons(
              "listMapDay",
              label = p(span(icon("business-time"), "平日・休日の選択")),
              choices = list(
                "平日" = 1,
                "休日" = 2
              ),
              selected = 1,
              width = "100%"
            ),
            #選択
            radioButtons(
              "listMapGender",
              label = p(span(
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
            #選択
            radioButtons(
              "listMapAge",
              label = p(span(icon("users"), "年齢層の選択：")),
              choices = list(
                "全体" = 0,
                "15-39歳" = 1,
                "40-59歳" = 2,
                "60歳以上" = 3
              ),
              selected = 0,
              width = "100%"
            ),
            #更新ボタン
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
          #選択
          column(
            width = 3,
            selectizeInput (
              "listLineMuni1",
              width = "100%",
              label = h4(span(icon("chart-line"), "市区町村１の選択（実線）")),
              choices = listMuni,
              selected = "47201 沖縄県 那覇市",
              options= list(maxOptions = 2000)
            )
          ),
          #選択
          column(
            width = 3,
            selectizeInput(
              "listLineMuni2",
              width = "100%",
              label = h4(span(icon("chart-line"), "市区町村２の選択（破線）")),
              choices = listMuni,
              selected = "13101 東京都 千代田区",
              options= list(maxOptions = 2000)
            )   
          ),
          #選択
          column(
            width = 3,
            radioButtons(
              "listLineGender",
              width = "100%",
              label = h4(span(icon("user"), "性別の選択：")),
              choices = list(
                "全体" = 0,
                "男性" = 1,
                "女性" = 2
              ),
              selected = 0,
              inline = TRUE
            )
          ),
          #選択
          column(
            width = 3,
            radioButtons(
              "listLineAge",
              width = "100%",
              label = h4(span(icon("users"), "年齢層の選択：")),
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
          #更新ボタン
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
        tabName = "tab_table1",
        fluidRow(
          style = "margin-top: -20px; margin-bottom: -10px;",
          column(
            width = 12,
            div(style = "margin-top: 10px")
          ),
          #選択
          column(
            width = 3,
            airDatepickerInput(
              "listTableDate",
              label = h4(span(icon("calendar"), "年月の選択：")),
              value = "2016-08-01",
              min = "2015-09-01",
              max = "2016-08-01",
              view = "months",
              minView = "months",
              dateFormat = "yyyy-MM",
              autoClose = TRUE,
              language = "ja"
            )
          ),
          #選択
          column(
            width = 3,
            radioButtons(
              "listTableDay",
              width = "100%",
              label = h4(span(icon("business-time"), "平日・休日の選択")),
              choices = list(
                "平日" = 1,
                "休日" = 2
              ),
              selected = 1,
              inline = TRUE
            )
          ),
          #選択
          column(
            width = 3,
            radioButtons(
              "listTableGender",
              width = "100%",
              label = h4(span(icon("user"), "性別の選択：")),
              choices = list(
                "全体" = 0,
                "男性" = 1,
                "女性" = 2
              ),
              selected = 0,
              inline = TRUE
            )
          ),
          #選択
          column(
            width = 3,
            radioButtons(
              "listTableAge",
              width = "100%",
              label = h4(span(icon("users"), "年齢層の選択：")),
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
          #選択
          column(
            width = 12,
            style = "margin-bottom: 20px; color: white;",
            actionButton(
              "buttonTableUpdate", 
              span(icon("play-circle"), "更新"), 
              class = "btn btn-primary",
              width = "100%"
            )
          ),
          box(
            width = 12,
            dataTableOutput("tableDeltaTop") %>%
              withSpinner(color = getOption("spinner.color", default = "#3C8EBC"))
          )
        )
      ),
      #++++++++++++++++++++++++++++++++++++++
      tabItem(
        tabName = "exp",
        fluidRow(
          style = "margin-bottom: -20px; margin-left: -30px; margin-right: -30px;",
          column(
            width = 12,
            div(
              class = "mx-0 px-0 col-sm-12 col-md-12 col-lg-10 col-xl-10",
              box(
                width = NULL,
                title = h2(span(icon("book-open"), "解説")),
                solidHeader = TRUE,
                #------------------------------------------------------------------
                box(
                  width = NULL,
                  title = h3(span(icon("fas fa-pen-square"), "ポイント")),
                  background = "blue",
                  solidHeader = FALSE,
                  HTML(
                    "<ul>
                      <li>人流データを用いた、行き先地としての地域の魅力度を計測する指数を開発。</li>
                      <li>地図、時系列、表という3つの側面から地域魅力度指数を可視化するWebアプリを開発。</li>
                      <li>地域のバイタルサインとなる継続的な運用を想定した社会実装を地方自治体に提案。</li>
                    </ul>"
                  )
                ),
                #------------------------------------------------------------------
                box(
                  width = NULL,
                  title = h3(span(icon("fas fa-pen-square"), "3つの可視化システム")),
                  background = "blue",
                  solidHeader = FALSE,
                  #--------------------
                  h4("1. 地図による可視化"),
                  p("地図上に地域魅力度指数を可視化します。地理空間上でどのように地域魅力度指数が分布しているのかを市区町村単位で視覚的に捉えられるようにしています。"),
                  #--------------------
                  h4("2. 時系列による可視化"),
                  p("時系列方向にデータを可視化します。同時に2つの市区町村を比較しながら可視化することで、各市区町村における季節要因やイベントが地域魅力度指数に与える影響を捉えられるようにしています。"),
                  #--------------------
                  h4("3. 表による可視化"),
                  p("表としてデータを可視化します。データの並べ替え機能によって、全市区町村における相対的な位置づけを確認しながら地域の特徴を捉えることができます。")
                ),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("fas fa-pen-square"), "地域魅力度指数とは？")),
                #--------------------
                h4("地域魅力度指数の開発背景"),
                p("私たちが健康状態を知るためにバイタルサインを計測するように、私たちが住む地域にも社会や経済の状態を知るためのバイタルサインのような指標が存在するように思います。これは、新型コロナウイルス感染症の流行以降、経済産業省と内閣官房デジタル田園都市国家構想実現会議事務局が提供するRESAS（地域経済分析システム）をより発展させたV-RESASの開発背景にある考えでもあります。"),
                p("地域のバイタルサインとなる指標として様々な候補があると思いますが、地域の魅力度を地域のバイタルサインの1つとして観測できないかと思っています。人口減少社会において地方では居住者としての人口は減少しつつありますが、依然として地域の魅力は残されているように思います。居住者としての人口規模や経済活動の規模に依存しない、より中立的な観点から地域の魅力度を定量化できないかと考えていました。"),
                p("そもそも地域の魅力をどのように定量化できるのかが課題です。地域の魅力の軸は多様であり、主観的でもあり、定性的な側面もあります。例えば、平日には訪れる人が少なくても休日になると多くの人が訪れる地域があったり、季節によっても地域の魅力は変わったりします。そして、地域のバイタルサインとして計測するとなると、元となるデータが安定的かつ継続的に観測されていることが重要になります。アンケートで地域の魅力を調査することもできますが、時間も費用もかかってしまい、知りたいときにすぐ知れないということになります。"),
                p("近年は技術発展によりビッグデータの利用可能性が高まる中、「人流データ」が地域のバイタルサインを測るためのデータ源になるのではないかと着目しています。そこで、人流データから遡って、人々が暗黙に評価している地域の魅力度を定量化しようと考えました。私たちが客観的に観測できるものは、人々が地域を訪れたという事実のみです。そこから突き詰める問いとは、たくさんの行き先地域の選択肢があるなかで、なぜその１つの地域を選択したのかを考えることです。そのような人々の移動選択を理論モデルとして構築し、人流データと合わせることで、人々はどのような地域を魅力的に感じて訪れたのかという選好を定量的に評価していきます。"),
                p("ただ人流データの扱いの難しさは、一種のネットワークデータであることに関係します。実際に、新型コロナウイルス感染症の感染拡大予測として人流データが大きな注目を集めましたがうまく生かしきれなかった場面も多かったように思います。ネットワークデータとしての人流データとは、点として観測される情報ではなく、点と点を結ぶ線の情報になっているということです（ネットワーク分析では、点のことをノード、線のことをエッジと呼びます）。人流データの場合、出発地(Origin)と到着地(Destination)の2つの点の間で移動した人数のデータがよく扱われ、OriginとDestinationの頭文字からODデータ、ODフロー、OD行列等で呼ばれています。"),
                p("地域魅力度指数では、出発地と到着地の2つの点を結ぶ線としての人流データから、理論モデルを通してみることで、より直感的でわかりやすい形で地域のバイタルサインを抽出しています。詳細はKondo(2023)において議論していますが、もう少し具体的には、地域間を結ぶ線の情報を、理論モデルによって、地域毎の点の情報へ集約できるのではないかという提案をしています。"),
                p("以上の背景とともに、エビデンスに基づく政策形成（Evidence-based Policy Making, EBPM）の重要性が叫ばれはじめたことを踏まえ、政策現場での社会実装につながる新たな挑戦的な試みとしてプロジェクトを開始しました。"),
                #--------------------
                h4("地域魅力度指数の解釈"),
                p("今回提案する地域魅力度指数はゼロ以下の数値（基本的には負の値）を取るように設計されており、ゼロに近いほど行き先としての地域魅力度が高いことを表します。ここでの地域魅力度とは、「行き先としての地域魅力度」を表しており、遠くの様々な地域からより多くの人々を引き寄せられる力を魅力度として計測しています。したがって自市区町村内の移動やあまりに近すぎる隣接市区町村からの人流データは考慮されておらず、居住地としての地域魅力度ではないことに注意する必要があります。"),
                p("地域魅力度指数の直感的な解釈として、以下の図1、図2を見てください。"),
                tags$img(src = "fIG_mobilephone_scatterline_cnt_trip_lndist_ym201608_gender0_age00_muni27104.svg", width = "100%"),
                HTML("<p><b>図1.</b> 大阪府大阪市此花区への移動人数と移動距離の関係<br>
                     出所：2016年8月の男女計・全年齢の14時における市区町村間の移動データより著者作成。移動距離は市区町村間の緯度・経度から計算した大圏距離を計算。</p>"),
                tags$img(src = "fIG_mobilephone_scatterline_cnt_trip_lndist_ym201608_gender0_age00_muni28110.svg", width = "100%"),
                HTML("<p><b>図2.</b> 兵庫県神戸市中央区への移動人数と移動距離の関係<br>
                     出所：2016年8月の男女計・全年齢の14時における市区町村間の移動データより著者作成。移動距離は市区町村間の緯度・経度から計算した大圏距離を計算。</p>"),
                p("今回提案する地域魅力度指数を直感的に理解するには、2地点間の移動人数と移動距離（対数値）の散布図が役立ちます。図1、図2では、縦軸が移動人数、横軸が移動距離になっており、徐々に減少していくような曲線が描かれていますが、この曲線の傾斜の緩やかさが地域魅力度指数になっています。例えば、図1のように傾斜がゆるやかで遠くまで減少しにくいのであれば地域魅力度指数が高くなり、図2のように、傾斜が急でありすぐに減少してしまうのであれば地域魅力度指数は低くなります。厳密には、図1、図2に示されている数式において、移動距離（対数値）の係数パラメータ推定値が地域魅力度指数として解釈されています。図1では、平日(weekdays)が-0.945、休日・祝日(weekends/holidays)が-0.962という数値、図2では、平日(weekdays)が-1.956、休日・祝日(weekends/holidays)には-1.838という数値が統計モデルの推定値から得られています。なお移動人数にはゼロの人数を含むため、両対数線形回帰モデルではなく非線形回帰モデルとしてゼロも考慮した定式化をしていることに注意が必要です（重力方程式と呼ばれますが、その他の要因の変数を含まない移動距離の1変数だけの定式化にしています）。"),
                p("この係数パラメータがゼロに近い（よりフラットな曲線になる）ということは、より遠くに居住する人々さえも強く引き寄せることが可能ということを意味します。学術研究では「距離の摩擦(friction of distance)」や「距離減衰(distance decay)」とも呼ばれますが、私たちは距離の摩擦の影響を大きく受けており、より遠くまで移動することが難しいことが観測されています。一般的には移動距離が長くなるにつれ移動費用が増加していくのですが、魅力度の高い地域は、この移動費用を小さくする何かを持っていると考えられます。"),
                p("今回は市区町村を単位とした人流データを用いており、全ての市区町村から1つ1つの市区町村を到着地とするデータを推定することによって、各市区町村の地域魅力度指数を計測しています。実際に調べてみると、市区町村毎に異なった値を示しており、このパラメータ推定値のばらつきには、その地域がなぜ遠くからでも人を引き寄せることができるのかという問いに答えるための重要な情報が含まれています。どのような要因が地域魅力度指数を高くしたり低くしたりしているのかを調べることも重要であり今後の課題ですが、まずは各地域がどのような値を示すのかを第一歩として地域魅力度指数可視化システムの開発に取り組みました。"),
                p("この地域魅力度指数の利点は、同じ人流データかつ同じモデルを推定している限りは、地域間や異時点間でも比較可能である点です。例えば、全市区町村の中で自市区町村の位置づけを調べることもできます（ランキングとして見ることもできますが、順位のみで市区町村間の優劣を議論するのは建設的な見方ではありません）。また、ある地域で何かイベントを実施する場合、多くの人々が訪れてくれると思いますが、地域魅力度指数がどれほど上昇したのかを検証することもできます。"),
                p("さらに人口規模に依存しない計測法を意図しています。例えば、訪問者数のように人口規模に依存するような定式化にしてしまうと、人口規模の小さな地方自治体では高い地域魅力度を示すことが難しくなってしまいます。したがって、人口規模に依存しないという視点を可能な限り考慮した地域魅力度の計測を試みているのが特徴です。"),
                p("なお参考情報として、全市区町村に占める非ゼロフロー割合も確認することができるようにしています。全市区町村数（政令指定都市内は区単位）は1896あり、自市区町村を除いた1895を分母に用いています。分子は、移動人数がゼロではない市区町村間のつながりの数（エッジの数）になります。なお、このつながりの数が10以下の市区町村は地域魅力度指数の推定の信頼性の観点から分析の対象外としました。この全市区町村に占める非ゼロフロー割合は、ネットワーク分析における中心性指標の1つである次数中心性と同じ概念になっています。"),
                #--------------------
                h4("いくつかの具体例の紹介"),
                p("いくつかの市区町村を取り上げています。すべての市区町村を取り上げることはできませんが、他にも特徴的な地域魅力度指数を示す市区町村が多くあります。何がそのような要因をもたらすのか、時には地図を見ながら、仮説をたてて調べていくと参考になるのではないかと思います。"),
                #----------
                h5("千葉県浦安市（市区町村コード：12227）"),
                p("千葉県浦安市の地域魅力度指数は、図3に示すように、全期間を通じて-1前後で推移しており、この値は全国的にも最上位に分類される数値です。行き先として魅力度の高い市と言えますが、その理由として、東京ディズニーリゾートが考えられます。特に3月平日に指数が上昇することから、春休みの進級・卒業シーズンに全国から多くの人々を引き付けていることが分かります。性別や年齢層別にも調べられ、男性よりも女性にとって、60歳以上よりも60歳未満の方にとって魅力的な地域ということが言えます。また、全市区町村に占める非ゼロフロー割合を見ると、全国のおよそ半数以上の市区町村から浦安市へ訪れていることもわかり、地域魅力度の高さを裏付ける要因にもなります。"),
                tags$img(src = "rai-line-12227-urayasu.png", width = "100%"),
                HTML("<p><b>図3.</b> 千葉県浦安市における地域魅力度指数の推移<br>
                     出所：「時系列の可視化」メニューの男女計・全年齢より著者作成。</p>"),
                #----------
                h5("大阪府大阪市此花区（市区町村コード：27204）"),
                p("世界的なテーマパークとして有名なユニバーサル・スタジオ・ジャパンが立地する大阪府大阪市此花区の地域魅力度指数を見ると、図4に示すように、全期間を通じて-1前後で推移しており、千葉県浦安市と同様に、行き先として地域魅力度が非常に高いことがわかります。年間を通じて全国的にも最上位に分類されています。2025年の大阪・関西万博の開催地でもあり、今後の大阪市此花区の地域魅力度指数がどのように変化するのかも気になるところです。"),
                tags$img(src = "rai-line-27104-osaka-konohana.png", width = "100%"),
                HTML("<p><b>図4.</b> 大阪府大阪市此花区における地域魅力度指数の推移<br>
                     出所：「時系列の可視化」メニューの男女計・全年齢より著者作成。</p>"),
                #----------
                h5("兵庫県西宮市（市区町村コード：28202）"),
                p("兵庫県西宮市の地域魅力度指数は、図5に示すように、-1.8から-2の間を推移しており、この値は全国の県庁所在地の市や中核市と比較しても少し高めの数値になっています。さらに、8月になると-1.2程度まで急上昇し、地域魅力度を押し上げる何か特別な要因があることが推察されます。おそらく、夏の甲子園（全国高校野球選手権記念大会）の影響と考えられ、季節やイベント要因による影響を地域魅力度指数が捉えていることがわかります。"),
                tags$img(src = "rai-line-28204-nishinomiya.png", width = "100%"),
                HTML("<p><b>図5.</b> 兵庫県西宮市における地域魅力度指数の推移<br>
                     出所：「時系列の可視化」メニューの男女計・全年齢より著者作成。</p>"),
                #----------
                h5("沖縄県那覇市（市区町村コード：47201）"),
                p("沖縄県那覇市は、沖縄観光の玄関口となる那覇空港もあり、沖縄県の中心的な市でもあります。図6に示すように、地域魅力度指数は年間を通じて-1.1から-1.2の間で値が推移しており、観光地であっても季節性に依存せず、年間を通じて変動が少ないのも特徴です。沖縄県へ訪れるには長距離移動が必要になるにもかかわらず、全国からたくさんの人を引き寄せるだけあって日本全国でも最上位に分類されるほど地域魅力度の高い地域になっています。"),
                tags$img(src = "rai-line-47201-naha.png", width = "100%"),
                HTML("<p><b>図6.</b> 沖縄県那覇市における地域魅力度指数の推移<br>
                     出所：「時系列の可視化」メニューの男女計・全年齢より著者作成。</p>"),
                #----------
                h5("長野県山ノ内町（市区町村コード：20561）"),
                p("長野県山ノ内町は山間部にある町ですが、図7に示すように、地域魅力度指数は冬季(12月から3月)にかけて-0.5から-1の間で値が推移しています。山ノ内町は志賀高原や湯田中渋温泉郷等で知られる国内屈指の人気リゾート地であり、冬にはスキー場エリアとして人気もあることから、このような季節要因が地域魅力度指数に反映されていると考えられます。一方で、オフシーズンの時期には、-3程度まで下落してしまい、年間を通じて変動が激しい地域であることがわかります。人口規模は小さくても、季節によっては大都市以上の魅力度を持つ地域であることが分かります。山間部にはこのような特徴を示す町村が他にも多く見られます。"),
                tags$img(src = "rai-line-20561-yamanouchi.png", width = "100%"),
                HTML("<p><b>図7.</b> 長野県山ノ内町における地域魅力度指数の推移<br>
                     出所：「時系列の可視化」メニューの男女計・全年齢より著者作成。</p>"),
                #--------------------
                h4("地域魅力度指数の限界"),
                p("まず地域魅力度指数は比較可能と説明しましたが、同じ人流データと同じ推定方法を適用したときのみという条件があります。異なる人流データであったり、対象となる地域区分が異なったり、別の推定法を用いたりすれば、出力される値も異なってしまうので比較をする際には注意が必要です。"),
                p("地域魅力度指数は、特定の仮定に基づいて構築された理論モデルと人流データを合わせて得られる数値です。科学的な手続きに沿って推定していますが、主観的な側面も含まれていることには留意する必要があります。例えば、どのモデルを採用するのかは分析者の主観的な判断が介入することになります。また、人流データを用いた統計モデルを推定する際には、どのような人流データを利用するのか、どのように2地点間の距離を計測するのか、どのような推定法を用いるのか、点推定だけでなく信頼区間はどうするのか、サンプルサイズの大小が与える推定値の不安定さや、異常値が一部含まれることによる影響等、様々な観点から分析者が主観的に基準を設定して、ある程度の妥当的な値が得られるように推定を行っています。"),
                p("もちろん個々の地域に対して意図的に地域魅力度指数を操作することはできませんが、様々な批判が生じるかもしれません。一次データの可視化だけならばこのような批判は起こりませんが、モデルの仮定や推定法等に分析者の主観的な側面を含むことで評価軸が複雑になり、懸念すべき点も増えてきます。ただ批判を受けることは悪いことではなく、膨大なデータからいかに本質的な情報を抽出するのかという課題へ一歩進むためには、理論モデルというレンズを通してデータを見ることが必要になってきます。今後もデータサイエンスの社会実装を扱うのであれば、常に疑問を検証できるような科学的な手続きに沿って、批判と対話できる形で日々改善していくことが求められるように思います。"),
                p("科学的な手続きに沿って取り組むと述べましたが、再現可能性ということに行きつくと思います。まずは恣意的操作の疑念を解消できるように、GitHubを通じて可能な限りコードやデータはオープン化しています。そのうえで、分析の枠組みへの様々な批判も出てくるとよいと思いますし、現時点では気づいていない地域魅力度指数の注意すべき特性があとで見つかったり、より適切な指数の名称があったりするかもしれません。引き続きより良い社会実装につながるように修正できればと思います。また、今回提案した地域魅力度指数1つだけを持って、地域のすべての側面の魅力を捉えることはできませんので、他にも地域のバイタルサインとなるような様々な指標が出てくるとよいと思います。"),
                #--------------------
                h4("今後の期待"),
                p("近年、地域のバイタルサインを表すような指標の開発が進んでいます。例えば、暮らしやすさの観点から徒歩圏内の施設充実度を評価する指標として「Walkability Index」が提案されています（清水他, 2020; 清水, 2022）。またコロナ禍には、感染拡大防止に向けた取り組みとして、人流データから計算された「外出自粛率（Stay Home指数）」が提案されました（水野他, 2020）。"),
                p("今回提案する地域魅力度指数は、自市区町村を到着地とする人流データさえあれば各地方自治体が独立に計算することが可能です。民間企業の人流データをそのままオープン化することはできませんが、理論モデルの推定値として得られた地域魅力度指数ならばオープンデータ化することも可能です。各自治体から地域魅力度がオープンデータ化されることで、条件を満たすならば、それを統合した全国版データセットの作成も可能になっていくと思います。"),
                p("今回はRESAS APIから入手可能な「モバイル空間統計」（NTTドコモ）に基づく人流データを取得しており、2015年9月から2016年8月までの市区町村単位で月次単位の人流データの制約の下で地域魅力度指数を計算しましたが、さらに小さな地域単位で、より長期間にわたり日次や週次単位の人流データを入手することができれば、より詳細な地域のバイタルサインを得ることができます。日ごろから地域のバイタルサインを蓄積しておくことで、今後はより発展的な統計分析につながることも期待されます。"),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("book"), "参考文献")),
                HTML(
                  "<ul>
                    <li>Kondo, Keisuke (2023) Measuring the attractiveness of trip destinations: A study of the Kansai region of Japan, RIEB Discussion Paper Series No.2023-07.　<a style = `target _blank;` href = `https://www.rieb.kobe-u.ac.jp/academic/ra/dp/English/DP2023-07.pdf`>https://www.rieb.kobe-u.ac.jp/academic/ra/dp/English/DP2023-07.pdf</a></li>
                    <li>清水千弘・馬塲弘樹・川除隆広・松縄暢（2020）「Walkabilityと不動産価値: Walkability Indexの開発」、東京大学CSIS Discussion Paper、No. 163　<a href = `https://www.csis.u-tokyo.ac.jp/wp-content/uploads/2020/06/163.pdf`>https://www.csis.u-tokyo.ac.jp/wp-content/uploads/2020/06/163.pdf</a></li>
                    <li>清水千弘（2022）「地域の魅力の測定方法とその課題：Walkability Index・再考」、東京大学CSIS Discussion Paper、No. 175　<a href = `https://www.csis.u-tokyo.ac.jp/wp-content/uploads/2022/08/220804WI_ShimizuF-1.pdf`>https://www.csis.u-tokyo.ac.jp/wp-content/uploads/2022/08/220804WI_ShimizuF-1.pdf</a></li>
                    <li>水野 貴之・大西立顕・渡辺努（2020）「流動人口ビッグデータによる外出の自粛率の見える化」、『人工知能』、2020 年 35 巻 5 号、667-672頁　DOI: <a href = `https://doi.org/10.11517/jjsai.35.5_667` target = `_blank`>https://doi.org/10.11517/jjsai.35.5_667</a></li>
                  </ul>"
                ),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("calendar"), "更新履歴")),
                p("2024年1月26日：解説タブを追加")
              )
            )
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
            div(
              class = "mx-0 px-0 col-sm-12 col-md-12 col-lg-10 col-xl-10",
              box(
              width = NULL,
                title = h2(span(icon("info-circle"), "はじめに")),
                solidHeader = TRUE,
                p("はじめに、下記の利用規約等をご一読ください。"),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("fas fa-file-alt"), "利用規約")),
                p(
                  "当サイトで公開している情報（以下「コンテンツ」）は、どなたでも自由に利用できます。コンテンツ利用に当たっては、本利用規約に同意したものとみなします。本利用規約の内容は、必要に応じて事前の予告なしに変更されることがありますので、必ず最新の利用規約の内容をご確認ください。"
                ),
                #--------------------
                h4("著作権"),
                p("本コンテンツの著作権は、近藤恵介に帰属します。"),
                #--------------------
                h4("第三者の権利"),
                p(
                  "本コンテンツは、「From-To分析（滞在人口）」（RESAS）および「統計地理情報システム」（e-Stat）の情報に基づいて作成しています。「From-To分析（滞在人口）」は「モバイル空間統計®」（NTTドコモ）に基づいたデータであり、RESAS APIを利用して2015年9月から2016年8月までの期間をダウンロードして使用しています。本コンテンツを利用する際は、第三者の権利を侵害しないようにしてください。"
                ),
                #--------------------
                h4("免責事項"),
                p("(a) 作成にあたり細心の注意を払っていますが、本サイトの内容の完全性・正確性・有用性等についていかなる保証を行うものでありません。"),
                p("(b) 本サイトを利用したことによるすべての障害・損害・不具合等、作成者および作成者の所属するいかなる団体・組織とも、一切の責任を負いません。"),
                p("(c) 本サイトは、事前の予告なく変更、移転、削除等が行われることがあります。"),
                #--------------------
                h4("その他"),
                p("本コンテンツに関する問い合わせについて、下記のEmailより近藤恵介宛までご連絡ください。"),
                p("Email: kondo-keisuke@rieti.go.jp"),
                #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("user-circle"), "作成者")),
                p(
                  "近藤恵介", br(),
                  "独立行政法人経済産業研究所・上席研究員", br(),
                  "神戸大学経済経営研究所・准教授"
                ),
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
                h3(style = "border-bottom: solid 1px black;", span(icon("receipt"), "競争的研究費")),
                p("地域魅力度指数可視化システムの開発にあたり、Kondo(2023)の研究成果に大きく依存しています。Kondo(2023)は以下の研究費の支援を受け実施しています。"),
                HTML(
                  "<ul>
                    <li>「人流データを活用した神戸観光の推進と商業活性化に関する研究」（研究代表者：近藤恵介）、神戸市、大学発アーバンイノベーション神戸、A22115<br>
                    URL: <a href='https://www.city.kobe.lg.jp/documents/57961/kenkyuseikakondou.pdf' target='_blank'>https://www.city.kobe.lg.jp/documents/57961/kenkyuseikakondou.pdf</a></li>
                    <li>「地理空間情報とミクロデータを融合した経済分析」（研究代表者：近藤恵介）、日本学術振興会、 科学研究費助成事業、基盤研究(C)、21K01497<br>
                    URL: <a href='https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-21K01497/' target='_blank'>https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-21K01497/</a></li>
                    <li>「コミュニケーションシステムと都市地域空間の発展：東京一極集中と働き方改革への示唆」（研究代表者：浜口伸明）、日本学術振興会、 科学研究費助成事業、基盤研究(C)、23K01348<br>
                    URL: <a href='https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-23K01348/' target='_blank'>https://kaken.nii.ac.jp/ja/grant/KAKENHI-PROJECT-23K01348/</a></li>
                  </ul>"
                ),
                h4("参考文献"),
                HTML(
                  "<ul>
                    <li>Kondo, Keisuke (2023) Measuring the attractiveness of trip destinations: A study of the Kansai region of Japan, RIEB Discussion Paper Series No.2023-07.<br>
                    URL: <a href='https://www.rieb.kobe-u.ac.jp/academic/ra/dp/English/DP2023-07.pdf' target='_blank'>https://www.rieb.kobe-u.ac.jp/academic/ra/dp/English/DP2023-07.pdf</a></li>
                  </ul>"
                ),              #------------------------------------------------------------------
                h3(style = "border-bottom: solid 1px black;", span(icon("calendar"), "更新履歴")),
              　p(
                  "2024年1月26日：「利用規約」に「その他」を追加、「競争的資金」を追加", br(),
            　    "2024年1月2日：対象地域を全国に拡張し日本語版へ移行", br(),
                  "2023年11月10日：GitHubに関西圏限定版を英語公開"
              　)
              )
            )
          )
        )
      )
    )
  )
)
