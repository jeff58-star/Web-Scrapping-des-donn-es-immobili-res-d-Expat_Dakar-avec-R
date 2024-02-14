#library
library(rvest)
library(tidyverse)

expart_dakar <- data.frame()

for (page_result in seq(from = 1, to =151  , by = 1)){
  
  #link <- paste0("https://www.expat-dakar.com/appartements-a-louer?page=", page_result)
  #link <- paste0("https://www.expat-dakar.com/appartements-meubles?page=", page_result)
  #link <- paste0("https://www.expat-dakar.com/terrains-a-vendre?page=", page_result)
  #link <- paste0("https://www.expat-dakar.com/maisons-a-vendre?page=", page_result)
  #link <- paste0("https://www.expat-dakar.com/maisons-a-louer?page=", page_result)
  #link <- paste0("https://www.expat-dakar.com/appartements-a-vendre?page=", page_result)
  #link <- paste0("https://www.expat-dakar.com/proprietes-commerciales-a-louer?page=", page_result)
  #link <- paste0("https://www.expat-dakar.com/chambres-a-louer?page=", page_result)
  #link <- paste0("https://www.expat-dakar.com/proprietes-commerciales-a-vendre?page=", page_result)
  link <- paste0("https://www.expat-dakar.com/maisons-a-vendre?page=", page_result)

  
  
  
  
  
  expart_appart <- read_html(link)
  
  link_second <- expart_appart %>% 
    html_nodes(".listings-cards__list-item") %>% 
    html_node("a") %>% 
    html_attr("href")
  
  adress <- expart_appart %>%
    html_nodes(".listing-card__header__location") %>%
    html_text()
  
  produit <- expart_appart %>%
    html_nodes(".listing-card__header__title") %>%
    html_text()
  
  caracteristique <- expart_appart %>%
    html_nodes(".listing-card__header__tags") %>%
    html_text()
  
  date_pub <- expart_appart %>%
    html_nodes(".listing-card__header__date") %>%
    html_text()
  
  prix <- expart_appart %>%
    html_nodes(".listing-card__price__value") %>%
    html_text()
  
  chambre_taille <- expart_appart %>%
    html_nodes(".listing-card__header__tags") %>%
    html_text()
  
  # Check lengths of vectors and pad with NA if necessary
  max_length <- max(length(link_second), length(adress), length(produit), length(caracteristique), length(date_pub), length(prix), length(chambre_taille))
  
  link_second <- c(link_second, rep(NA, max_length - length(link_second)))
  adress <- c(adress, rep(NA, max_length - length(adress)))
  produit <- c(produit, rep(NA, max_length - length(produit)))
  caracteristique <- c(caracteristique, rep(NA, max_length - length(caracteristique)))
  date_pub <- c(date_pub, rep(NA, max_length - length(date_pub)))
  prix <- c(prix, rep(NA, max_length - length(prix)))
  chambre_taille <- c(chambre_taille, rep(NA, max_length - length(chambre_taille)))
  
  expart_dakar <- rbind(expart_dakar, data.frame(link_second, adress, produit, caracteristique, date_pub, prix, chambre_taille))
  
  print(paste0("Page ", page_result, " processed."))
}

# View the resulting data frame
view(expart_dakar)

# Enregistrer le data frame dans un fichier CSV
#write.csv(expart_dakar, "Appart_Locate.csv", row.names = FALSE)
#write.csv(expart_dakar, "Appart_meub.csv", row.names = FALSE)
#write.csv(expart_dakar, "Terrain_vendre.csv", row.names = FALSE)
#write.csv(expart_dakar, "maison_louer.csv", row.names = FALSE)
#write.csv(expart_dakar, "appartement_a_vendre.csv", row.names = FALSE)
#write.csv(expart_dakar, "propriete_commerciales_a_vendre.csv", row.names = FALSE)
#write.csv(expart_dakar, "chambre_a_louer.csv", row.names = FALSE)
#write.csv(expart_dakar, "propriétes_commerciales_louer.csv", row.names = FALSE)
write.csv(expart_dakar, "maisons_vendre.csv", row.names = FALSE)




