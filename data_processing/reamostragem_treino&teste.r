
# Pacotes -----------------------------------------------------------------


# Carregar pacotes
library(readr)
library(splitTools)
library(glue)
library(dplyr)
library(rbcb)



# Dados -------------------------------------------------------------------


# Importar dados (fonte PNADC/IBGE)
tabela <- readr::read_csv(file = "pnadc202204.csv")
head(tabela)



# Amostragem aleatória simples --------------------------------------------


# Separação treino-validação-teste por amostragem aleatória simples
set.seed(1984)
particoes <- splitTools::partition(
  y = tabela$V2007,
  p = c(treino = 0.6, validacao = 0.2, teste = 0.2),
  type = "basic"
  )

# Imprimir nº de linhas total e proporção da categoria de cada amostra
proporcoes <- function(df, estrato = NULL, tipo) {
  n_df = nrow(df)
  h_m = table(df[c("V2007", estrato)])
  print(glue::glue("Total: {n_df} ({tipo})"))
  print(as.data.frame(h_m) |> dplyr::mutate(proporcao = Freq / n_df))
}

proporcoes(tabela, tipo = "Completa")
proporcoes(tabela[particoes$treino, ], tipo = "Treino")
proporcoes(tabela[particoes$validacao, ], tipo = "Validação")
proporcoes(tabela[particoes$teste, ], tipo = "Teste")



# Amostragem aleatória estratificada --------------------------------------


# Separação treino-validação-teste por amostragem aleatória estratificada
particoes <- splitTools::partition(
  y = tabela$V3001,
  p = c(treino = 0.6, validacao = 0.2, teste = 0.2),
  type = "stratified"
  )

# Imprimir nº de linhas total e proporção da categoria de cada amostra
proporcoes(tabela, estrato =  "V3001", tipo = "Completa")
proporcoes(tabela[particoes$treino, ], estrato =  "V3001", tipo = "Treino")
proporcoes(tabela[particoes$validacao, ], estrato =  "V3001", tipo = "Validação")
proporcoes(tabela[particoes$teste, ], estrato =  "V3001", tipo = "Teste")



# Separação treino-teste para séries temporais ----------------------------


# Dados de exemplo
tabela <- rbcb::get_series(
  code = c("ipca" = 433),
  start_date = "2000-01-01",
  end_date = "2022-12-01"
  )
tabela |> head() |> print()

# Separação treino-teste por tempo
teste <- tabela |>
  dplyr::arrange(date) |>
  dplyr::slice_tail(n = 12)
treino <- tabela |>
  dplyr::filter(!date %in% teste$date)

# Imprimir final/inicio de cada amostra
tail(treino)
head(teste)
