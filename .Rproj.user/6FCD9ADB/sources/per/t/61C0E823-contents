server <- function(input, output) {

  #Création d'une fonction réactive data_input() qui réagit en fonction de l'année sélectionner dans le slider
  #pour l'affichage des taux d'inflation en fonction de l'année
  data_input <- reactive({
    inf %>%
      filter(year == input$slider1)
  })

  #Création d'une 2eme fonction réactive data_input_ordered qui permet de vérifier la correspondance
  #des noms de pays entre la fonction data_input() et les coordonnées spatial de plot_map
  data_input_ordered <-  reactive({
    data_input()[order(match(data_input()$region, plot_map$ADMIN)),]

  })


  #'mytable1' Pour afficher notre jeu de données
  output$mytable1 <- renderDataTable(data_input())


  #'hcontainer' Pour afficher l'évolution du taux d'inflation en fonction du pays au cours des années
  output$hcontainer <- renderHighchart ({
    df<-inf %>% filter(region==input$country)
    df$inflation<-as.numeric(df$inflation)
    df$year<-as.numeric(df$year)
    #plotting the data
    hchart(df, "line",color="#4682B4",hcaes(x=year,y=inflation))  %>%
      hc_exporting(enabled = TRUE) %>%
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5", shared = TRUE, borderWidth = 2) %>%
      hc_title(text="Diagramme de série chronologique des taux d'inflation",align="center") %>%
      hc_subtitle(text="Source de données: IMF",align="center") %>%
      hc_add_theme(hc_theme_elementary())

    #to add 3-d effects
    #hc_chart(type = "column",
    #options3d = list(enabled = TRUE, beta = 15, alpha = 15))

    })

  #'hc2' Pour afficher une comparaison de l'évolution du taux d'inflation
  # en fonction des 5 pays (propre choix) au cours des années
  output$hc2<-renderHighchart({
    highchart() %>%
      hc_xAxis(categories=inf$year) %>%
      hc_add_series(name = "India", data = India$inflation) %>%
      hc_add_series(name = "USA", data = US$inflation) %>%
      hc_add_series(name = "UK", data = UK$inflation) %>%
      hc_add_series(name = "China", data = China$inflation) %>%
      hc_add_series(name = "France", data = Fr$inflation) %>%
      hc_add_series(name="Japan",data=Japan$inflation) %>%
      hc_add_series(name="Algeria",data=ALG$inflation) %>%
      #Pour ajouter des couleurs
      hc_colors(c("red","blue","brown","purple","darkpink","orange","green")) %>%
      hc_add_theme(hc_theme_elementary())

    })


  #'hc3' Pour afficher l'évolution du taux d'inflation
  # en fonction des régions économiques dand le monde au cours des années
  output$hc3<-renderHighchart({
    union<-inf %>% filter(region==input$region)
    union$year<-as.numeric(union$year)
    union$inflation<-as.numeric(union$inflation)
    #traçage des graphs
    hchart(union,hcaes(x=year,y=inflation),type="area",color="#2B1F97") %>%
      hc_exporting(enabled = TRUE) %>%
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5",shared = TRUE, borderWidth = 2) %>%
      hc_title(text="Diagramme de série chronologique des taux d'inflation pour les unions économiques",align="center") %>%
      hc_subtitle(text="Source de données: IMF",align="center") %>%
      hc_add_theme(hc_theme_elementary())


    })

  #'hc4' Pour afficher l'évolution du taux d'inflation dans le monde entier au fil des années
  output$hc4<-renderHighchart({
    world<-inf %>% filter(region=="World")
    world$year<-as.numeric(world$year)
    world$inflation<-as.numeric(world$inflation)

    #traçage des graphs
    hchart(world,hcaes(x=year,y=inflation),type="area",color="#4B0082") %>%
      hc_exporting(enabled = TRUE) %>%
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5", shared = TRUE, borderWidth = 2) %>%
      hc_title(text="Diagramme de série chronologique des taux d'inflation a travers le monde",align="center") %>%
      hc_subtitle(text="Source de données: IMF",align="center") %>%
      hc_add_theme(hc_theme_elementary())
    })


  #mymap a l'aide du package (leaflet) permet d'afficher la carte des pays touché par l'inflation
  #avec le taux d'inflation enregistré durant une année bien déterminée
  output$mymap <- renderLeaflet({

    input$slider1
    Sys.sleep(1.5)#Pour l'affichage du 'loader' le spin de chargement avant l'apparition du map

    mymap <- leaflet() %>%
        addTiles() %>%
        addPolygons(data = plot_map, color = "blue",
                    label = ~paste0("Pays : ", ADMIN," - Taux d'inflation : ", as.numeric(data_input()$inflation)),
                    weight = 1,
                    highlightOptions = highlightOptions(color = "red", bringToFront = TRUE, weight = 2),
                    labelOptions = labelOptions(
                      style = list("font-weight" = "normal", padding = "3px 8px"),
                      textsize = "15px",
                      direction = "auto")
                    )


  })


}
