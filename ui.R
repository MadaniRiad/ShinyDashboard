title1 <- tags$a(href='',icon("chart-pie"), "Taux d'inflation")

dashboardPage(
  #définir l'en-tête
  dashboardHeader(
    title=title1,
    dropdownMenu()
  ),


  #définir la barre latérale
  dashboardSidebar(
    sidebarMenu(
      menuItem("Tableau de bord", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("A propos", tabName = "about", icon = icon("th")),
      menuItem("Mouvement syndical",tabName="unions",icon=icon("signal")),
      menuItem("Jeu de données", tabName = "dataset", icon = icon("database")),
      menuItem("Le monde",tabName="world",icon=icon("globe")),
      menuItem("Maps",tabName="maps",icon=icon("location-crosshairs"))

    )
  ),


  #définit le corps de notre Tableau de bord
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css") #rajouter un fichier css
    ),

  tabItems(
    #Premier TAB-Menu du Tableau de bord
    tabItem(tabName = "dashboard",
            fluidRow(column(12,
                            box(selectizeInput("country",label="Veuillez sélectionner une option ci-dessous",choices=country,
                                               options = list(
                                                 placeholder = "Veuillez sélectionner une option ci-dessous, car ce champ ne répond pas aux chaînes vides",
                                                 onInitialize = I('function() { this.setValue("Afghanistan"); }')
                                               )),width = 12)
                            ),#end column
                     #box for plotting the time series plot
                     column(12,
                            box(highchartOutput("hcontainer"),width=12) #end box2
                            ), #end column
                     hr(),
                     h4("Graphique de la série chronologique des taux d'inflation relatifs",align="center"),
                     br(),
                     column(12,
                            box(highchartOutput("hc2"),width=12)
                            )
                     ),#end row
            h4("Réaliser par", strong("MADANI Riad")),
            a("R code du projet",target="_blank",href="")
              ),

    #2eme TAB-Menu du Tableau de bord
    tabItem(tabName="about",
            h2("Qu'est-ce que l'inflation ?",style="text-align:center"),
            br(),
            br(),
            box(width=12,height="400px",
                p(style="font-size:20px",strong("Inflation"),"les taux sont le taux général auquel le prix des biens et services
                  au sein d'une économie donnée augmentent et le pouvoir d'achat de la monnaie
                  est en baisse en raison des prix élevés des marchandises. Une inflation élevée n'est certainement pas bonne pour une économie
                  car cela réduira toujours la valeur de l'argent. En général, les banques centrales d'une économie essaient et travaillent à réduire
                  le taux d'inflation et éviter la déflation."),

                p(style="font-size:20px",strong("Deflation"), "est le contraire de l'inflation. La déflation se produit lorsque les taux d'inflation deviennent négatifs ou sont inférieurs à 0. La déflation est plus nocive et dangereuse pour une économie car elle signifie que les prix des biens et services vont baisser. Maintenant, cela semble incroyable pour les consommateurs comme nous. Mais ce qui se passe réellement, c'est que la demande de biens et de services a diminué sur une longue période.
                  Cela indique directement qu'une récession est en route. Cela entraîne des pertes d'emplois, une baisse des salaires et un coup dur pour le portefeuille d'actions. La déflation ralentit la croissance de l'économie. Au fur et à mesure que les prix baissent, les gens reportent leurs achats dans l'espoir d'un meilleur prix plus bas. En raison de cela, les entreprises et les entreprises doivent réduire
                  baisser le coût de leurs biens et produits, ce qui affecte directement les salaires des employés qui doivent être abaissés.")
                )
            ),

    #3eme TAB-Menu du Tableau de bord
    tabItem(tabName = "unions",
            h3("Série chronologique des taux d'inflation des syndicats économiques",align="center") ,
            fluidRow(
              column(12,
                     box(selectInput("region",label="Sélectionnez la région économique",choices=unions),width = 12)
                     ),
                     box(highchartOutput("hc3"),width=12)
              )
            ),

    #4eme TAB-Menu du Tableau de bord
    tabItem(tabName = "dataset",
            fluidPage(
               title = "jeu de données",
               fluidRow(dataTableOutput(outputId = "mytable1"))

             )
            ),

    #5eme TAB-Menu du Tableau de bord
    tabItem(tabName = "world",
            h3("Taux d'inflation dans le monde",align="center"),
            box(highchartOutput("hc4"), width=12)
            ),

    #Premier TAB-Menu du Tableau de bord
    tabItem(tabName = "maps",
            #Pour l'affichage du 'loader' le spin de chargement avant l'apparition du map
            shinycssloaders::withSpinner(
            leafletOutput("mymap",  height = "600",
                          )),
            absolutePanel(top = 70, right = 20,
                          sliderInput("slider1", "Veuillez choisir une année", min(as.numeric(inf$year)), max(as.numeric(inf$year)),
                                      value = 2022, sep = "", step = 1
                          ),

            ))

    )#Fin de tabitems


)#Fin du corps 'body'

)#Fin du Dashboard
