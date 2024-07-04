# Carregar pacotes
library(fitdistrplus)

# Simular variável contínua com distribuição normal
variavel <- rnorm(n = 1984, mean = 0, sd = 1)

# Encontrar distribuição da variável
descdist(data = variavel)
