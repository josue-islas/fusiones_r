              ###Optimización de portafolios con R###
              ##    Ana Lorena Jiménez Preciado    ##
              #######################################


#Paqueterías necesarias
              
install.packages("tidyr")
              
            

library(tidyquant) # Para descargar los datos
library(tidyr) # Permite manipular y transformar los datos
library(plotly) # Para hacer gráficos chulos
library(recipes)
library(timetk) # Para manipular las series de tiempo
library(quantmod) # Para descargar los datos
library(xts) #Convertir dataframes en series de tiempo
library(tseries) #Trabajar con series de tiempo
library(forecast) #Pronosticar series de tiempo
library(timeSeries) #Trabajar con series de tiempo
library(tframePlus) #Trabajar con series de tiempo
library(ggplot2) #Gráficos coquetos
library(dplyr) #Gráficos coquetos y dinámicos
library(plotly) #Gráficos coquetos y dinámicos
library(hrbrthemes) #Elegir diferentes diseños para gráficos
library(ggthemes) #Elegir diferentes diseños para gráficos
library(tidyverse)  # Permite manipular y transformar los datos
library(dygraphs) #Gráficos dinámicos
library(gridExtra) #Gráficos dinámicos
library(corrplot)
###SELECCIONAR LOS DATOS BAJANDOLOS DE INTERNET###



TickerList<- c("AZN", "BNGO", "MRNA", "NVAX", "PFE") # hat = gorrito, LOS INDICES SIEMPRE LLEVAN HAT

  LosPreciosQueQuiero<- NULL
        for (Ticker in TickerList)
        LosPreciosQueQuiero <- cbind(LosPreciosQueQuiero, #cbind me permite combinar vectores de datos
        getSymbols(Ticker, from="2020-06-01",  auto.assign =F ,src='yahoo') [,4]) #Mantiene solo el precio de cierre

        View(LosPreciosQueQuiero)


### Quita todos los NA (en caso de que no haya cotizado el activo)

      PreciosCierre <- LosPreciosQueQuiero[apply(LosPreciosQueQuiero ,1,function(x) all(!is.na(x))),]
      View(PreciosCierre)

      colnames(PreciosCierre)<- c("AZN", "BNGO", "MRNA", "NVAX", "PFE")
      View(PreciosCierre)



      AZN<-PreciosCierre[,1]
      BNGO<-PreciosCierre[,2]
      MRNA<-PreciosCierre[,3]
      NVAX<-PreciosCierre[,4]
      PFE<-PreciosCierre[,5]


### Gráficas a niveles (precios de cierre)
### Colores en R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
      #par(mfrow=c(1,1))

      AZN_niveles <- ggplot(AZN, aes(x=Index, y=AZN)) +
        ggtitle("Precio de Cierre Amazon: junio 2020 - septiembre 2021") +
        geom_line(color="salmon") +
        xlab("Fecha")+
        ylab("Precio de cierre")

      AZN_niveles              #Gráfico con ggplot
      ggplotly(AZN_niveles)    #Gráfico con ggplotly


      BNGO_niveles<- ggplot(BNGO, aes(x=Index, y=BNGO)) +
        ggtitle("Precio de Cierre BNGO: junio 2020 - septiembre 2021") +
        geom_line(color="chartreuse3") +
        xlab("Fecha")+
        ylab("Precio de cierre")

      BNGO_niveles
      ggplotly(BNGO_niveles)

      MRNA_niveles <- ggplot(MRNA, aes(x=Index, y=MRNA)) +
        ggtitle("Precio de Cierre MRNA: junio 2020 - septiembre 2021") +
        geom_line(color="deeppink4") +
        xlab("Fecha")+
        ylab("Precio de cierre")

      MRNA_niveles              #Gráfico con ggplot
      ggplotly(MRNA_niveles)    #Gráfico con ggplotly


      NVAX_niveles <- ggplot(NVAX, aes(x=Index, y=NVAX)) +
        ggtitle("Precio de Cierre NVAX: junio 2020 - septiembre 2021") +
        geom_line(color="darkorchid3") +
        xlab("Fecha")+
        ylab("Precio de cierre")

      NVAX_niveles              #Gráfico con ggplot
      ggplotly(NVAX_niveles)    #Gráfico con ggplotly


      PFE_niveles <- ggplot(PFE, aes(x=Index, y=PFE)) +
        ggtitle("Precio de Cierre PFE: junio 2020 - septiembre 2021") +
        geom_line(color="coral3") +
        xlab("Fecha")+
        ylab("Precio de cierre")

      PFE_niveles              #Gráfico con ggplot
      ggplotly(PFE_niveles)    #Gráfico con ggplotly



