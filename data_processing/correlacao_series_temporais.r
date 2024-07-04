# Carregar pacotes
library(rbcb)
library(ggplot2)

# Carregar dados
tabela <- rbcb::get_series(
  code = c("ipca" = 433, "selic" = 4390), 
  start_date = "2005-01-01", 
  end_date = "2023-01-01"
  )

# Gráfico de dispersão
ggplot2::ggplot() +
  ggplot2::aes(x = tabela$ipca$ipca, y = tabela$selic$selic) +
  ggplot2::geom_point()

# Correlação de Pearson (função pronta)
cor(tabela$ipca$ipca, tabela$selic$selic)

# Correlação de Pearson (função manual)
correlacao <- function (x, y) {
  xx <- x - mean(x)
  yy <- y - mean(y)
  r = sum(xx * yy) / sqrt(sum(xx^2) * sum(yy^2))
  return(r)
}
correlacao(tabela$ipca$ipca, tabela$selic$selic)
