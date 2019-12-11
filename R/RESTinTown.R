#' Resturant_in_Town
#'
#' This function requests information about Chinese resturants on Yelp
#' through Yelp Fusion API by each county in California. In the end,
#' this function returns a data frame that contains both information
#' from cacounty and yelp_api, along with new variables of
#' average number of resturants per person,
#' average number of resturants per square kilometers.
#'
#' @param Yelp_key User's key for Yelp API
#' @return a list of all information about a county in California
#' @export
#' @examples
#' RESTinTown("1MHyP9EJgVnXGh7yea0h26Zy2Mf5VQSeyEpl9bvPqgjFmP-au40nu066EI8m4lR4Ky9N7AgTl5xJhtIvTs1ai4txyl4TMlqZp2UjDd-B_-b39DvrjTvhT_t9-a3lXXYx")

RESTinTown <- function(Yelp_key = "1MHyP9EJgVnXGh7yea0h26Zy2Mf5VQSeyEpl9bvPqgjFmP-au40nu066EI8m4lR4Ky9N7AgTl5xJhtIvTs1ai4txyl4TMlqZp2UjDd-B_-b39DvrjTvhT_t9-a3lXXYx") {
    Rest_In_Towns <- data.frame()
    for (i in 1:55) {
        Rest_In_One_Town <- yelp_api(ca$County[i], Yelp_key)
        Rest_In_Towns <- rbind(Rest_In_Towns, Rest_In_One_Town)
    }

    Rest_In_Towns <- dplyr::left_join(ca, Rest_In_Towns, by = "County")
    Rest_In_Towns <- Rest_In_Towns %>%
        dplyr::mutate(num_res_per_capita10 = Rest_In_Towns$rest_num/Rest_In_Towns$Pop10,
                      num_res_per_capita19 = Rest_In_Towns$rest_num/Rest_In_Towns$Pop19,
                      num_res_per_area = Rest_In_Towns$rest_num/Rest_In_Towns$`Area (km^2)`) %>%
        dplyr::arrange(desc(rest_num), desc(ave_rat), desc(ave_rev))

    return(Rest_In_Towns)
}
