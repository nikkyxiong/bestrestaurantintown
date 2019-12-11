#' Plot_CA
#'
#' This function plots one scatterplot about the population in 2010
#' and the area of counties in Californiawith the best fitting line
#' for the data frame, ca.
#'
#' @export
#' @examples
#' plot_ca()

plot_ca <- function(){
    pop_area <- ggplot2::ggplot(ca, ggplot2::aes(x = Pop10, y = `Area (km^2)`)) +
        ggplot2::geom_point() +
        ggplot2::stat_smooth(method = "lm",
                             col = "grey",
                             se = FALSE,
                             size = 0.5) +
        ggplot2::labs(title = "Population vs Area of Counties in California")
    print(pop_area)
}
