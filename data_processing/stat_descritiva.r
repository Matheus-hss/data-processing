# Carregar pacotes
library(basedosdados)
library(dplyr)
library(datawizard)

# Projeto do Google Cloud
set_billing_id("estatisticas-descritivas") # veja docs p/ obter um ID

# Coleta de dados de exemplo pela BaseDosDados.org
tabela <- bdplyr("mundo_transfermarkt_competicoes.brasileirao_serie_a") |> 
  dplyr::filter(ano_campeonato == 2020) |> 
  collect()

# Estatísticas descritivas
describe_distribution(tabela)
