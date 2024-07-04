
# Pacotes -----------------------------------------------------------------

# Carregar pacotes
library(rbcb)
library(ggplot2)
library(feasts)
library(tsibble)
library(fabletools)
library(dplyr)


# Dados de exemplo --------------------------------------------------------

# Coleta de dados
tabela <- rbcb::get_series(
  code = c("ipca"= 433),
  start_date = "2000-01-01", 
  end_date = "2022-12-01"
  )


# Gráfico de linha --------------------------------------------------------

# Plota gráfico
tabela |>
  ggplot2::ggplot() +
  ggplot2::aes(x = date, y = ipca) +
  ggplot2::geom_line()


# Gráfico de sazonalidade -------------------------------------------------

# Estrutura de dados
tabela_ts <- tabela |>
  dplyr::mutate(data = tsibble::yearmonth(date)) |>
  tsibble::as_tsibble(index = "data")

# Plota gráfico
feasts::gg_season(tabela_ts, ipca)


# Gráfico de decomposição -------------------------------------------------

# Estima modelo e plota gráfico
tabela_ts |>
  fabletools::model(stl = feasts::STL(ipca)) |>
  fabletools::components() |>
  fabletools::autoplot()


# Gráfico de autocorrelação -----------------------------------------------

# Plota gráfico
feasts::gg_tsdisplay(data = tabela_ts, y = ipca, plot_type = "partial")
