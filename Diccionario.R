#Incio del programa 
variable_numerica <- 5
variable_caracter <- 'Mi primer variable caracter'
variable_fecha <- as.Date('2021-05-08',format = '%Y-%m-%d')

#Imprimir variables 
str(variable_fecha)

#Usando las variables (operaciones)
#__________Variable numerica
variable_numerica1 <- 7
variable_numerica2 <- variable_numerica + 7
variable_numerica3 <- variable_numerica2 + variable_numerica1

#__________Variables caracter
variable_caracter <- paste(variable_caracter, 'en 2021', sep = ' ')
#______________Fecha
variable_fecha2 <- as.Date('2021-04-08')
variable_fecha3 <- as.numeric(variable_fecha - variable_fecha2) 
variable_fecha3 #Print

#Operacdores logicos

5 > 7 #El resultado de esta operacion es 'FALSE' ya que es una variable logica

5 > 4 & 7 > 10

TRUE & FALSE = FALSE

variable_logica <- (5 > 4 | 7 > 10) & (6 > 5)

5 != 6 #Le preguntamos (false)
5 != 5 #True

# '=' es de asignacion y '==' es de comparacion
5 == 5 #True

#WHILE
i <- 1

while (i <= 10) {
  print(i)
  i <- i + 1
}
print('El bucle ha finalizado')




