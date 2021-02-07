MapProj <- function(){
     library(tidyverse)
     library(leaflet)
     
     COVID <- tibble(read.csv("~/Desktop/COVID-19_Cases_US.csv"))
     
     COVID <- COVID %>% filter(!is.na(Lat)) %>% filter(!is.na(Long_)) %>% filter(Country_Region == "US")
     COVID <- COVID %>% mutate(PopupInfo=paste(Admin2,Confirmed,sep=", "))
     COVID <- COVID %>% mutate(InfClass=cut(Confirmed,breaks=c(0,1000,10000,50000,500000)))
     COVID <- COVID %>% mutate(MyColor=factor(InfClass,labels=c("blue","green","yellow","red")))
     
     MyMap <- COVID %>% leaflet() %>% addTiles() %>% addMarkers(lat=~Lat,lng=~Long_,popup=~PopupInfo,
                                                                clusterOptions=markerClusterOptions())
     MyMap
     
}