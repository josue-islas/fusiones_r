#Contruir un vector numerico con 10 entradas de los numeros 5:14
vector_num <- c(5:14)


#Obtenga la longitud del vector
length(vector_num)


#Uso del [] para acceder a la primera posicion
vector_num[1]


#Uso de la funcion length para acceder a la ultima posicion del vector 
vector_num[length(vector_num)]


#Agregue una nueva entrada con el numero 23 al vector
vector_num <- append(x = vector_num, values = 23, after = length(vector_num))

length(vector_num)

vector_num[length(vector_num)]

#Definimos 2 vectores
#Para realizar operaciones, los vectores deben ser de la misma longitud

vector_num1 <- c(1:4)
vector_num2 <- c(2:5)

#Suma de dos vectores
suma_vectores <- vector_num1 + vector_num2

#R suma cada entrada, 1-1, 2-2, 3-3 ... n-n

#Multiplicacion de dos vectores
mult_vectores <- vector_num1 * vector_num2


#Resta de dos vectores
resta_vectores <- vector_num1 - vector_num2


#divicion de dos vectores
div_vectores <- vector_num1 / vector_num2


#Producto escalar de dos vectores (suma de los productos de las entradas)
esc_vectores <- vector_num1 %*% vector_num2

#Suma de todas las entradas de un vector
sum(vector_num1)
sum(vector_num2)
#Producto escalar v2
sum(vector_num1 * vector_num2)

#----------------------------
#         LIBRERIA
#----------------------------
#Contienen diversas funciones, una funcion es aquella palabra reservada que tiene codigo que podemos resiclar una y ptra vez

source(file = 'Docs//archivos_r//curso_r//3_8_Librerias.R') #Para ejecutar librias
source(file = 'Cursos/Curso_R/3. Fundamentos de R/Librerias.R')
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
#Ejercicio
#While mientras valor <= 5 y se cumpla cuando llegue  a 5
#Guardar los valores en una variables llamada acumulado

acumulado <- 0 
contador <- 1
while(contador <= 5){
  acumulado <- acumulado + contador
  contador <- contador + 1
}

#Realize un ciclo for 1:5 y cuando termine diga ;este es el ultimo valor del item

for(i in 1:5){
  if(i == 5){
    print(paste('Este es el ultimo item: ', i, sep = ' '))
  }
}
