#' Information about Counties in California
#'
#' This data provides a list of counties in California
#' with information of name, population in 2010 ans 2019, and land area.
#'
#' @format The ca data frame contains 55 observations on 4 variables.
#' \describe{
#'   \item{City}{City Name}
#'   \item{Pop10}{Population in Person}
#'   \item{Pop19}{Population in Person}
#'   \item{Area(km^2)}{Area in Sqaured Kilometers}
#'}
#' @source \url{https://en.wikipedia.org/wiki/List_of_cities_and_towns_in_California}
"ca"



#' Average Heights and Weights for American Women
#'
#' This data contains both information from ca and pp19 and
#' information from Yelp API, such as the number of restaurants, average rating,
#' average review counts, best restaurants' name, rating, and review counts.
#' New variables of average number of resturants per person, average number of
#' resturants per square kilometers for each county in California are also included.
#'
#' @format The Rest_In_Towns data frame contains 55 observations on 13 variables.
#' \describe{
#'   \item{City}{City Name}
#'   \item{Pop10}{Population in Person}
#'   \item{Pop19}{Population in Person}
#'   \item{Area(km^2)}{Area in Sqaured Kilometers}
#'   \item{rest_num}{Number of Chinese Restaurants}
#'   \item{avg_rat}{Average Rating of Chinese Restaurants}
#'   \item{avg_rev}{Average Number of Review Counts of Chinese Restaurants}
#'   \item{best_rest}{Name of Chinese Restaurants with the Highest Rating}
#'   \item{best_rest_rat}{Rating of the Best Chinese Restaurant}
#'   \item{best_rest_rev}{Review Counts for the Best Chinese Restaurant}
#'   \item{num_res_per_capita10}{Number of Chinese Restaurants Per Person using Population in 2010}
#'   \item{num_res_per_capita19}{Number of Chinese Restaurants Per Person using Population in 2019}
#'   \item{num_res_per_area}{Number of Chinese Restaurants Per Squared Kilometers}
#' }
#' @source \url{https://api.yelp.com}
"Rest_In_Towns"
