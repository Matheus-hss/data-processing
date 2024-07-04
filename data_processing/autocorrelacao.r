# Carregar pacotes
library(rbcb)
library(ggplot2)
library(fabletools)
library(feasts)

# selic
selic <- rbcb::get_series(
  code = c("selic" = 4390), 
  start_date = "2005-01-01",
  end_date = "2023-01-01"
) |> 
  # é necessário alterar o tipo da coluna de data para yearmonth
  dplyr::mutate(date = tsibble::yearmonth(date)) |> 
  # transforma a classe para tsibble
  tsibble::as_tsibble(index = date)

# ipca
ipca <- rbcb::get_series(
  code = c("ipca" = 433), 
  start_date = "2005-01-01",
  end_date = "2023-01-01"
)  |> 
  # é necessário alterar o tipo da coluna de data para yearmonth
  dplyr::mutate(date = tsibble::yearmonth(date)) |> 
  # transforma a classe para tsibble
  tsibble::as_tsibble(index = date)

# Calcula o ACF do IPCA
feasts::ACF(ipca, y = ipca, lag_max = 24)

# Calcula o ACF do IPCA e Plota
feasts::ACF(ipca, y = ipca, lag_max = 24) |> 
  fabletools::autoplot() +
  ggplot2::labs(title = "ACF IPCA")

# Calcula o ACF do selic
feasts::ACF(selic, y = selic, lag_max = 24)

# Calcula o ACF do IPCA e Plota
feasts::ACF(selic, y = selic, lag_max = 24) |> 
  fabletools::autoplot() +
  ggplot2::labs(title = "ACF Selic")
