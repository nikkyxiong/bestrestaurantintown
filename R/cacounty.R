#' CACounty
#'
#' This function webscrapes a list of cities and towns in California
#' with information of name, population in 2010, and land area.
#' After combining this dataset with another dataset contains
#' the population for cities and towns in California in 2019,
#' this function groups information from city level to county level.
#'
#' @return A data frame with all the information about counties in California
#' @export
#' @examples
#' cacounty()

cacounty <- function(){
    options(warn=-1)
    url <- "https://en.wikipedia.org/wiki/List_of_cities_and_towns_in_California"
    wiki_html <- xml2::read_html(url)
    sortable_nodes <- rvest::html_nodes(wiki_html, ".sortable")
    df10 <- sortable_nodes %>%
        rvest::html_table(header = T, fill = T) %>%
        as.data.frame()
    df10 <- df10 %>%
        dplyr::select(City = Name, County,
               Pop10 = Population..2010..1..8..9., Area = Land.area.1..1)
    df10 <- df10[-c(1),]

    for (i in 1:482) {
        df10$Pop10[i] <- stringr::str_replace_all(df10$Pop10[i], ",", "")
    }

    ca <- dplyr::left_join(df10, pp19, by = "City")
    ca$Pop10 <- as.numeric(ca$Pop10)
    ca$Area <- as.numeric(df10$Area)
    ca <- ca %>%
        dplyr::group_by(County) %>%
        dplyr::summarise(Pop10 = sum(Pop10, na.rm = T),
                  Pop19 = sum(Pop19, na.rm = T),
                  `Area (km^2)` = sum(Area, na.rm = T))
    return(ca)
}
