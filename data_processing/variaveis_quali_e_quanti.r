# Carrega pacotes
library(basedosdados)
library(dplyr)

# Defina o seu projeto no Google Cloud
set_billing_id("asjkaskasjk")

# Para carregar o dado direto no R
tabela <- bdplyr("mundo_transfermarkt_competicoes.brasileirao_serie_a") |>
  dplyr::filter(ano_campeonato %in% c(2020, 2021)) |>
  collect()