#Descarga los datos para el portafolio

tickers <- c('AZN', 'BNGO', 'MRNA', 'NVAX', 'PFE')

precios <- tq_get(tickers,
                     from = '2020-06-01',
                     to = '2021-09-01',
                     get = 'stock.prices')
#Calcula los rendimientos logarítmicos de los precios

log_ret_tidy <- precios %>% #Pipe
  group_by(symbol) %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = 'daily',
               col_rename = 'ret',
               type = 'log')

#Vemos las primeras columnas

head(log_ret_tidy)


#Cambiamos el formato tidy a series de tiempo

log_ret_xts <- log_ret_tidy %>%
  spread(symbol, value = ret) %>%
  tk_xts()

#Vemos las primeras columnas del objeto xts

head(log_ret_xts)

#Calcula el rendimiento promedio de las series

mean_ret <- colMeans(log_ret_xts)
print(round(mean_ret, 5))  #redondea a 5 decimales

#Calcula la matriz de covarianza y anualiza los datos

cov_mat <- cov(log_ret_xts) * 252
print(round(cov_mat,4))   #redondea a 4 decimales


#Calcula la matriz de correlación
cor_mat <- cor(log_ret_xts)
corrplot.mixed(cor_mat)

print(round(cor_mat,4))   #redondea a 4 decimales


#Asignemos pesos aleatorios al portafolio

wts <- runif(n = length(tickers)) #runif genera números aleatorios por intervalos
print(wts)

print(sum(wts)) #Debemos corregir la suma de los pesos

#Dividimos los pesos entre la suma de los pesos para ajustar

wts <- wts/sum(wts)
print(wts)
sum(wts)

#Añadimos los pesos a nuestros portafolio con los rendimientos anualizados

port_returns <- (sum(wts * mean_ret) + 1)^252 - 1
print(port_returns)

#Añadimos el riesgo al portafolio (desviación estándar) anualizado

port_risk <- sqrt(t(wts) %*% (cov_mat %*% wts)) #%*% permite multipliciar matrices
print(port_risk)

                        #Sharpe Ratio#

# Asumiendo una tasa de riesgo de 0%

sharpe_ratio <- port_returns/port_risk
print(sharpe_ratio)

## Cambiar la tasa manualmente a 0.25 u otro valor%

sharpe_modificado <- Return.excess(port_returns, Rf = .04)
print(sharpe_modificado)
sharpe_ratio_manual <- round(mean(sharpe_modificado)/port_risk, 4)
print(sharpe_ratio_manual)




              #Juntando todos los elementos#

# Calculate the random weights
wts <- runif(n = length(tickers))
wts <- wts/sum(wts)

# Rendimientos anualizados del portafolio
port_returns <- (sum(wts * mean_ret) + 1)^252 - 1

# Riesgo anualizado del portafolio
port_risk <- sqrt(t(wts) %*% (cov_mat %*% wts))

# Calculate the Sharpe Ratio
sharpe_ratio <- port_returns/port_risk

# Calcula Sharpe con cambio en tasa libre de riesgo

sharpe_modificado <- Return.excess(port_returns, Rf = .0025)
sharpe_ratio_manual <- round(mean(sharpe_modificado)/port_risk, 4)


print(wts)
print(port_returns)
print(port_risk)
print(sharpe_ratio)
print(sharpe_ratio_manual)

        #Simulación y optimización de portafolio#

num_port <- 10000 #10mil simulaciones

# Crea matrices para almacenar los pesos

all_wts <- matrix(nrow = num_port,
                  ncol = length(tickers))

# Crea un vector para guardar los rendimientos

port_returns <- vector('numeric', length = num_port)

# Crea un vector para guardar el riesgo o desviaciones

port_risk <- vector('numeric', length = num_port)

