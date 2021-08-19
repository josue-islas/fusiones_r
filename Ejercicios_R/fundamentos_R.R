#Creacion de vectores
vector_numerico <- c(5,6,7,8,9,10,-5,3.4546)

#Todas las entradas se convierten a tipo caracter
vector_char <- c(5,6,7,8,9,10,'-5,3.4546')

str(vector_char) #A todos los valores los pone entre comillas porque ahora todos son caracter

#Para llenar el vector con numeros consecutivos
vector_numerico2 <- c(1:5, -11)

#Vector caracter
vector_char2 <- c('Hola', 'Adios', 'como estas?')

#Vector logico
vector_logico <- c(TRUE, TRUE, TRUE, FALSE, FALSE)
str(vector_logico)

#_______ACCEDER A LAS ENTRADAS
vector_numerico[1]
#Para obtener la logitud del vector
length(vector_numerico)
#Para traer ultima posicion y valor
vector_numerico[length(vector_numerico)]
#Traer varios valores de las posiciones que le indiquemos
vector_numerico[2:4]
#Para traer mas datos, a parte del x:x
vector_numerico[c(2:4,7)]
#Traer todas las entradas a excepcion de la primera y la ultima
vector_numerico[c(-1,-7)]
      #Nos saltamos el primer dato
vector_char2[c(-1)]