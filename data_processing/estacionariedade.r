# Carregar pacotes
library(rbcb)
library(aTSA)

# Dados de exemplo
# selic
selic <- rbcb::get_series(
  code = c("selic" = 4390), 
  start_date = "2005-01-01",
  end_date = "2023-01-01"
)

# Teste ADF
aTSA::adf.test(x = selic$selic, nlag = 3)

# Teste KPSS
aTSA::kpss.test(x = selic$selic)

# ipca
ipca <- rbcb::get_series(
  code = c("ipca" = 433), 
  start_date = "2005-01-01",
  end_date = "2023-01-01"
)

# Teste ADF
aTSA::adf.test(x = ipca$ipca, nlag = 3)

# Teste KPSS
aTSA::kpss.test(x = ipca$ipca)

