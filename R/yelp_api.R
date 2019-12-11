#' Yelp Fusion API
#'
#' This function requests information about Chinese resturants
#' in one California county on Yelp through Yelp Fusion API.
#' After some analysis, this function returns a data frame with
#' information about the average rating and average review counts
#' for Chinese resturant in the county, along with the name,
#' rating, and review counts of the best-rated Chinese resturant.
#'
#' @param county the county name in California
#' @param Yelp_key User's key for Yelp API
#' @return information from Yelp about the Chinese resturants in the County
#' @export
#' @examples
#' yelp_api("San Diego", "1MHyP9EJgVnXGh7yea0h26Zy2Mf5VQSeyEpl9bvPqgjFmP-au40nu066EI8m4lR4Ky9N7AgTl5xJhtIvTs1ai4txyl4TMlqZp2UjDd-B_-b39DvrjTvhT_t9-a3lXXYx")


yelp_api <- function(county = "San Deigo", Yelp_key = "1MHyP9EJgVnXGh7yea0h26Zy2Mf5VQSeyEpl9bvPqgjFmP-au40nu066EI8m4lR4Ky9N7AgTl5xJhtIvTs1ai4txyl4TMlqZp2UjDd-B_-b39DvrjTvhT_t9-a3lXXYx") {
    query_params = list(limit = 50,
                        location = county,
                        term = "Chinese")
    baseurl <- "https://api.yelp.com"
    endpoint = paste0(baseurl, "/v3/businesses/search")
    request <- httr::GET(endpoint, query = query_params,
                         httr::add_headers(Authorization = paste("Bearer", Yelp_key)))
    if (httr::http_status(request)$category != "Success") {
        stop("You status is bad: ", httr::http_status(request)$reason)
    }
    result <- jsonlite::fromJSON(httr::content(request, as = "text"))$businesses

    if(class(result) == "data.frame") {
    result <- result%>%
        dplyr::select(name, review_count, rating) %>%
        dplyr::arrange(desc(rating), desc(review_count)) %>%
        dplyr::mutate(ave_rat = mean(rating, na.rm = T),
               ave_rev = mean(review_count, na.rm = T),
               best_rest = result$name[1],
               best_rest_rat = result$rating[1],
               best_rest_rev = result$review_count[1],
               rest_num = nrow(result),
               County = county) %>%
        spam::head(1) %>%
        dplyr::select(County, rest_num,ave_rat, ave_rev,
               best_rest, best_rest_rat, best_rest_rev)
    } else {
        result <- data.frame(County = county, rest_num = 0,
                             ave_rat = 0, ave_rev = 0, best_rest = 0,
                             best_rest_rat = 0, best_rest_rev = 0)
        }
    return(result)
}