# Crea un vector para guardar el Sharpe con RF=0%

sharpe_ratio <- vector('numeric', length = num_port)


# Crea un vector para guardar el Sharpe con RF=0.25%


sharpe_ratio_manual <- vector('numeric', length = num_port)

# Hacemos el loop o ciclo

for (i in seq_along(port_returns)) {

  wts <- runif(length(tickers))
  wts <- wts/sum(wts)

  # Guarda todos los pesos en la matriz
  all_wts[i,] <- wts

  # Rendimientos del protafolio

  port_ret <- sum(wts * mean_ret)
  port_ret <- ((port_ret + 1)^252) - 1

  # Guarda los rendimientos
  port_returns[i] <- port_ret

  # Guarda las desviaciones
  port_sd <- sqrt(t(wts) %*% (cov_mat  %*% wts))
  port_risk[i] <- port_sd

  # Crea los portafolios con Sharpe 0%

  sr <- port_ret/port_sd
  sharpe_ratio[i] <- sr

  # Crea los portafolios con Sharpe 0.25%

  sr1 <- Return.excess(port_ret, Rf = .045)/port_sd
  sr2 <- mean(sr1)/port_sd
  sharpe_ratio_manual[i] <- sr2
  }

# Resultados de los portafolios

portfolio_values <- tibble(Return = port_returns,
                           Risk = port_risk,
                           SharpeRatio = sharpe_ratio)


# Junta todos los pesos calculados

all_wts <- tk_tbl(all_wts)
colnames(all_wts) <- colnames(log_ret_xts)

# Muestra todos los resultados
portfolio_values <- tk_tbl(cbind(all_wts, portfolio_values))
head(portfolio_values)

# Portafolio de mínima varianza

min_var <- portfolio_values[which.min(portfolio_values$Risk),]

p <- min_var %>%
  gather(AZN:PFE, key = Asset,
         value = Weights) %>%
  mutate(Asset = as.factor(Asset)) %>%
  ggplot(aes(x = reorder(Asset,Weights), y = Weights, fill = Asset)) +
  geom_bar(stat = 'identity') +
  theme_minimal() +
  labs(x = 'Acciones', y = 'Pesos', title = "Portafolio de mínima varianza") +
  scale_y_continuous(labels = scales::percent)

min_var
ggplotly(p)

# Portafolio con mayor Sharpe
max_sr <- portfolio_values[which.max(portfolio_values$SharpeRatio),]

q <- max_sr %>%
  gather(AZN:PFE, key = Asset,
         value = Weights) %>%
  mutate(Asset = as.factor(Asset)) %>%
  ggplot(aes(x = reorder(Asset,Weights), y = Weights, fill = Asset)) +
  geom_bar(stat = 'identity') +
  theme_minimal() +
  labs(x = 'Acciones', y = 'Pesos', title = "Mejor portafolio con Sharpe") +
  scale_y_continuous(labels = scales::percent)

max_sr
ggplotly(q)

# Frontera eficiente

#plot(portfolio_values)

e <- portfolio_values %>%
  ggplot(aes(x = Risk, y = Return, color = SharpeRatio)) +
  geom_point() +
  theme_classic() +
  scale_y_continuous(labels = scales::percent) +
  scale_x_continuous(labels = scales::percent) +
  labs(x = 'Riesgo anualizado',
       y = 'Rendimiento anualizado',
       title = "Optimización de portafolios y frontera eficiente") +
  geom_point(aes(x = Risk,
                 y = Return), data = min_var, color = 'red') +
  geom_point(aes(x = Risk,
                 y = Return), data = max_sr, color = 'red')
  #annotate('text', x = 0.20, y = 0.42, label = "Mejor Sharpe") +
  #annotate('text', x = 0.18, y = 0.01, label = "Portafolio de mínima varianza") +
  #annotate(geom = 'segment', x = 0.14, xend = 0.135,  y = 0.01,
    #       yend = 0.06, color = 'red', arrow = arrow(type = "open")) +
  #annotate(geom = 'segment', x = 0.22, xend = 0.2275,  y = 0.405,
     #      yend = 0.365, color = 'red', arrow = arrow(type = "open"))


ggplotly(e)
