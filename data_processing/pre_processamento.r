
# Pacotes -----------------------------------------------------------------

# Carregar pacotes
library(readr)
library(splitTools)
library(ggplot2)
library(dplyr)
library(tidyr)



# Dados -------------------------------------------------------------------

# Importar dados (fonte PNADC/IBGE)
tabela <- readr::read_csv(file = "pnadc202204.csv")
head(tabela)



# Reamostragem ------------------------------------------------------------

# Separação treino-teste por amostragem aleatória simples
set.seed(1984)
particoes <- splitTools::partition(
  y = tabela$V2007,
  p = c(treino = 0.7, teste = 0.3),
  type = "basic"
  )

# Amostra de teste
tabela_teste <- tabela[particoes$teste, ]

# Amostra de treino
tabela_treino <- tabela[particoes$treino, ]

tail(tabela_treino)
head(tabela_teste)



# Valores extremos --------------------------------------------------------

# Plotar bloxplot para analisar outliers
tabela_treino |>
  ggplot2::ggplot() +
  ggplot2::aes(x = VD4035) +
  ggplot2::geom_boxplot()

# Remoção de outliers com regra IQR de Hyndman e Athanasopoulos (2021) e boxplot
tabela_treino |>
  dplyr::filter(
    !VD4035 < quantile(VD4035, 0.25, na.rm = TRUE) - 1.5 * IQR(VD4035, na.rm = TRUE) &
      !VD4035 > quantile(VD4035, 0.75, na.rm = TRUE) + 1.5 * IQR(VD4035, na.rm = TRUE)
    ) |>
  ggplot2::ggplot() +
  ggplot2::aes(x = VD4035) +
  ggplot2::geom_boxplot()



# Valores ausentes --------------------------------------------------------

# Calcula a proporção de valores ausentes
tabela_treino |>
  dplyr::summarise(prop_na = sum(is.na(VD4035)) / dplyr::n())

# Estatísticas descritivas antes da imputação
summary(tabela_treino$VD4035)

# Imputação de valores ausentes por média e Estatísticas descritivas
tabela_treino |>
  tidyr::replace_na(list(VD4035 = mean(tabela_treino$VD4035, na.rm = TRUE))) |>
  dplyr::select(VD4035) |>
  summary()
